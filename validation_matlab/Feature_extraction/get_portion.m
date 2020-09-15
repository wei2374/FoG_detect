function [portion] = get_portion(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
j_start = 1;
index = 1;
train_data = data;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
     
    y = train_w;
    energy_a =0;
    energy_p =0;
    
    %% Portion  
     y_mean = mean(y);
     p1 = 0;
     pa = 0;
     for j=1:length(y)
        if(y(j)>y_mean)
           p1=p1+1;
           %energy_p = energy_p+abs(y(j)-y_mean);
        
        end
        %energy_a = energy_a+abs(y(j)-y_mean);
       %pa = pa+abs(y(j));
     end
    
     portion(index) =p1/windowsize;
    
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end