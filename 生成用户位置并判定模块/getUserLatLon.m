%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数说明:
%此函数用于将用户坐标转换回经纬度
%
%Input:用户坐标,该纬度地球半径,基准经纬度
%Output;输出用户经纬度
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function returnvalue = getUserLatLon(x,y,R,baseLat,baseLon)
    Lon=x*360/(2*pi*R)+baseLat;
    Lat=y/111122.19769899677+baseLon;
    returnvalue=[Lat,Lon];
end

