function [shift,Corr] = get_corr(data,windowsize,stepsize,sensor)
%% This function is used to find the step time
% the auto-correlation is calculated and the peak shows how much the
% correlation is and the lag shows how much time between two steps

%% Get the interval between two steps
train_data=data;
index = 1;
j_start = 1;
threshold = -100;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    
    
    [corr,lags] = xcorr(train_w-mean(train_w),train_w-mean(train_w),'normalize'); 
    
    %if(max(corr(150:end))>threshold)
        [Corr(index),shift(index)] = max(corr(150:end));
   % else
    %    shift(index)=0;
   %     corr(index)=0;
    %end
    
    index=index+1;
     j_start = j_start + stepsize;

end
end