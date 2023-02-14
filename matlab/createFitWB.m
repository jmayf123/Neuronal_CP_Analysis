function [] = createFitWB(HR,PC,threshold)
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
LLfit = HR(1:end,1)';
% minLev = min(LLfit);
% maxLev = max(LLfit);
% if minLev<0
%     LLfit = LLfit - minLev;
% end
threshold;
PCfit = PC';
[xData, yData] = prepareCurveData( LLfit, PCfit );
a = threshold-5; % keeps threshold from being forced to fit
% Set up fittype and options.
ft = fittype( 'c-d.*exp(-(x./a)^b)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [a 10 0.75 0.35];
opts.Upper = [40 30 1 0.6];
opts.StartPoint = [0.01 0.625734126909384 0.1 0.1];

figure( 'Name', 'Weibull CDF' );
Checkfit = 2;
% while Checkfit == 2


% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
clf;
A = fitresult;

% gets coefficients to calculate dynamic range of psych fxn
MyCoeffs = coeffvalues(fitresult);
Max=MyCoeffs(3)-MyCoeffs(4)*0.1; % max = saturation point - 10% of range, d
Min=MyCoeffs(3)-MyCoeffs(4)*0.9; % min = saturation point - 90% of range, d (coeff 4)

% computes dyn range of psych fxn
syms x; 
eqn1=MyCoeffs(3)-MyCoeffs(4).*exp(-(x./MyCoeffs(1))^MyCoeffs(2))==(Max);
eqn2=MyCoeffs(3)-MyCoeffs(4).*exp(-(x./MyCoeffs(1))^MyCoeffs(2))==(Min);
 Xat90 = (solve(eqn1,x));
 Xat10 = (solve(eqn2,x)); 
DRat90 = abs(double(Xat90(1)));
DRat10 = abs(double(Xat10(1)));
DR=DRat90-DRat10
PsychSlope = (Max-Min)/(DRat90-DRat10);

% find Ram lab threshold (pc=0.76) from fit
syms y;
eqn=MyCoeffs(3)-MyCoeffs(4).*exp(-(y./MyCoeffs(1))^MyCoeffs(2))==0.76;
fitthresh=(solve(eqn,y));
fitthresh=abs(double(fitthresh));
fitthresh=fitthresh-40

%% find d'=1.5 (O'Connor et al. 1999) from fit
% syms y;
% eqn=MyCoeffs(3)-MyCoeffs(4).*exp(-(y./MyCoeffs(1))^MyCoeffs(2))==1.5;
% dthresh=(solve(eqn,y));
% dthresh=abs(double(dthresh));
% dthresh=dthresh

% if minLev<0
% Xax =  minLev:0.1:maxLev;
% 
% plot(Xax,eq)
% else

h = plot( fitresult, xData, yData );
legend( h, 'neuroPC vs. LL', 'untitled fit 1', 'Location', 'NorthEast' );
xlabel LL
ylabel PC
grid on;

end
% Checkfit =input('Enter 1 if fit is good or Enter 2: ');

% end
