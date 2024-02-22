function [transformed_data] = Affine_transformation(data,reference)
   
    for i=1:size(data,3)
        transformed_data(:,:,i)=inv(sqrtm(reference))*data(:,:,i)*inv(sqrtm(reference))';
    end

end
