function [] = Output_2Col( data,path )

output = fopen(path,'w');
[A,B] = size(data);
for ii = 1:A
    fprintf(output,'%f    %f\n',data(ii,1),data(ii,2));
end
fclose(output);

end

