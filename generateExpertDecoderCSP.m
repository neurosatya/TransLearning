

clear all
close all


currentdiectoryLocation=pwd;

addpath(strcat(currentdiectoryLocation,'/functions/'))



[decoder.preprocessing.bandPassFilter.b,decoder.preprocessing.bandPassFilter.a]=butter(2,[8 30]/(512/2));



dataLocation = 'expertMIData';


allRunsInfo = dir(fullfile(dataLocation, '*.gdf'));
nRuns=size(allRunsInfo,1);

tic
runLabels=[];
allChannels=[1:22];

for run=1:nRuns
    
    

    [s_temp,h_temp]=sload(strcat(allRunsInfo(run).folder,'/',allRunsInfo(run).name));

    s_temp=s_temp(:,allChannels); % Could be switched here for all Channels

    s_temp=filter(decoder.preprocessing.bandPassFilter.b,decoder.preprocessing.bandPassFilter.a,s_temp);

    [data{run},labels{run}]=riemannEpochs(s_temp,h_temp);

    x_temp=data{run};
    y_temp=labels{run};
    
    whole_data_temp{run}=cat(3,x_temp{:});
    whole_labels_temp{run}=cat(2,y_temp{:});




end
final_data=cat(3,whole_data_temp{:});
final_labels=cat(2,whole_labels_temp{:});


fprintf(' Offline Session Data Processed -- Time Taken : %f seconds\n ', toc);


%% generating the decoder here


fprintf('Training the Classification Model:');
fprintf('\n---------------------------------\n');

riemannianCovarainces=estimateRiemannianCovaraince(final_data);
reference=riemann_mean(riemannianCovarainces);

riemannianCovarainces=Affine_transformation(riemannianCovarainces, reference);
unique_labels=unique(final_labels);
Nclass=size(unique_labels, 2);
Ntrials = zeros(1, Nclass);

%% Estimation of class prototypes
classPrototype = cell(Nclass,1);
tic
for i=1:Nclass
    Ntrials(i) = size(riemannianCovarainces(:, :, final_labels==unique_labels(i)),3);
    classPrototype{i} = riemann_mean(riemannianCovarainces(:,:,final_labels==unique_labels(i)));
end

n_spatial = 6;


[ spatialFilters ] = estimate_spatial_filters (riemannianCovarainces,final_labels, n_spatial);

[ classificationModel ] = trainCSPModel(riemannianCovarainces, final_labels, spatialFilters);

a = toc;

decoder.classification.model.spatialFilters = spatialFilters;
decoder.classification.model.classificationModel = classificationModel;
decoder.classification.model.n_spatial = n_spatial;
decoder.channelMontage = [1:22];
decoder.mode = 'CSP_LDA';
decoder.numChEOG  = 3;

