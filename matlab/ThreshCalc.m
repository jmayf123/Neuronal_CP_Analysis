% Written by Andy Hrnicek under guidance of P.I. Ram Ramachandran, PhD.
% Fall 2010
% 
% This function calculates psychometric thresholds for TankPlotter.m using
% a linear extrapolation in between the first point above threshold and the
% last point below threshold. If the threshold is not crossed, the returned
% value will be 100.
%
%%% INPUTS
% pc - choice probability array with choice probability values by tone
% level in row 1 and dBSPL values in row 2 (row 2 isn't necessary if you
% don't want)
%%% OUTPUTS
% linethresh - threshold of the psychometric data


function [linethresh] = ThreshCalc(pc)

hitrt = pc(1,:);

above = find(hitrt > .759);
% Find threshold
if ~isempty(above)
    above1 = above(1);
    x2 = pc(2,above1);
    x1 = pc(2,above1-1);
    y2 = pc(1,above1);
    y1 = pc(1,above1-1);
    m = (y2-y1)/(x2-x1);
    b = ((-1)*m*x1)+y1;
    linethresh = (.76-b)/m;
else
    linethresh = 1000; % if the trial does not cross threshold, the returned threshold is 100
end

end