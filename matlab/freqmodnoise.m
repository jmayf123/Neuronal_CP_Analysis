function [p] = freqmodnoise(Mf)
fs = 97656;
t = (1:1:fs)/fs;
dm = 1;
silence = zeros(fs,1);
x = rand(1,fs);
SSN = x';
out = [];
    
    for i = Mf(1, 1:1:size(Mf,2))
        if i == 0
            x = vertcat(SSN, silence, SSN, silence);
            out = vertcat(out, x);
        
        else    
            z = rand(1,fs).*dm.*(1+sin(2*pi*i*t-(pi/2)));
            y = z';
            out = vertcat(out, y, silence, y, silence);
        end
   
    end
    
p = out;

end
