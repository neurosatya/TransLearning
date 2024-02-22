
function [output]=EOGchecker(EOGSignal,threshold)
   

    hEOG=mean(EOGSignal(:,1:2)');

    vEOG=EOGSignal(:,3)'-hEOG;

    aEOG= mean(EOGSignal');

    C=abs([hEOG;vEOG;aEOG]);
    
    if(max(max(C))>threshold)
        output=0;
    else
        output=1;
    end


end