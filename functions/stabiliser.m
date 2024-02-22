function [transformed_data] = stabiliser(data,reference)

    transformed_data=inv(sqrtm(reference))*data*inv(sqrtm(reference))';
        

end
