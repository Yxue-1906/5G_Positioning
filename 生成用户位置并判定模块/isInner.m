%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����˵��:
%�˺��������ж�һ�������Ƿ��ڸ�����������(�������߷�)
%
%Input:����������,�����ﶥ������
%Output:mark
%       1->
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [isinner] = isInner(x,y,vertixs)

    flag=0;
    i=1;
    
    while(i<=size(vertixs,1)-1)
        %vertixs(����,1->x,2->y)
        if(vertixs(i+1,1)==0)   %˵���������е���
            break;
        end
        if(vertixs(i,2)==vertixs(i+1,2))    %ˮƽ������
            i=i+1;
            continue;
        end
        if((vertixs(i+1,2)==y&&vertixs(i+1,1)>=x)||(vertixs(i,2)==y&&vertixs(i,1)>=x))
            %����ཻ�ڶ���
            if(vertixs(i+1,2)==y&&vertixs(i+1,1)>=x&&vertixs(i+1,2)>vertixs(i,2))
                flag=flag+1;
            end
            if(vertixs(i,2)==y&&vertixs(i,1)>=x&&vertixs(i,2)>vertixs(i+1,2))
                flag=flag+1;
            end
            %�������жϽ��Ķ����Ƿ����������
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

