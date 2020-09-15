
%% filtering 
function [feature_result] = filtering(thres_para,res)
len = length(res(1).sum);
sensors = size(res,2);
feature_it = zeros(sensors,len);
feature_fi = zeros(sensors,len);
feature_c = zeros(sensors,len);
feature_df = zeros(sensors,len);
feature_corr = zeros(sensors,len);
feature_s = zeros(sensors,len);
feature_l = zeros(sensors,len);
filter_result = zeros(sensors,len);

thresholds = thres_para.thresholds;
parameters = thres_para.parameters;
dtth = thres_para.dtth * 1.;
TG = thres_para.TG;



interval_t = thresholds(:,1);
loco_t = thresholds(:,2);
locol_t = thresholds(:,3);
id_t = thresholds(:,4);
smooth_t = thresholds(:,5);
fi_t = thresholds(:,6);


%interval_t = 40;
%fi_t = 4;
%smooth_th = .4e5;%3000;
%loco_t = 2e4;
%corr_t = 2e7;
%flag_c=0;
Filter_Result = ones(1,len);
for i=1:sensors
    feature_l(i,:) = (res(i).sum)<(ones(1,len)*loco_t(i));
    feature_it(i,:) = (res(i).it)<(ones(1,len)*interval_t(i));    
    feature_s(i,:) = (res(i).smooth)>(ones(1,len)*smooth_t(i));
    filter_result(i,:) = feature_s(i,:)&feature_it(i,:)&feature_s(i,:);
    Filter_Result = Filter_Result & filter_result(i,:);
end


   %% fi lda
    %{
    %% loco_band energy
    
    if(loco(n)<loco_t &&loco(n)>locol_t )
        feature_l(n)=1;
    else
        feature_l(n)=0;
    end
     
    %% interval_time
    if( interval(n)<interval_t)
        feature_it(n)=1;
    end

    %% dominant frequency
    if(df(n)>id_t)
        feature_df(n)=1;
    end
    
    %% smoothness
    if(smoothness(n)>=smooth_th)
        feature_s(n)=1;
    end
    
    %% freezing index
    if(freezingIndex(n)+freezingIndex(n-1)>2*fi_t)
        feature_fi(n)=1;
    end
%}
    lda_result = zeros(1,len);
    for i=1:sensors
      lda_result = lda_result + parameters(i)*res(i).fi;
    end
    
    for i=1:sensors
      lda_result = lda_result + parameters(i+sensors)*res(i).df;
    end
    
    for i=1:sensors
      lda_result = lda_result + parameters(i+sensors*2)*res(i).sum;
    end
    
    
    %fi_dt = parameters(1)*freezingIndex(n)+parameters(2)*freezingIndex(n-1);
     if(TG==1)
         feature_result=lda_result>dtth*ones(1,len);
     else
         feature_result=lda_result<dtth*ones(1,len);
     end
     
    feature_result = feature_result&Filter_Result;
    %figure(7)
    %subplot(2,1,1)
    %plot(1:1:len,Filter_Result);

    %subplot(2,1,2)
    %plot(1:1:len,feature_result);
   


% This part of code is to extend the length of FoG warning after detection
    
for i=2:length(feature_result)-1
        if(feature_result(i)==0&&feature_result(i-1)==1) % detect the drop
            list(i)=1;
        else
            list(i)=0;
        end
    end
    for i=1:length(list)-4
        if(list(i)==1)
            feature_result(i+1)=1;
            feature_result(i+2)=1;            
            feature_result(i+3)=1;           
            feature_result(i)=1;
        end
    end
    
end
