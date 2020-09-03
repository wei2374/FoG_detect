function [relabels] = relabel(labels)
%% This function is used to relabel the data according to its window
% if there exists one data labeled as FoG, then the whole window is labeled
% as FoG

stepsize = 32;
relabels = labels;
windowsize = 128;
jStart = 1;
len = length(labels);

while(jStart<len-windowsize)
    window = labels(jStart:jStart+windowsize-1);
    for(i=1:windowsize)
        if(labels(i)==2)
            relabels(jStart:jStart+windowsize-1) = 2;
            break;
        else
            relabels(jStart:jStart+windowsize-1) = window;                
        end
    end
jStart = jStart+stepsize;
end
    
end