clear all; close all; clc

%% Macaques
filedir = 'E:\ABR\Macaque11';
files = ['Macaque11_Click ABR-Biphasic_BIC x ITD_1905231037_runwith'];
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

figure(10), clf;

subplot(4,1,1), hold on,
plot(tmean,Lmeansubj,'b','LineWidth',2)
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
ylabel('L')

subplot(4,1,2), hold on,
plot(tmean,Rmeansubj,'r','LineWidth',2)
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
ylabel('R')

subplot(4,1,3), hold on,
plot(tmean,Bmeansubj(:,:,itd0ix),'Color','k','LineWidth',2)
set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')

subplot(4,1,3), hold on,
plot(tmean,Smeansubj(:,:,itd0ix),'k:','LineWidth',2)

set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
ylabel('Bin and Sum')

subplot(4,1,4), hold on,

plot(tmean,BICmeansubj(:,:,ix),'k','LineWidth',2)

set(gca,'XLim',[-.003 0.012],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off')
ylabel('BIC (Bin - Sum)')

%% BIC mean by ITD

figure(212); hold on; title('BIC mean by ITD')

for ix = 1:size(BICmeansubj,3)
    plot(tmean,(BICmeansubj(:,:,ix)).*1e6,'LineWidth',2)
end

legend(string(uitdlist))
set(gca,'XLim',[0 0.01],'FontSize',15,'FontWeight','Bold','LineWidth',2,'Box','Off');
ylabel('BIC (Binaural - Sum)')