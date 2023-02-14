function []= ROCDataOutput2(ArrayIn,MyTank,MyBlock)
MyTank=MyTank(end-6:end);
ArrayIn=rot90(ArrayIn);
[NumberColumns,NumberRows]=size(ArrayIn);
ArrayIn=fliplr(ArrayIn);
for i=1:NumberRows-1
    Dirrectory= ['C:\My Documents\GUIde\Firing Rate Comp\',...
         ' Block', num2str(MyTank) , num2str(MyBlock),' Neuro P(C).txt'];
    
    OutArray(1,:)=flipud(ArrayIn(:,1));
    OutArray(2,:)=flipud(ArrayIn(:,i+1));
    fid=fopen(Dirrectory, 'w+');
    
    for j=1:NumberColumns
        
        fprintf(fid, '%d\t', OutArray(1,j));
        fprintf(fid, '%d\r\n', OutArray(2,j));
        
        
    end
    fclose(fid);
end