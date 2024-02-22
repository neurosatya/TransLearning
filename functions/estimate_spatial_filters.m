function CSPMatrix = estimate_spatial_filters(riemannianCovarainces,final_labels, numSpatialFilters)

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

    [U, D] = eig(classPrototype{1}, classPrototype{2});
    eigenvalues = diag(D);
    [~, egIndex] = sort(eigenvalues, 'descend');
    U = U(:, egIndex);
    CSPMatrix = U';
    
    CSPMatrix = CSPMatrix([1:numSpatialFilters/2,size(CSPMatrix,1)-numSpatialFilters/2+1:size(CSPMatrix,1)],:);

    
    

end