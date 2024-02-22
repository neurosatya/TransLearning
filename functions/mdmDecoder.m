function [predictedClass,probability] = mdmDecoder(decoder,eegCovariance)
    distanceClass1=distance_riemann(decoder.classification.model.parameters{1},eegCovariance);
    distanceClass2=distance_riemann(decoder.classification.model.parameters{2},eegCovariance);

    %% Prediction of the classLabel and probabilities
    probability=1-softmax([distanceClass1^2;distanceClass2^2]);
    if(probability(1)>=probability(2))
        predictedClass=decoder.classification.model.ClassNames(1);
    else
        predictedClass=decoder.classification.model.ClassNames(2);
    end
    
      
    
    
end

