%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数说明:
%此函数用于将经纬度转换为基于基准经纬度的坐标
%
%Input:需要转换的经度,需要转换的纬度,基准经纬度,该纬度半径
%Output;输出坐标(x,y)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function returnvalue=getCoordinate(Lat,Lon,baseLat,baseLon,R)
%输入基准经纬度坐标以及需要生成坐标的点的经纬度
%输出坐标
    scale=111122.19769899677;
    x=(Lon-baseLon)*R*2*pi/360;
    y=(Lat-baseLat)*scale;
    returnvalue=[x,y];
end