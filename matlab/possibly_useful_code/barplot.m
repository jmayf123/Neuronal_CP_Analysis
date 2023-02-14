%cab(MonkeyAnalysis,MonkeyStim);
clf


x = 1:1;100
y=zeros(2,100);

for i=1:100
    y(i,1)=2*rand;
    y(i,2)=15*rand;
end
hist(y,x) 