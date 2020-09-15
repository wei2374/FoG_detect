%% filtering
% In this filter each feature has its weights, the result will be a linear
% combination of it.

function [feature_corr,feature_c,feature_fi,feature_it,filter_result] = filtering2(corr,interval,freezingIndex,counts,smoothness)
len = length(interval);
feature_it = zeros(1,len);
feature_fi = zeros(1,len);
feature_c = zeros(1,len);
feature_corr = zeros(1,len);
feature_s = zeros(1,len);
filter_result = zeros(1,len);
threshold = 3;
smooth_th = 2000;
continue_l = 5;
flag=1;
flag_c=0;

for n=2:len-1
    
    flag_c = 0;  
    
    if(corr(n)<corr(n-1))
        flag_c=1;  
    end
    
    if(corr(n)>corr(n-1))
        flag_c=0;  
    end
    
    
    
    if(corr(n)==0&&corr(n-1)==0)
        feature_corr(n)=1;
    else
        feature_corr(n)=0;
    end
    
    
    if( interval(n)<40 && interval(n+1)<40)
        feature_it(n)=1;
    end
    
    if(counts(n)>=4)
        feature_c(n)=1;
    end
    
    if(smoothness(n)>smooth_th)
        feature_s(n)=1;
    end
    
    if(freezingIndex(n)>threshold)
        feature_fi(n)=1;
    end
    
    %if(flag_c==1)
     
    filter_score(n) = w_fi*freezingIndex(n)+w_fi*feature_it(n)+w_fi*counts(n);
    if(filter_score > result_t && feature_it(n)==1 && feature_s(n)==1 || feature_c(n))
        filter_result(n) = 1;
    %end
    end
    
end

% This part of code is to extend the length of FoG warning after detection
    for i=1:length(filter_result)-1
        if(filter_result(i)==1&&filter_result(i)==1) % detect the drop
            list(i)=1;
        else
            list(i)=0;
        end
    end
    for i=1:length(list)
        if(list(i)==1)
            filter_result(i+1)=1;
            filter_result(i+2)=1;            
            filter_result(i+3)=1;           
            filter_result(i+4)=1;
        end
    end
    
end
