function [covarianceMatrix] = extractCovariance(eegData)
    %% Trace normalised EEG data
    covarianceMatrix=cov1para(eegData./(sqrt(trace(eegData'*eegData))));
end

