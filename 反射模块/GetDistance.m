function  [distance]=GetDistance(LON,LAT,newLon,newLat)
% 该函数用于已知一点A经纬度坐标和与一点B经纬度坐标
% 求得点A与点B间距离
%
% 输入：
%     LON：       A点经度
%     LAT:        A点纬度
%     newLon：    B点经度
%     newLat：    B点纬度
%
% 输出：
%     distance    两点之间距离（单位米）
%
%%
Ea = 6378137;%赤道半径
Eb = 6356725;%极地半径
ec = Eb + (Ea - Eb) * (90.0 -LAT) / 90.0;%从赤道到极地地球半径修正值
ed = ec * cos (LAT * pi / 180.0) ;%所在纬度的半径值
dx = (newLon * pi / 180.0 - LON * pi / 180.0) * ed;%经度跨度(由L=AR)加上原始经度,再将结果转化为角度
dy = (newLat * pi / 180.0 - LAT * pi / 180.0) * ec;%纬度跨度加上原始纬度，再将结果转化为角度
distance = sqrt(dx^2 + dy^2);
end


