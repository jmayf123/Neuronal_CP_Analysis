clear all; close all

%% Macaques
filedir = '/mnt/sdb1/Travelling BIC/Macaques/MIT ITD/';
files = ['mq01';'mq05';'mq06';'mq07';'mq11';'mq12';'mq13';'mq14'];
DSI = 1;

%% Start Analysis

% Search for datasummary file (if data already analysed)
strcmp(files,'datasummary.mat');
if ~isempty(strmatch('datasummary',files))
    data = load([filedir '/' deblank(files(strmatch('datasummary',files),:))]);
    data2 = data.data2;
else % analyse data
    data=[];
    jx=0;
    
    for ix = 1:size(files,1)
        if findstr(files(ix,:),'datasummary') | findstr(files(ix,:),'.fig') | findstr(files(ix,:),'exclude')
            continue
        end
        
        data=load([filedir '/' deblank(files(ix,:))]);
        subj{ix} = deblank(files(ix,1:min(findstr(files(ix,:),'_'))));
        
        if isnumeric(deblank(files(ix,1:min(findstr(files(ix,:),'_')))))
            subj{ix} = str2num(subj{ix});
        end
        
        if isfield(data,'data')
            data = data.data;
        else
            data = data;
        end
        
        % get sample rate for each measurement
        Fs(ix) = data.ex.stim_params.Fs;
        data2.Fs(ix) = Fs(ix);
        
        jx = jx+1;
        % get measurement data and sort into left right and binaural
        trialdata = data.ex.trialdata;
        Lt = find(cat(1,trialdata.chanswitch)==1);
        Rt = find(cat(1,trialdata.chanswitch)==2);
        Bn = find(cat(1,trialdata.chanswitch)==3);
        
        if ~isempty(Lt) && isempty(Rt) && isempty(Bn) %% then this is a monaural left run
            sLmean = cat(1,trialdata(Lt).sigL).*repmat(cat(1,trialdata(Lt).phase),1,length(trialdata(Lt(1)).sigL));
            sRmean = zeros(size(sLmean));
        elseif isempty(Lt) && ~isempty(Rt) && isempty(Bn)   %% then this is a monaural right run
            sRmean = cat(1,trialdata(Rt).sigR).*repmat(cat(1,trialdata(Rt).phase),1,length(trialdata(Rt(1)).sigR));
            sLmean = zeros(size(sRmean));
        elseif isempty(Lt) && isempty(Rt) && ~isempty(Bn)    % update signal vectors... multiply in phase to avoid averaging to 0
            sLmean = cat(1,trialdata(Bn).sigL).*repmat(cat(1,trialdata(Bn).phase),1,length(trialdata(Bn(1)).sigL));
            sRmean = cat(1,trialdata(Bn).sigR).*repmat(cat(1,trialdata(Bn).phase),1,length(trialdata(Bn(1)).sigR));
        else
            sLmean = cat(1,trialdata(Lt).sigL).*repmat(cat(1,trialdata(Lt).phase),1,length(trialdata(Lt(1)).sigL));
            sRmean = cat(1,trialdata(Rt).sigR).*repmat(cat(1,trialdata(Rt).phase),1,length(trialdata(Rt(1)).sigR));
        end
        
        if isempty(Lt)
            ER2 = Fs(ix)/DSI;
            ER2delay = round(ER2/1000);
            sumsig = nanmean(sRmean,1)+nanmean(sRmean,1); %%% sigR is getting trigger bleedover... fix this later
            sigonset = find(abs(sumsig(50:end))>(max(abs(sumsig(50:end))/5)),1); sigonset = sigonset+50; %%% hack to deal with trig bleedover into right channel...
            TVECT = ((0-sigonset-ER2delay)+1 : (length(trialdata(1).sigL)-sigonset-ER2delay))./(Fs(ix)./DSI);
        else
            ER2 = Fs(ix)/DSI;
            ER2delay = round(ER2/1000);
            sumsig = nanmean(sLmean,1)+nanmean(sLmean,1); %%% sigR is getting trigger bleedover... fix this later
            sigonset = find(abs(sumsig)>(max(abs(sumsig))/5),1);
            TVECT = ((0-sigonset-ER2delay)+1 : (length(trialdata(1).sigL)-sigonset-ER2delay))./(Fs(ix)./DSI);
        end
        
        if ~isfield(data,'itdlist')
            data.itdlist = unique(cat(1,trialdata(Bn).itd));
        end
        
        if ~isfield(data,'Ldata')
            data.Ldata = cat(1,trialdata(Lt).AEP);
        end
        if ~isfield(data,'Rdata')
            data.Rdata = cat(1,trialdata(Rt).AEP);
        end
        if ~isfield(data,'Bdata')
            for kx = 1:length(data.itdlist)
                itdixtmp = find(cat(1,trialdata.itd)==data.itdlist(kx));
                data.Bdata{kx} = cat(1,trialdata(intersect(Bn, itdixtmp)).AEP);
            end
        end
        if ~isfield(data,'t')
            data.t = TVECT';
        end
        
        if ix == 5
            data.Ldata = -data.Ldata;
            data.Rdata = -data.Rdata;
            for ki = 1:7
                data.Bdata{ki} = -data.Bdata{ki};
            end
        end
        
        % sort all data into new data structure (data2) containing all
        % individual measurements
        data2.t{jx} = TVECT';
        data2.itdlist{jx} = data.itdlist;
        
        data2.Lmean(jx,1:size(data.Ldata,2)) = nanmean(data.Ldata);
        data2.Rmean(jx,1:size(data.Rdata,2)) = nanmean(data.Rdata);
        data2.Lstd(jx,1:size(data.Ldata,2)) = nanstd(data.Ldata);
        data2.Rstd(jx,1:size(data.Rdata,2)) = nanstd(data.Rdata);
        
        for kx = 1:length(data.itdlist)
            data2.Bmean{jx}(kx,1:size(data.Bdata{kx},2)) = nanmean(data.Bdata{kx});
            data2.Bstd{jx}(kx,1:size(data.Bdata{kx},2)) = nanmean(data.Bdata{kx});
            
            data2.tR{jx}(kx,1:size(data2.t{jx},1)) = data2.t{jx};
            data2.tL{jx}(kx,1:size(data2.t{jx},1)) = data2.t{jx};
            if data2.itdlist{jx}(kx)>0
                data2.tR{jx}(kx,1:size(data2.t{jx},1)) = [data2.t{jx} + round(data.itdlist(kx)/1e6*Fs(ix))/Fs(ix)];
            elseif data2.itdlist{jx}(kx)<0
                data2.tL{jx}(kx,1:size(data2.t{jx},1)) = [data2.t{jx} - round(data.itdlist(kx)/1e6*Fs(ix))/Fs(ix)];
            end
            
            data2.tsum{jx}(kx,1:size(data.t,1)) = data.t;
            data2.dsum{jx}(kx,1:size(data2.t{jx},1)) = interp1(data2.tL{jx}(kx,:),nanmean(data.Ldata),data2.tsum{jx}(kx,:)) + interp1(data2.tR{jx}(kx,:),nanmean(data.Rdata),data2.tsum{jx}(kx,:));
            
            data2.tbic{jx}(kx,1:size(data.t,1)) = data.t;
            data2.dbic{jx}(kx,1:size(data2.t{jx},1)) = interp1(data.t,nanmean(data.Bdata{kx}),data2.tbic{jx}(kx,:)) - data2.dsum{jx}(kx,:);
        end
        
        disp([sprintf('%.1f',ix/(length(files(:,1)))*100) '% complete']) % display analysis progress
    end
    data2.subj = subj';
    save([filedir '/datasummary.mat'],'data2'); % save summary of data
end

%% sort into appropriate columns by ITD
uitdlist = unique(cell2mat(data2.itdlist'));
if size(uitdlist,2)==1, uitdlist = uitdlist'; end
tmean = data2.t{find(cellfun(@length,data2.t)==max(cellfun(@length,data2.t)),1)};
Lmean = data2.Lmean;
Rmean = data2.Rmean;
Bmean2 = nan(length(data2.Bmean),size(data2.Bmean{1},2),size(uitdlist,2));
Smean = nan(size(Bmean2));
BICmean = nan(size(Bmean2));
for ix = 1:length(data2.Bmean)
    for jx = 1:size(uitdlist,2)
        if any(find(data2.itdlist{ix} == uitdlist(jx)))
            tmpix = 1:length(data2.Bmean{ix}(find(data2.itdlist{ix} == uitdlist(jx)),:));
            Bmean2(ix,tmpix,jx) = data2.Bmean{ix}(find(data2.itdlist{ix} == uitdlist(jx)),:);
            Smean(ix,tmpix,jx) = data2.dsum{ix}(find(data2.itdlist{ix} == uitdlist(jx)),:);
            BICmean(ix,tmpix,jx) = data2.dbic{ix}(find(data2.itdlist{ix} == uitdlist(jx)),:);
        end
    end
end
Bmean = Bmean2;

% average/compile data by subject
subj = data2.subj;
subj = subj(1,:);
if isempty(subj{1}) | ~isnumeric(subj{1}), subj = [1:length(data2.subj)]; end
usubj = unique(subj);

for ix = 1:length(usubj)
    if sum(subj == usubj(ix))>1
        Lmeansubj(ix,:) = nanmean(Lmean(subj == usubj(ix),:));
        Rmeansubj(ix,:) = nanmean(Rmean(subj == usubj(ix),:));
        for jx = 1:size(uitdlist,2)
            Bmeansubj(ix,:,jx) = nanmean(Bmean2(subj == usubj(ix),:,jx));
            Smeansubj(ix,:,jx) = nanmean(Smean(subj == usubj(ix),:,jx));
            BICmeansubj(ix,:,jx) = nanmean(BICmean(subj == usubj(ix),:,jx));
        end
    else
        Lmeansubj(ix,:) = Lmean(subj == usubj(ix),:);
        Rmeansubj(ix,:) = Rmean(subj == usubj(ix),:);
        for jx = 1:size(uitdlist,2)
            Bmeansubj(ix,:,jx) = Bmean2(subj == usubj(ix),:,jx);
            Smeansubj(ix,:,jx) = Smean(subj == usubj(ix),:,jx);
            BICmeansubj(ix,:,jx) = BICmean(subj == usubj(ix),:,jx);
        end
    end
end

%% grand mean of raw waveforms
itd0ix = find(uitdlist == 0);

figure(10), clf; title('Grand mean of raw waveforms')
subplot(5,1,1), hold on,
% plot(tmean,Lmeansubj')
hax = patch([tmean' fliplr(tmean')],[nanmean(Lmeansubj) + nanstd(Lmeansubj)/sqrt(size(Lmeansubj,1))...
    fliplr(nanmean(Lmeansubj) - nanstd(Lmeansubj)/sqrt(size(Lmeansubj,1)))],'b');
set(hax,'linestyle','none','facealpha',.5)
plot(tmean,nanmean(Lmeansubj),'Color','b','LineWidth',1)
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off') %,'YLim',[-.6e-6 .6e-6])
ylabel('L')

subplot(5,1,2), hold on,
% plot(tmean,Rmeansubj')
hax = patch([tmean' fliplr(tmean')],[nanmean(Rmeansubj) + nanstd(Rmeansubj)/sqrt(size(Rmeansubj,1))...
    fliplr(nanmean(Rmeansubj) - nanstd(Rmeansubj)/sqrt(size(Rmeansubj,1)))],'r');
set(hax,'linestyle','none','facealpha',.5)
plot(tmean,nanmean(Rmeansubj),'Color','r','LineWidth',1)
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off') %,'YLim',[-.6e-6 .6e-6])
ylabel('R')

subplot(5,1,3), hold on,

for ix = 1:size(uitdlist,2)
    if ix == itd0ix
        plotcolor = 'k';
    else
        plotcolor = [1 1 1]*1/ix/2+.25;
    end
    
    plot(tmean,nanmean(Bmeansubj(:,:,ix)),'Color',plotcolor,'LineWidth',1)
    
    hax = patch([tmean' fliplr(tmean')],[nanmean(Bmeansubj(:,:,ix)) + nanstd(Bmeansubj(:,:,ix))/sqrt(size(Bmeansubj,1))...
        fliplr(nanmean(Bmeansubj(:,:,ix)) - nanstd(Bmeansubj(:,:,ix))/sqrt(size(Bmeansubj,1)))],plotcolor);
    set(hax,'linestyle','none','facealpha',.5)
    hasbehavior(hax,'legend',false);
    
end
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off') %,'YLim',[-.6e-6 .6e-6])
ylabel('Bin')

subplot(5,1,4), hold on,

for ix = 1:size(uitdlist,2)
    if ix == itd0ix
        plotcolor = 'k';
    else
        plotcolor = [1 1 1]*1/ix/2+.25;
    end
    
    plot(tmean,nanmean(Smeansubj(:,:,ix)),'Color',plotcolor,'LineWidth',1)
    
    hax = patch([tmean' fliplr(tmean')],[nanmean(Smeansubj(:,:,ix)) + nanstd(Smeansubj(:,:,ix))/sqrt(size(Smeansubj,1))....
        fliplr(nanmean(Smeansubj(:,:,ix)) - nanstd(Smeansubj(:,:,ix))/sqrt(size(Smeansubj,1)))],plotcolor);
    set(hax,'linestyle','none','facealpha',.5)
    hasbehavior(hax,'legend',false);
    
end
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off') %,'YLim',[-.6e-6 .6e-6])
ylabel('Sum')

subplot(5,1,5), hold on,
hax = patch([tmean' fliplr(tmean')],[nanmean(BICmeansubj(:,:,itd0ix)) + nanstd(BICmeansubj(:,:,itd0ix))/sqrt(size(BICmeansubj,1))...
    fliplr(nanmean(BICmeansubj(:,:,itd0ix)) - nanstd(BICmeansubj(:,:,itd0ix))/sqrt(size(BICmeansubj,1)))],'k');
set(hax,'linestyle','none','facealpha',.5)
for ix = 1:length(hax)
    hasbehavior(hax(ix),'legend',false);
end

for ix = 1:size(uitdlist,2)
    if ix == itd0ix
        plotcolor = 'k';
    else
        plotcolor = [1 1 1]*1/ix/2+.25;
    end
    
    plot(tmean,nanmean(BICmeansubj(:,:,ix)),'Color',plotcolor,'LineWidth',2)
    
    hax = patch([tmean' fliplr(tmean')],[nanmean(BICmeansubj(:,:,ix)) + nanstd(BICmeansubj(:,:,ix))/sqrt(size(BICmeansubj,1))....
        fliplr(nanmean(BICmeansubj(:,:,ix)) - nanstd(BICmeansubj(:,:,ix))/sqrt(size(BICmeansubj,1)))],plotcolor);
    set(hax,'linestyle','none','facealpha',.5)
    hasbehavior(hax,'legend',false);
    
end
legend(string(uitdlist))
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')%,'YLim',[-.2e-6 .2e-6])
ylabel('BIC (Bin - Sum)')

linkaxes(get(gcf,'Children'),'x')

%% BIC mean by ITD

figure(212); hold on; title('BIC mean by ITD')

for ix = 1:7
    
    colours = [0.5 0 1; 0.25 0.8 0.25; 1 0.5 0; 0 0 0; 1 0.5 0; 0.25 0.8 0.25; 0.5 0 1];
    
    plot(tmean,nanmean(BICmeansubj(:,:,ix)).*1e6,'Color',colours(ix,:),'LineWidth',2)
    
    hax = patch([tmean' fliplr(tmean')],[nanmean(BICmeansubj(:,:,ix)) + nanstd(BICmeansubj(:,:,ix))/sqrt(size(BICmeansubj,1))....
        fliplr(nanmean(BICmeansubj(:,:,ix)) - nanstd(BICmeansubj(:,:,ix))/sqrt(size(BICmeansubj,1)))],plotcolor);
    set(hax,'linestyle','none','facealpha',.5)
    hasbehavior(hax,'legend',false);
    
end

legend(string(uitdlist))
set(gca,'XLim',[0 0.01],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off');%,'YLim',[-.5e-6 .5e-6])
ylabel('BIC (Binaural - Sum)')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')


%% calc. subject signature BIC from Benichoux et al. 2018
itd0ix = find(uitdlist == 0);
Fs = data2.Fs;
t_range = [0.002 0.010];

csBICAmax=[];
gainweights=[];
csBICdel=[];
subjSignBIC=[];
subjSignBICstd=[];
BICmeansubj2=[];

for ix = 1:length(usubj) % BICsubjlist %
    tmp0itd = BICmeansubj(ix,[tmean'>t_range(1) & tmean'<=t_range(2)],itd0ix);
    tmp0itdnoise = BICmeansubj(ix,1:size(tmp0itd,2),itd0ix);
    [csBICAnoise,csBIClnoise] = xcorr(tmp0itdnoise,tmp0itd,'biased'); % returns amplitudes and lags
    csBICAnoise = csBICAnoise.*1/(rms(tmp0itdnoise).*rms(tmp0itd)); % normalise to 1/rms1*rms2
    
    [csBICAautocorr,csBIClautocorr] = xcorr(tmp0itd,tmp0itd,'biased'); % Autocorrelation
    csBICAautocorr = csBICAautocorr.*1/(rms(tmp0itd).*rms(tmp0itd)); % normalise to 1/rms1*rms2
    [csBICAautocorrmax(ix),csBICAautocorrmaxix(ix)] = max((csBICAautocorr)); % Find max for each ITD
    csBICautocorrdel(ix) = csBIClautocorr(csBICAautocorrmaxix(ix)); % Find delay at max
    
    % now xcorr with other itds
    for jx = 1:size(uitdlist,2)
        tmpixitd = BICmeansubj(ix,[tmean'>t_range(1) & tmean'<=t_range(2)],jx);
        
        [csBICA,csBICl] = xcorr(tmpixitd,tmp0itd,'biased');
        csBICA = csBICA.*1/(rms(tmpixitd).*rms(tmp0itd)); % normalise
        
        [csBICAmax(ix,jx),csBICAmaxix(ix,jx)] = max(csBICA); % find max amplitude and lag
        csBICdel(ix,jx) = csBICl(csBICAmaxix(ix,jx));
    end
    
    gainweights(ix,:) = csBICAmax(ix,:)./csBICAmax(ix,itd0ix); % normalise to 0 ITD
    gainweightsnoise(ix) = max(csBICAnoise) ./ csBICAmax(ix,itd0ix);
    csBICdel(ix,:) = csBICdel(ix,:).*1./Fs(ix); % convert to seconds
    
    BICmeansubj2(ix,:,:) = squeeze(BICmeansubj(ix,:,:))./repmat(gainweights(ix,:),size(BICmeansubj,2),1);
    
    for jx = 1:size(uitdlist,2)
        BICmeansubj2(ix,:,jx) = interp1(tmean-csBICdel(ix,jx),BICmeansubj2(ix,:,jx),tmean);
    end
    
    subjSignBIC(ix,:) = nanmean(squeeze(BICmeansubj2(ix,:,:)),2);
    subjSignBICstd(ix,:) = nanstd(squeeze(BICmeansubj2(ix,:,:)),[],2);
    
end

% remove zeroes
csBICdel(gainweights == 0) = nan;
gainweights(gainweights == 0) = nan;

% A & del vs ITD
figure(40), clf; title('A & del vs ITD');
subplot(1,2,1), hold on
plot(uitdlist,gainweights,'-')
plot(unique(uitdlist),nanmedian(gainweights),'Color','k','LineWidth',2)
hobj = patch([get(gca,'XLim') fliplr(get(gca,'XLim'))],[[1 1]*prctile(gainweightsnoise,75) [1 1]*prctile(gainweightsnoise,25)],[.7 .7 .7]);
set(hobj,'LineStyle','none','facealpha',.7);
ylabel('A xcorr')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')

subplot(1,2,2), hold on
plot(uitdlist,csBICdel,'-')
[~,tmpix] = min(squeeze(BICmeansubj2(:,[tmean'>t_range(1) & tmean'<=t_range(2)],:)));
plot(unique(uitdlist),nanmedian(csBICdel),'Color','k','LineWidth',2)
ylabel('Delay xcorr')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')

%% example
for ix=usubj
    figure(500+ix), clf
    
    subplot(2,2,1), cla, hold on
    title([num2str(usubj(ix))])
    surf(tmean,uitdlist,squeeze(BICmeansubj(ix,:,:))','linestyle','none'),
    [~,tmpix] = min(squeeze(BICmeansubj(ix,[tmean'>t_range(1) & tmean'<=t_range(2)],:)));
    plot3(tmean(tmpix+find(tmean>min(t_range),1)),uitdlist',max(get(gca,'ZLim'))*ones(size(uitdlist')),'-w')
    set(gca,'view',[0 90],'XLim',[-0.002 0.012])
    ylabel('raw')
    
    subplot(2,2,3), cla, hold on
    surf(tmean,uitdlist,squeeze(BICmeansubj2(ix,:,:))','linestyle','none'),
    [~,tmpix] = min(squeeze(BICmeansubj2(ix,[tmean'>t_range(1) & tmean'<=t_range(2)],:)));
    plot3(tmean(tmpix+find(tmean>min(t_range),1)),uitdlist',max(get(gca,'ZLim'))*ones(size(uitdlist')),'-w')
    set(gca,'view',[0 90],'XLim',[-0.002 0.012])
    ylabel('aligned')
    
    subplot(2,2,2), cla
    title([num2str(usubj(ix))])
    set(gca,'XLim',[-.002 0.012])
    line(tmean,squeeze(BICmeansubj(ix,:,:))),
    
    subplot(2,2,4), cla
    set(gca,'XLim',[-.002 0.012])
    line(tmean,squeeze(BICmeansubj2(ix,:,:))),
    
    linkaxes(get(gcf,'Children'),'x')
    
    for i = 1:4
        figure(500+ix)
        subplot(2,2,i)
        set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
    end
    
end

for ix = 1:length(usubj)
    
    figure(50); hold on; sgtitle('BIC')
    
    subplot(3,4,ix), cla
    set(gca,'XLim',[-.002 0.012])
    patch([tmean;flipud(tmean)],[subjSignBIC(ix,:)+subjSignBICstd(ix,:), fliplr(subjSignBIC(ix,:)-subjSignBICstd(ix,:))],[.5 .5 .5])
    line(tmean,subjSignBIC(ix,:))
    title(files(ix,:))
    set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
    
    subplot(3,4,[9 10 11 12])
    set(gca,'XLim',[-.002 0.012])
    patch([tmean;flipud(tmean)],[nanmean(subjSignBIC)+nanstd(subjSignBIC), fliplr(nanmean(subjSignBIC)-nanstd(subjSignBIC))],[.5 .5 .5])
    line(tmean,nanmean(subjSignBIC))
    ylabel('mean signature BIC')
    
    set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
    
end