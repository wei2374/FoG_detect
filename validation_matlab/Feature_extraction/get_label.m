function [Label] = get_label(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
j_start = 1;
index = 1;
train_data = data;
while j_start < length(train_data)- windowsize
  
    train_window = train_data(j_start:j_start+windowsize-1,11);
     %% Label
     counter1=1;
     counter2=1;
     
     for i=1:(windowsize)
        if(train_window(i)==2)
            counter2=counter2+1;
           
        end
        
        if(train_window(i)==1)
            counter1=counter1+1;
        end
        
     end
      Label(index) =  0;
     if(counter1>0.7*windowsize)
        Label(index) =  1;
     end
     
     if(counter2>=0.3*windowsize)
        Label(index) =  2;
     end
         
         
        
         
    index=index+1;
    j_start = j_start + stepsize;
end
       
end