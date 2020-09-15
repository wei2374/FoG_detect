function [Label] = get_label(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
j_start = 1;
index = 1;
train_data = data;
while j_start < length(train_data)- windowsize
  
     %% Label
    Label(index) =  train_data(j_start,11);
      
    index=index+1;
    j_start = j_start + stepsize;
end
       
end