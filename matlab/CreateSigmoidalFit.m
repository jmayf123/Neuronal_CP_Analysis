function [coeff cf_]= CreateSigmoidalFit(x,y)

% --- Create fit "fit 1"
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[0 -100    0    0],'Upper',[1 Inf   1 Inf]);
ok_ = isfinite(x) & isfinite(y);
st_ = [0.19451205906681457 0.12750182627053808 0.61995885621512292 0.27986500314830265 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('a*(x.^n)./((x.^n)+(b.^n))+c',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a', 'b', 'c', 'n'});
cf_ = fit(x(ok_),y(ok_),ft_,fo_);
coeff=coeffvalues(cf_);