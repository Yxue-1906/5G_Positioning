function [User]=generateUser(matPath)
    load(matPath);
    R=getRadisu((buildings.bounds(1;1)+buildings.bounds(1;2))/2);
    baseLAT=min(buildings.bounds(1;1),buildings.bounds(1,2));
    baseLON=min(buildings.bounds(2;1),buildings.bounds(2,2));
    
end