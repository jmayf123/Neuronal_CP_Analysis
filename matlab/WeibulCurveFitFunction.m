function y = WeibulCurveFitFunction(x,a,b,d,offset)

y= 1-(d.*(exp(-(a.*(x-offset)).^b)));

end