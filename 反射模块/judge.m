%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

function judge = judge(location,peers,swi)
    load(location,"buildings");
    i=1;
    while(i<=size(peers,3))
        %遍历所有通信对,i是当前正在判断的通信对
        judge(i,1)=peers(3,1,i);
       j=1;
       l=2;
       while(j<=size(buildings.nd_lat,1))
           %遍历所有建筑物，j是当前正在判断的建筑物
           k=1;
           mark=0;
           while(k<size(buildings.nd_lat,2))
               %遍历此建筑物的点，k是当前正在判断的点
               if(buildings.nd_lat(j,k+1)~=0)
                   %这里采用一个办法转移了一下
                   %先算出与建筑物同一高度的点坐标,在判断此点与用户连线是否与建筑物边相交
                   if(swi==1)
                       %判断是否开启了开关
                       if(peers(2,:,1)==peers(1,:,2))
                           %检查输入的反射点的位置的格式是否正确
                           if(onLine(peers(2,1,1),peers(2,2,1),buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1)))
                               %检查是否在直线上
                               %写成函数
                               k=k+1;
                               continue;
                           end
                       end
                   end
                    mark=segmentIntersect(buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1),peers(1,1,i),peers(1,2,i),peers(2,1,i),peers(2,2,i));
                    if(mark==1)
                        intersection_point=intersection(buildings.nd_lon(j,k),buildings.nd_lat(j,k),buildings.nd_lon(j,k+1),buildings.nd_lat(j,k+1),peers(1,1,i),peers(1,2,i),peers(2,1,i),peers(2,2,i));
                        h=((peers(1,1,i)-intersection_point(1,1)+peers(1,2,i)-intersection_point(1,2))/(peers(1,1,i)-peers(2,1,i)+peers(1,2,i)-peers(2,2,i)))*(peers(1,3,i)-peers(2,3,i))+peers(2,3,i);
                        if(h>buildings.height(1,j))
                            mark=0;
                        else
                            break;
                        end
                    end
               else
                    break;
               end 
               k=k+1;
           end
           if(mark==1)
               judge(i,l)=buildings.id(1,j);
               l=l+1;
               %break;   %这个建筑物已经有遮挡了，就直接去判断下一个建筑物了
           end
           j=j+1;
       end
       i=i+1;
    end
end

