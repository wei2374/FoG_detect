function [relabels] = relabel(labels)
    stepsize = 32;
    relabels = labels;
    windowsize = 128;
    
    jStart = 1;
    index=1;
    len = length(labels);
    counter=zeros(1,round(len/stepsize) );
    while(jStart<len-windowsize)
        window = labels(jStart:jStart+windowsize-1);
        for(i=1:windowsize)
            if(window(i)==2)
                counter(index)=counter(index)+1;
                relabels(jStart:jStart+windowsize-1) = window;
               
            else
                relabels(jStart:jStart+windowsize-1) = window;                
            end
        end
       %{ 
        if(counter>=(windowsize/2))
            relabels(jStart:jStart+windowsize-1) = 2;
        else
            relabels(jStart:jStart+windowsize-1) = 1;
        end
        %}
    jStart = jStart+stepsize;
    index=index+1;
    end
    
   % counter(index);
    
    
    index=1;
    jStart = 1;
    while(jStart<len-windowsize)
        if(counter(index)>windowsize*1/2)
        relabels(jStart:jStart+windowsize-1) = 2;
        end
    jStart = jStart+stepsize;
    index=index+1;
    end
    
end