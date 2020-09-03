function [portion] = get_portion(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
j_start = 1;
index = 1;
train_data = data;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
     
    y = train_w;
    %% Portion  
     y_mean(index) = mean(y);
     p1 = 0;
     for j=1:length(y)
        if(y(j)>y_mean)
           p1=p1+1;
        end
     end
    
     portion(index) = p1/length(y);
    
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end