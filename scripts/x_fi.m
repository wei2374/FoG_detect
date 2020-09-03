function [filter,labels] = x_fi(data,SR,windowsize,stepsize,sensors,Features,Thresholds,lda_features,thres_para)   

threshold_clean = thres_para.thresholds;
parameters_lda = thres_para.parameters;
dthreshold = thres_para.dthreshold;
mask = thres_para.mask;

%% pre filter
for sensor=1:sensors
    %% Feature Extraction from test data
    [result_features(sensor),dthreshold2] = get_features(Features,data,windowsize,stepsize,sensor+1,dthreshold,dthreshold(sensor));
    
    %% Threshold Selection
    if(sensor<=2)
    [result(sensor,:),labels] = threshold_selection(Thresholds,threshold_clean(sensor), result_features(sensor),sensor+1,0);
    else
    result(sensor,:) = result(sensor-1,:);
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
%lda_result = lda_result(Index);
%% compare
if(thres_para.TG==1)
    new_result = lda_result>thres_para.dtth;
end
if(thres_para.TG==0)
    new_result = lda_result<thres_para.dtth;
end
figure(8)
     subplot(4,1,3)
    plot(new_result)   
%% post filter
%{
for sensor=1:sensors
    %% Feature Extraction from test data
    %[result_features(sensor),dthreshold2] = get_features(Features,data,windowsize,stepsize,sensor+1,dthreshold,dthreshold);
    
    %% Threshold Selection
    [post_result(sensor,:),labels] = threshold_selection(Thresholds,threshold_clean(sensor), result_features(sensor),sensor+1,0);
end
%}

%% Plot filter
%filter = labels~=0;
%{
for sensor = 1:sensors
    filter = filter & post_result(sensor,:);    
    figure(8)
    subplot(4,1,3)
    plot(filter)
    title('results after applied thresholds')

end
%}
   filter = new_result & filter;
    figure(8)
    subplot(4,1,4)
    plot(filter);
    title('final result')

    figure(8)
    subplot(4,1,2)
    plot(labels);
    title('labels')

end

