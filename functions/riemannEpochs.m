function [cubeFormData,labels] = riemannEpochs(eegData,h)


    N=size(h.EVENT.TYP,1);  % total no. of samples to train with
    sampling=h.EVENT.SampleRate;
    data_matrix=eegData;
    position=h.EVENT.POS;  % onset of the event
    duration=h.EVENT.DUR;
    type=h.EVENT.TYP;% time points for which events occured
    
    epochLength=1;
    stepSize=1/16;
            %% extracting the 3D matrix
    flag=1;
    
    for n=1:N   % starts from 5 otherwise there would be an error as the index to be selected will go to a -ve value
        flagYes=1;
        if(type(n)==7691 || type(n)==7701) % Change for whether finishing or not
            labels_temp=[];
            data_temp=[];
            % Trial Detected Loop Goes here
            if(type(n+1)==7693 || type(n+1)==7703 )
                position_temp=position(n);
                position_next=position(n+1);
               
                if((position_next-position_temp)/sampling<1)
                    flagYes=0;
                    continue
                else
                    n_Epochs=floor((position_next-position_temp+1-epochLength*sampling)/(stepSize*sampling))+1;
                end
                    
                
                
            end 
            % Tinmeout Loop goes here
            if(type(n+1)==7692 || type(n+1)==7702 )
%                 display('************################********')    
                position_temp=position(n);
                position_next=position(n+1);

                
                if((position_next-position_temp)/sampling<1)
                    flagYes=0;
                    continue
                else
                    n_Epochs=floor((position_next-position_temp+1-epochLength*sampling)/(stepSize*sampling))+1;
                end
                    
                

                    
                
                
            end  
            
            % Estimate using number of epochs
%             fprintf('Number of Epochs in the trial: %d\n',n_Epochs);
            for epoch =1:n_Epochs
                initialPosition=position_temp+(epoch-1)*stepSize*sampling;
                data_temp(:,:,epoch)=data_matrix(initialPosition:initialPosition+epochLength*sampling,:);
                labels_temp=[labels_temp,type(n)];
            end
                
            if(flagYes==1)  
                cubeFormData{flag}=data_temp;
                labels{flag}=labels_temp;
                flag=flag+1;
            end    
        
        end
        

    end
    
    
end