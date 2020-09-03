function [Dthreshold,thresholds,mask,parameters,dtth,TG] = self_adaptive(data,pos,stepsize,windowsize,sensors,Features,Thresholds,Thresholds_parameters,post_threshold,post_thresholds_parameters,lda_features,classifier,patient)
%% This function is used to extract useful information from training data
% PART1: extract necessary thresholds
% PART2: LDA

%% get the training window

pos_all = 1000*[pos(1,1),pos(1,2)];
pos_walk = [round(pos(2,1)):round(pos(2,2))];
pos_stop = [round(pos(3,1)):round(pos(3,2))];

index1 =  (data(:,1)>pos_all(1));
index2 =  (data(:,1)<pos_all(2));
index3 =  index1&index2;

Train_data = data(index3,:);

%% Plot original data
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

for sensor=1:sensors
    
    %% Feature Extraction
    [result_features(sensor),Dthreshold(sensor)] = get_features(Features,Train_data,windowsize,stepsize,sensor+1,pos_walk,train);
    %if(sensor==2)
    %    Dthreshold = dthreshold;
    %end
    
    %% combile pre-filter with post-filter
    thresholds_all = [Thresholds,post_threshold];
    thresholds_params = [Thresholds_parameters,post_thresholds_parameters];
    
    %% Calculate Threshold
    result_mean(sensor) = calculate_threshold(thresholds_all,thresholds_params,result_features(sensor),pos_walk,pos_stop);

    %% Threshold Selection
    
    if(sensor<=2)
    [result(sensor,:),labels] = threshold_selection(Thresholds,result_mean(sensor), result_features(sensor),sensor+1,0);
    else
        result(sensor,:) = result(sensor-1,:);
    end
    
end

%% plot original label
figure(4)
subplot(4,1,1)
plot(labels)
title('labels')
%% Only apply pre-filter smoothness
filter = (labels~=0);
for sensor = 1:sensors
    if(patient~=8)
    filter = filter&result(sensor,:);    
    end
end
subplot(4,1,2)
plot(filter)
title('results after applied pre thresholds')

%% Feature selection
mask = feature_selection(result_features,Features,filter,sensors,patient);
%mask = ones(size(Features,2),sensors);

%% Fi LDA
[W,TG,DT_threshold,tree] = fi_lda(Features,lda_features,result_features,labels,filter,sensors,classifier,mask);


%% Filtering out labeled data
training_Y = labels-1;
% filter out experiments data
filter_0 = (training_Y~=-1);
% filter out data within pre filter
filter_0 = filter_0 & filter;

Index = find(filter_0==1);

training_y = training_Y(Index);

%% calculate training set

[lda_result] = apply_lda(W,result_features,Features,sensors);
%lda_result = lda_result(Index);

%% new
if(classifier<4)  
if(TG==1)
    new_result = lda_result>DT_threshold;
end
if(TG==0)
    new_result = lda_result<DT_threshold;
end
        
%% plot training set
figure(4)
subplot(4,1,3)
plot(new_result);
title('after lda result')


%% post filter
%{
for sensor=1:sensors
    %% Threshold Selection
    [result(sensor,:),labels] = threshold_selection(post_threshold,result_mean(sensor), result_features(sensor),sensor+1,0);   
end

for sensor = 1:sensors
    filter = filter&result(sensor,:);    
end
%}

%% plot final

filter = new_result & filter;
figure(4)
subplot(4,1,4)
plot(filter);
title('final result')


%% old
else

    Z_train = [lda_result;training_y]';
    tree.plot_errors(Z_train);
end
%% return value
parameters = W;
dtth = DT_threshold;
TG = TG;
thresholds = result_mean;
    
   
end