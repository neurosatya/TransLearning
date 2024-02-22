clear all
close all

load(['expertDecoderWithoutRecenter.mat'])


[a,b]=mdmDecoder(decoder,decoder.classification.model.parameters{1});

default=b(1);
contri=[];
for ch=1:22
    decNew=decoder;
    C1=decoder.classification.model.parameters{1};
    C2=decoder.classification.model.parameters{2};
    
    
    C1(ch,:)=0;
    C1(:,ch)=0;
    C1(C1==0)=[];
    C1=reshape(C1,21,21);
    
    C2(ch,:)=0;
    C2(:,ch)=0;
    C2(C2==0)=[];
    C2=reshape(C2,21,21);

    decNew.classification.model.parameters{1}=C1;
    decNew.classification.model.parameters{2}=C2;
    
    [a,b]=mdmDecoder(decNew,decNew.classification.model.parameters{1});
    
    contri(ch)=[default-b(1)];
    
end


figure
topoplot(contri,'22ChannelElectrodes.locs');
colorbar

caxis([0.004 0.022])
title('Expert Subject')
%
figure('position', [0, 0, 600, 600]);   % create new figure with specified size

topoplot(zscore(contri),'22ChannelElectrodes.locs');
colorbar
caxis([-1 3])
title('Expert-Decoder: Z scores')
