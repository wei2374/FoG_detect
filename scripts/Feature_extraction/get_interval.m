function [shift,depth,counts,dthreshold] = get_interval(data,windowsize,stepsize,sensor,pos_walk,train)
%% This function is used to find the step time
% the auto-correlation is calculated and the peak shows how much the
% correlation is and the lag shows how much time between two steps

j_start = 1;

%% Butterwurth filter 5 order
fc=8;
fs=64;
[b,a] = butter(5,fc/(fs/2));
train_data =  filter(b,a,data);

%train_data = lowpass(data,8,64);

%%
depth = [];
index = 1;

if(train==1)
threshold  = 0.0;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    max1 = max(train_w);
    min1 = min(train_w);
    depth(index) = max1-min1;
    index=index+1;
    
    j_start = j_start + stepsize;
end

    threshold = mean(depth(pos_walk))*0.55;
else
    while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    max1 = max(train_w);
    min1 = min(train_w);
    depth(index) = max1-min1;
    index=index+1;
    
    j_start = j_start + stepsize;
end
    
    threshold = train;
end

%% Get the interval between two steps

    index = 1;
    j_start = 1;
while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    
    %{
    [corr,lags] = xcorr(train_w-mean(train_w),train_w-mean(train_w),'normalize'); 
    
    if(max(corr(150:end))>threshold)
        [max1,shift(index)] = max(corr(150:end));
    else
        shift(index)=0;
    end
    %}
        %threshold=1000;%1700
        buffer = train_w;
        diff=0;
        count=1;
        p1=1;
        p2=1;
        I1=1;
        
        for n=1:length(buffer)-1
            if(buffer(n+1)>buffer(n))
                p1=n+1;
                p2=n+1;
            else
                if(n==length(buffer)-1)
                    I1=1;
                elseif(buffer(p1)-buffer(p2)>threshold)
                    I1=p2;
                    count=I1;
                    break
                else
                    p2=n+1;
                end
            end
        end
        
        I2=I1;
         
        if(j_start>1500000)
        figure(20)
        plot(train_w);
        hold on
        plot(p2,buffer(p2),'ro');
        hold on
        xlabel('time [ms]');
        ylabel('Acc');
        title('Acc in sensor'+string(sensor-1));
        end
        
        p1=count;
        p2=count;
        
        for n=count:length(buffer)-1
            if(buffer(n+1)>buffer(n))
                p1=n+1;
                p2=n+1;
            else
                if(n==length(buffer)-1)
                    I2=I1;
                elseif(buffer(p1)-buffer(p2)>threshold)
                    I2=p2;
                    break
                else
                    p2=n+1;
                end
            end
        end
        
        
         
        if(j_start>1500000)

        plot(p2,buffer(p2),'ro');
        hold on
        
        end
        if(I1==1 && I2==1)
            interval = -10;
        else    
            interval = abs(I2-I1);
        end
       
    shift(index) = interval;
    
   
    %% count bottoms
    b_counts=0;
    p1=1;
    p2=1;
    for n=1:length(buffer)-1
    if(buffer(n+1)>buffer(n))
        p1=n+1;
        p2=n+1;
    else
        
        if(n==length(buffer)-1)
            I1=1;
        elseif(buffer(p1)-buffer(p2)>threshold)
            I1=p2;
            b_counts=b_counts+1;
            p1=n+1;
            p2=n+1;
        else
            p2=n+1;
        end
    end
    end

     counts(index) = b_counts;
 index=index+1;
     j_start = j_start + stepsize;
end

dthreshold = threshold;
    
%% Get bottoms 

    
end
    