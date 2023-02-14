function [normthresh] = NormalizeThresh(thresholds)

normthresh=zeros(length(thresholds),2);

    
    for i = 1:7:length(thresholds)
        
                
        if i+6 > length(thresholds) 
            break
        end
        
        normthresh(i:i+6,1)= thresholds(i:i+6,1) - thresholds(i,1);
       
        normthresh(i:i+6,2)=[200;100;50;25;12.5;6.50;3.25];

            
    end
end