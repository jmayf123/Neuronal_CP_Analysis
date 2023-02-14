% Plot Together
% Written by Andy Hrnicek under Ram Ramachandran, PhD.
% March 2011
%
% This script plots psychometric function with neurometric function on same
% plot(figure 2). It uses the double y plot function plotyy and can be easily
% adjusted to plot the rate level function with the psychometric function
% or with the neurometric function based on small ajustments to the returns
% of RespBlockPlotter.m. These adjustments are explained in the header of
% that code.
%
% Btr - behavioral threshold
% Ntr - neural threshold
%
% Figure 1 is a plot of behavior probability correct versus neurological
% probability correct. The slope is the value that explains how well the
% neuron is a predictor of behavior with m=1 meaning that the neuron
% predicts behavior perfectly.
function [] = Monkeyplottogether(MonkeyName,DateIn,TrialNum,Location)
Monkey = MonkeyName;
Date = DateIn;
Num=num2str(TrialNum);
Date1=Date(1:6);
x = Location;

% pulls out psychometric data
[t, n, pc, lc, Btr, g] = MonkeyTankPlotter(Monkey, Date, Num, x);
% pulls out neurometric data
[Data N Ntr] = MonkeyRespBlockPlotter(Monkey, Date, Num, x);
% Btr = behavioral threshold, Ntr - neurometric threshold

cab(MonkeyAnalysis, MonkeyStim);

%close all

% plots correlation of neurometric vs psychometric (y vs x) and fits them
[p S] = polyfit(Data(1,2:end),pc(1,2:end),1); % fit
f = polyval(p,Data(1,2:end));
r2 = min(min(corrcoef(pc(1,2:end)',Data(1,2:end)')));
figure
plot(Data(1,2:end),pc(1,2:end),'om',Data(1,2:end),f,'-.k') % plot
axis([.4 1 .4 1]); % make plot pretty and labeled
text(.7,.45,['r-sq =' num2str(r2)]);
ylabel('Behavioral-P(c)');
xlabel('Neuronal-P(c)');
text(.7,.42, [' slope = ' num2str(p(1))]);

% creates double y axis plot for putting both on same plot
figure
[AX,H1,H2] = plotyy(pc(2,2:end),pc(1,2:end),Data(2,2:end),Data(1,2:end));
% sets axes and labesl them
set(get(AX(1),'Ylabel'),'String','Behavior') 
set(get(AX(2),'Ylabel'),'String','Neurological') 
xlabel('Tone Level (dBSPL)') 
title('Neurobehavior Plot') 
% creates line styles for neurometric and psychometric - blue is
% pscyhometric and black is neurometric
set(H1,'LineStyle','-','Color','b')
set(H2,'LineStyle','-','Color','k','Marker','*')

