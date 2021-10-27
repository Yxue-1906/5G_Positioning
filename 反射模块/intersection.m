function point=intersection(x1,y1,x2,y2,x3,y3,x4,y4)
    A=[y1-y2,x2-x1;y3-y4,x4-x3];
    b=[x2*y1-x1*y2;x4*y3-x3*y4];
    point=transpose(A\b);
end