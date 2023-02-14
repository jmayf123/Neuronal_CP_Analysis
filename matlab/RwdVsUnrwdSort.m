function [PrevRewd, PrevUnrewd]=RwdVsUnrwdSort(ArrayIn)

j=1;
k=1;

for i=2:length(ArrayIn)
    if ArrayIn(4,i)==1
        if ArrayIn(4,i-1)==1
            PrevRewd(:,j)=ArrayIn(:,i); %#ok<*AGROW>
            %then previous was rewarded
            j=j+1;
            
        elseif ArrayIn(4,i-1)==2
            PrevUnrewd(:,k)=ArrayIn(:,i);
            %Then previous was unrewarded
            k=k+1;
            
        end
     end
end
end

