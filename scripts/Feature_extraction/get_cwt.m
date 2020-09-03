function [Cwt] = get_cwt(data,windowsize,stepsize,sensor)

addpath '/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/scripts/Feature_extraction'
%% This function is used to find the autocorrelation
j_start = 1;
index = 1;


train_data = data;
%train_data = lowpass(data,8,64);
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    train_w = train_w - mean(train_w);
    %[cfs,f] = cwt(train_w,64);
    %cfs = abs(cfs);
    [cA,cD] = dwt(train_w,'db4');
    [cA,cD] = dwt(cA,'db4');
    [cA,cD] = dwt(cA,'db4');
    
    locomotion = sum(abs(cA),1);
    freeze = sum(abs(cD),1);
    R = locomotion./(freeze+locomotion);
    Cwt(index) = freeze;
   
    if(j_start>150000000)
    cwt(train_w,64);

    figure(30)
    subplot(2,1,1)
    plot(R);
    subplot(2,1,2)
    plot(train_w);
    
    
    end
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end