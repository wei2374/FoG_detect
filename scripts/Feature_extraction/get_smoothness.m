function [sum_V] = get_smoothness(data,windowsize,stepsize,sensor)
%% This function is used to calculate smoothness 

j_start = 1;
train_data =  data;
index = 1;

while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    % Find the sum of neighbour variance in the data
    sum_V(index) = 0;
    for j=2:length(train_w)
        sum_V(index) = sum_V(index) + (train_w(j)-train_w(j-1))*(train_w(j)-train_w(j-1));
    end
    sum_V(index) = sum_V(index)/(length(train_w)-1);
    
     index=index+1;
     j_start = j_start + stepsize;
end
    
    
   
    
end