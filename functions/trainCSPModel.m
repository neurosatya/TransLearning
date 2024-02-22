function [ classificationModel ] = trainCSPModel(riemannianCovarainces, final_labels, spatialFilters)

 

    %% Estimation of class prototypes
    features = [];
    for i=1:size(riemannianCovarainces,3)
        
        transformedMatrix = spatialFilters * riemannianCovarainces(:,:,i) * spatialFilters';
        diagonalValues = diag(transformedMatrix);
        log_diagonalValues = log10(diagonalValues./(sum(diagonalValues)));

        features = [features,log_diagonalValues];    
    
    end


    final_labels (final_labels == 7691) = -1;
    final_labels (final_labels == 7701) = 1;
    
    classificationModel = fitcdiscr (features', final_labels);
    
    
end