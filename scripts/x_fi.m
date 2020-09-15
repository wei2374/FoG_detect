function [new_result,labels] = x_fi(data,windowsize,stepsize,sensors,Features,Thresholds,thres_para)   

threshold_clean = thres_para.thresholds;
parameters_lda = thres_para.parameters;
dthreshold = thres_para.dthreshold;
mask = thres_para.mask;
filterl=0;

%% pre filter
for sensor=1:sensors
    %% Feature Extraction from test data
    [result_features(sensor),dthreshold2] = get_features(Features,data,windowsize,stepsize,sensor+1,dthreshold,dthreshold(sensor));
    
    %% Threshold Selection, here I only use the second channel   
    [result2(sensor,:),labels] = threshold_selection(Thresholds,threshold_clean(sensor), result_features(sensor),sensor+1,0);
     if(sensor==2)
          result(sensor,:) = result2(sensor,:);
     else
         result(sensor,:) = ones(1,length(labels));
     end
end

%% Plot filter
filter = (labels~=0);
for sensor = 1:sensors
    filter = filter & result(sensor,:);    
end

figure(8)
subplot(4,1,1)
plot(filter)
title('results after applied thresholds')


%% apply lda
[lda_result] = apply_lda(parameters_lda,result_features,Features,sensors);

%% compare
new_result = zeros(1,length(lda_result));

if(thres_para.TG==1)
for i=1:length(new_result)
    if(lda_result(i)>=thres_para.dtth && filter(i)==1)
        for l=0:filterl
        new_result(i+l)=1;
        end
    end
    
end

    %new_result = lda_result>thres_para.dtth;
    
end

if(thres_para.TG==0)
for i=1:length(new_result)
    if(lda_result(i)<=thres_para.dtth && filter(i)==1)
        for l=0:filterl
        new_result(i+l)=1;
        end
    end
    
end

    
    %    new_result = lda_result<thres_para.dtth;
    
end
figure(8)
     subplot(4,1,3)
    plot(new_result)   

%% Plot result

   new_result = new_result & filter;
    figure(8)
    subplot(4,1,4)
    plot(new_result);
    title('final result')

    figure(8)
    subplot(4,1,2)
    plot(labels);
    title('labels')

end

