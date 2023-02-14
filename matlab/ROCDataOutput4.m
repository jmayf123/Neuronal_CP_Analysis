function []= ROCDataOutput4(ArrayIn,MyTank,MyBlock,tlvls)
MyTank=MyTank(end-6:end);
ArrayIn=rot90(ArrayIn);
[NumberRows,NumberColumns]=size(ArrayIn);
Array2=flipud(ArrayIn);

for i=1:NumberColumns-1
    Dirrectory= ['C:\My Documents\GUIde\Firing Rate Comp\ROC',...
        num2str(i), ' Block', num2str(MyTank) , num2str(MyBlock),' Tlvl ' num2str(tlvls(i+1)),'.txt'];
    
    OutArray(1,:)=flipud(ArrayIn(:,1));
    OutArray(2,:)=flipud(ArrayIn(:,i+1));
    fid=fopen(Dirrectory, 'w+');
    
    for j=1:NumberRows
        
        fprintf(fid, '%d\t', OutArray(1,j));
        fprintf(fid, '%d\r\n', OutArray(2,j));
        
        
    end
    fclose(fid);
end
    
