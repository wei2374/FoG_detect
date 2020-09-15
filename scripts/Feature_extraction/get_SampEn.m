function [sampEn] = get_SampEn(data,windowsize,stepsize,sensor)

%% This function is used to find the autocorrelation
j_start = 1;
index = 1;
dim = 2;

train_data = data;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    r = 0.2*std(train_w);

    sampEn(index) = SampEn( dim, r, train_w, 1 );

    
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end