
function [PrevRewd1, PrevUnrewd1]=FRwdVsUnrwdSort(ArrayIn)
j=1;
k=1;
for i=1:length(ArrayIn)-1
    if ArrayIn(4,i)==1
        if ArrayIn(4,i+1)==1
            PrevRewd1(:,j)=ArrayIn(:,i);
            %then previous was rewarded
            j=j+1;
        elseif ArrayIn(4,i+1)==2
            PrevUnrewd1(:,k)=ArrayIn(:,i);
            %Then previous was unrewarded
            k=k+1;
        end
    end
end