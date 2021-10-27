function [outputArg1,outputArg2] = test(path)
%TEST 此处显示有关此函数的摘要
%   此处显示详细说明
    load(path,'buildings');
    hold on;
     for i=1:1:size(buildings.nd_lat,1)
         x=[];y=[];
         for j=1:1:size(buildings.nd_lat,2)
             if(buildings.nd_lat(i,j)==0)
                 break;
             end
             %plot(buildings.nd_lon(i,j),buildings.nd_lat(i,j),'*');
             x=[x,buildings.nd_lon(i,j)];
             y=[y,buildings.nd_lat(i,j)];
         end
         plot(x,y);
     end

%      for i=1:length(User)
%          user_x=User(i,1);
%          user_y=User(i,2);
%          plot(user_x,user_y,'o');
%      end
end