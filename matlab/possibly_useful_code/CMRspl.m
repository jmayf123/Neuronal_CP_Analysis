% spectrum level of CMR noise calculation
%function spl=CMRspl(BW)

myTank=['G:\Bravo data\Behavior\ex150814\tank150814b'];
%myBlock=['OurData-1'];
myBlock=['Block-50'];
data=TDT2mat(myTank,myBlock,'Type',[1]);

   %BW=2900;
   BW=100;
 OAL=mean2(data.streams.Wave.data)
   spl=OAL-10*log10(BW)

%end

%cross correlation stuff
% waveforms=data.streams.Wave.data';
% r=xcorr(waveforms);
% r12=xcorr(waveforms(:,1),waveforms(:,2);
% plot(r12)