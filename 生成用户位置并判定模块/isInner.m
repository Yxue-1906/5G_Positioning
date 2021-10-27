%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%函数说明:
%此函数用于判断一给定点是否在给定建筑物内(利用射线法)
%
%Input:给定点坐标,建筑物顶点序列
%Output:mark
%       1->
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [isinner] = isInner(x,y,vertixs)

    flag=0;
    i=1;
    
    while(i<=size(vertixs,1)-1)
        %vertixs(点编号,1->x,2->y)
        if(vertixs(i+1,1)==0)   %说明判完所有点了
            break;
        end
        if(vertixs(i,2)==vertixs(i+1,2))    %水平线跳过
            i=i+1;
            continue;
        end
        if((vertixs(i+1,2)==y&&vertixs(i+1,1)>=x)||(vertixs(i,2)==y&&vertixs(i,1)>=x))
            %如果相交于顶点
            if(vertixs(i+1,2)==y&&vertixs(i+1,1)>=x&&vertixs(i+1,2)>vertixs(i,2))
                flag=flag+1;
            end
            if(vertixs(i,2)==y&&vertixs(i,1)>=x&&vertixs(i,2)>vertixs(i+1,2))
                flag=flag+1;
            end
            %以上是判断交的顶点是否纵坐标更大
            i=i+1;
            continue;
        end
        if(segmentIntersect(x,y,max(vertixs(i,1),vertixs(i+1,1))+1,y,vertixs(i,1),vertixs(i,2),vertixs(i+1,1),vertixs(i+1,2))==1)
            flag=flag+1;
            i=i+1;
            continue;
        end
        i=i+1;
    end
    
    if(mod(flag,2)==1)
        isinner=1;
    else
        isinner=0;
    end
end

