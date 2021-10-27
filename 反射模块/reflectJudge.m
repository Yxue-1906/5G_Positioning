%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数说明:
%判断用户和基站通信对是否被遮挡
%
%Input:
%   buildings:建筑物顶点信息,参照示例文件
%   peers(;,:,i)=[  User.x,User.y,User.z
%                   Sta.x ,Sta.y ,Sta.z
%                   id    ,0     ,0     ]
%
%
%Output:输出一个judge二维矩阵，每行第一个是通信对id，若遮挡其后跟着遮挡的建筑物id
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ReflectJudge = reflectJudge(location,peers)
    load(location,'buildings');
    hold on;
    
    i=1;
    while(i<=size(peers,3))
        %draw the location of User and Sta;
        plot(peers(1,1,i),peers(1,2,i),"ro");
        plot(peers(2,1,i),peers(2,2,i),"go");
        %遍历所有通信对,i是当前正在判断的通信对
        ReflectJudge(i).User=peers(1,:,i);
        ReflectJudge(i).Sta=peers(2,:,1);
       j=1;
       l=1;
       while(j<=size(buildings.nd_lat,1))
           %遍历所有建筑物，j是当前正在判断的建筑物
           k=1;
           while(k<size(buildings.nd_lat,2))
               %遍历此建筑物的点，k是当前正在判断的点
               if(buildings.nd_lat(j,k+1)~=0)
                    mark=0;
                    assistPoint=assist(peers(2,1,i),peers(2,2,i),buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1));
                    assistPoint=[assistPoint,peers(2,3,i)];
                    mark=segmentIntersect(buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1),peers(1,1,i),peers(1,2,i),assistPoint(1,1),assistPoint(1,2));
%                     if(buildings.id(1,j)==265301998)
%                         foo=1;
%                         plot([buildings.nd_lon(j,k),buildings.nd_lon(j,k+1)],[buildings.nd_lat(j,k),buildings.nd_lat(j,k+1)],"r");
%                         plot(assistPoint,"r*");
%                     end
                    if(mark==1) 
                        %说明相交,有可能存在反射点
                        reflect_point=intersection(assistPoint(1,1),assistPoint(1,2),peers(1,1,i),peers(1,2,i),buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1));
                        h=((assistPoint(1,1)-reflect_point(1,1)+assistPoint(1,2)-reflect_point(1,2))/(assistPoint(1,1)-peers(2,1,i)+assistPoint(1,2)-peers(2,2,i)))*(peers(1,3,i)-peers(2,3,i))+peers(2,3,i);
                        if(h>buildings.height(1,j))
                            k=k+1;
                            continue;
                        end
                        reflect_point(1,3)=h;
                        %生成反射点
                        assistPeers(:,:,1)=[peers(1,:,i);reflect_point;1,0,0];
                        assistPeers(:,:,2)=[reflect_point;peers(2,:,i);2,0,0];
                        %拼接生成要判断遮挡的"信号对"
                        out=judge(location,assistPeers,1);
                        if(size(out,2)==1)
                            ReflectJudge(i).reflectPoint(l,:)=reflect_point;
                            plot(reflect_point(1,1),reflect_point(1,2),"r*");
                            lenth_horizen=GetDistance(assistPoint(1,1),assistPoint(1,2),peers(1,1,i),peers(1,2,i));
                            ReflectJudge(i).length(l,:)=sqrt(lenth_horizen*lenth_horizen+(assistPoint(1,3)-peers(1,3,i))*(assistPoint(1,3)-peers(1,3,i)));
                            l=l+1;
                        end
                    end
               else
                    break;
               end
               k=k+1;
           end
           j=j+1;
       end
       i=i+1;
    end
end