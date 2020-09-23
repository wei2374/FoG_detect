function [result_features,labels,pre_filter,mask] = self_adaptive(Feature_selector,data1,data2,pos,stepsize,windowsize,sensors,Features,Thresholds,Thresholds_parameters,classifier,patient)
%% This function is used to extract useful information from training data
% PART1: extract necessary thresholds
% PART2: LDA

data = data1;

%% get the training window
pos_all = 1000*[pos(1,1),pos(1,2)];
pos_walk = [round(pos(2,1)):round(pos(2,2))];
pos_stop = [round(pos(3,1)):round(pos(3,2))];

index1 =  (data(:,1)>pos_all(1));
index2 =  (data(:,1)<pos_all(2));
index3 =  index1&index2;

Train_data = data(index3,:);

%% Plot original data with walking period and stop period
figure(1)
subplot(3,1,1)
plot(1:1:length(Train_data),Train_data(:,3));

% plot normal gait
x1 = pos_walk(1);
x2 = pos_walk(end);
y1 = -3000;
y2 = -3500;
patch([x1,x2,x2,x1],[y1 y1 y2 y2],[0 .75 0.75]);


% plot stop gait
x1 = pos_stop(1);
x2 = pos_stop(end);
y1 = -3000;
y2 = -3500;
patch([x1,x2,x2,x1],[y1 y1 y2 y2],[1 0 1]);
ylabel('Acc [mg]');
xlabel('Time [ms]')

title('original data used for self-adaptive ')

% assign window
pos_walk = [round(pos(2,1)/stepsize):round(pos(2,2)/stepsize)];
pos_stop = [round(pos(3,1)/stepsize):round(pos(3,2)/stepsize)];
train=1;

%% Get variables for feature extraction
for sensor=1:sensors    
    %% Feature extraction for thresholds
    [result_features1(sensor),Dthreshold(sensor)] = get_features(Features,Train_data,windowsize,stepsize,sensor+1,pos_walk,train);
    %% Calculate Threshold
    result_mean(sensor) = calculate_threshold(Thresholds,Thresholds_parameters,result_features1(sensor),pos_walk,pos_stop);
end



datas = [data1;data2];

%% Feature extraction
for sensor=1:sensors
    
    %% Feature extraction
    [result_features(sensor),x] = get_features(Features,datas,windowsize,stepsize,sensor+1,pos_walk,Dthreshold(sensor));
    
    %% Threshold threshold
     [result2(sensor,:),labels] = threshold_selection(Thresholds,result_mean(sensor), result_features(sensor),sensor+1,0);
     if(sensor==2)
          result(sensor,:) = result2(sensor,:);
     else
         result(sensor,:) = ones(1,length(labels));
     end
    
end

%% plot original label
figure(4)
subplot(4,1,1)
plot(labels)
title('labels')

%% filter away non-experiment data and data that below threshold

pre_filter = result(2,:);
filter_0 = (labels~=0);

pre_filter2 = pre_filter&filter_0;

subplot(4,1,2)
plot(pre_filter2);
title('results after applied pre thresholds')
%% Calculate how many FoG labels are filtered

plot_filtered(data,labels,pre_filter2);
    


%% Feature selection
mask = feature_selection(Feature_selector,result_features,Features,pre_filter2,sensors,patient);
%mask = ones(length(Features),sensors);
   
end