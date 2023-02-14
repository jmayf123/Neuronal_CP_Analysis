function coeff = CreateWeibulFit(x,y)


% --- Create fit "fit 4"
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[0 0 0],'Upper',[10 100 1]);
ok_ = isfinite(x) & isfinite(y);
st_ = [0.01 10 0.5];
set(fo_,'Startpoint',st_);
ft_ = fittype('1-(d*(exp(-(a*x)^b)))',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a', 'b', 'd'});

cf_ = fit(x(ok_),y(ok_),ft_,fo_);
coeff=coeffvalues(cf_);
end