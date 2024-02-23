clear all
close all





gdfX='exampleRaceFile/raceEEG.gdf';
txtX='exampleRaceFile/raceLog.txt';




sampling = 512;


txtFile=txtX;

[signal,h]=sload(gdfX);


AA=readtable(txtFile);

nEvents=size(AA,1);
eventHeader=[];

for e=1:nEvents
    string=char(table2array(AA(e,2)));
    
    matchStart=string(1)=='s';

    if(numel(find(matchStart==0))==0)
        eventHeader=[eventHeader;[table2array(AA(e,1)),32766]];
        continue
    end
    
    
    matchLevelPlayer=string(1:2)=='p1';
    
    matchFinish=string(1:9)=='p1_finish';
    
    if(numel(find(matchFinish==0))==0)
        eventHeader=[eventHeader;[table2array(AA(e,1)),32766]];

        break
    end
    
    if(numel(find(matchLevelPlayer==0))~=0)
        continue
    else
        %% check here for expected input
%         string(1:18)

        matchLevelNone=string(1:18)=='p1_expectedInput n';
        if(numel(find(matchLevelNone==0))==0)
            continue
        end
        matchLevelLeft=string(1:18)=='p1_expectedInput l'; 
        if(numel(find(matchLevelLeft==0))==0)
            flag=1;
            eventHeader=[eventHeader;[table2array(AA(e,1)),7691]];

            
        end
        matchLevelRight=string(1:18)=='p1_expectedInput r'; 
        if(numel(find(matchLevelRight==0))==0)
            flag=1;
            eventHeader=[eventHeader;[table2array(AA(e,1)),7701]];

        end

        inputRight=string(1:18)=='p1_input rightWink'; 
        if(numel(find(inputRight==0))==0)
            flag=1;

            
        end
        
        
        inputLeft=string(1:18)=='p1_input leftWinke'; 
        if(numel(find(inputLeft==0))==0)
            flag=1;

        end
                
        
        
        
    end
end

eventHeader(:,1)=floor(eventHeader(:,1)*512);

% Here I am synchronising the race start trigegr with that of EEG header
% since the race clock and EEG trigger stamping time are different
number=floor(eventHeader(1,1))-floor(h.EVENT.POS(1)+2.67*512);

eventHeader(:,1)=eventHeader(:,1)-number;  %% This generated event header file could be used as the target MI class while doing a post-hoc BCI decoding





