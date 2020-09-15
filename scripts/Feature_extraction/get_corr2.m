function [Corr] = get_corr(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
j_start = 1;
train_data =  lowpass(data,8,64);
index = 1;

while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    [corr,lags] = xcorr(train_w-mean(train_w),train_w-mean(train_w),'normalize'); 
    [Corr(index)] = max(corr(150:end));
    
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end