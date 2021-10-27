                                                                                                                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数说明:
%此函数为外部调用入口,用于获取所有用户可能位置
%
%Input:.mat文件路径
%Output;包含所有可能用户的经纬度坐标的矩阵
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function User=getUser(matPath,d)
    location=fopen('User.txt','w');
    load(matPath,'buildings');  %从.mat读取buildings
    R=getRadius((buildings.bounds(1,1)+buildings.bounds(1,2))/2);
    SCALE=111122.19769899677;
    distance=d;
    LAT_5m=distance/SCALE;
    LON_5m=distance*360/(2*pi*R);
%     baseLat=min(buildings.bounds(1,1),buildings.bounds(1,2));
%     baseLon=min(buildings.bounds(2,1),buildings.bounds(2,2));
    
%     Length=(max(buildings.bounds(2,1),buildings.bounds(2,2))-baseLon)*2*pi*R/360;           %这是经度横跨的距离
%     Width=(max(buildings.bounds(1,1),buildings.bounds(1,2))-baseLat)*111122.19769899677;    %这是纬度横跨的距离
    
    %%%%%%%%%%%
    %将所有建筑物顶点转化为坐标
    %
    %buildingCo说明:
    %转化完成之后的building的顶点坐标,
    %从左到右三个参数分别为是
    %建筑物顶点编号,
    %1->经度/2->纬度,
    %建筑物id.
    %
    %%%%%%%%%%%
     for i=1:1:size(buildings.id,2)
         %i是建筑物id
         for j=1:1:size(buildings.nd_lat,2)
             %j是建筑物最多有多少个顶点
             if buildings.nd_lat(i,j)==0
                 %说明这个建筑物没这么多点,退出
                 break;
             else
                 %拼接建筑物顶点坐标
                 buildingCo(j,1,i)=buildings.nd_lon(i,j);
                 buildingCo(j,2,i)=buildings.nd_lat(i,j);
             end
         end
     end
    
    %生成用户并判断
    
%     for i=[0:5:Length]
%         %用户横坐标
%        for j=[0:5:Width]
%            %用户纵坐标
%            mark=0;
%           for k=1:1:size(buildings.id,2)
%               %建筑物的编号
%              if isInner(i,j,buildingCo(:,:,k))==1
%                  mark=1;
%                  break;
%              end
%           end
%           if(mark==0)
%               User=[User;[i,j]];
%           end
%        end
%     end
    
    
    User=[];
    count=0;
    mark=0;
    for i=[buildings.bounds(1,1):LON_5m:buildings.bounds(1,2)]
        %用户横坐标
        for j=[buildings.bounds(2,1):LAT_5m:buildings.bounds(2,2)]
            %用户纵坐标
            count=count+1;
            mark=0;
            for k=1:1:size(buildingCo,3)
                if isInner(i,j,buildingCo(:,:,k))==1
                    mark=1;
                    break;
                end
            end
             if (mark==0)
                 User=[User;[i,j]];
                 fprintf(location,'%.10f,%.10f\n',i,j);
%                  plot(i,j,'*r');
%              else
%                  plot(i,j,'*g');
             end
        end
    end
    
%     for i=1:1:size(User,1)
%         User(i,:)=getUserLatLon(User(i,1),User(i,2),R,baseLat,baseLon);
%     end
    
end
