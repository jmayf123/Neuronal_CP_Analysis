function [fitresult, gof] = createCoGFitWB(LLfit,PCfit,Threshold)
%CREATEFIT(LL,PC)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : LL
%      Y Output: PC
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 07-Jan-2019 23:14:35


%% Fit: 'untitled fit 1'.
% load('Array.mat')
% close figure 3
LLfit
PCfit
Threshold;
[xData, yData] = prepareCurveData( LLfit, PCfit );
a = Threshold;
% Set up fittype and options.
ft = fittype( 'c-d.*exp(-(x./a)^b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [a 1 -Inf -Inf];
opts.StartPoint = [0.0530446491219723 0.625734126909384 0.505508072942099 0.757740130578333];

figure( 'Name', 'Weibul fit' );
Checkfit = 2;
% while Checkfit == 2


% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
A = fitresult
h = plot( fitresult, xData, yData );
legend( h, 'PC vs. LL', 'fit 1', 'Location', 'NorthEast' );
xlabel LL
ylabel PC
grid on;

% Checkfit =input('Enter 1 if fit is good or Enter 2: ');

% end