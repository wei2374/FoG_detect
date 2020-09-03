function [W,TG,DT_threshold,tree] = fi_lda(Features,lda_features,result_features,labels,filter,sensors,Classifier,mask)


%% Training X
% 0 : fast interval
% 1 : step depth
% 2 : step counts
% 3 : sample entropy
% 4 : max correlation
% 5 : interval correlation 
% 6 : loco energy
% 7 : dominant frequency
% 8 : freeze Index
% 9 : loco+freeze 
% 10 : smoothness
% 11 : cwt mean
% 12 : portion

training_X =  circshift(result_features(1).sumAll,0)*0;
for i=1:length(Features)
    switch Features(i)
        % fast interval
        case 0    
            
            for sensor=1:sensors
                cl = size(training_X,1);
                if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).shift;    
                end
            end
        % depth    
        case 1    
            
            for sensor=1:sensors
                cl = size(training_X,1);
                if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).depth;    
                end
             end 
            
        % counts    
        case 2             
             
            for sensor=1:sensors
                cl = size(training_X,1);
                 if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).counts;    
                 end
            end
            
        %sample entropy    
        case 3             
            
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).entropy;    
             end    
            end
            
        % max correlation    
        case 4             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).Corr;    
             end    
            end
            
        % corr interval    
        case 5
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).shift2;    
             end    
            end
            
        % loco    
        case 6
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).sumLoco;    
             end    
            end
            
        % dominant frequency    
        case 7             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).I;    
             end    
            end
        % freezeIndex    
        case 8             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).freezeIndex;    
             end    
            end    
            
        % freeze+loco    
        case 9             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).sumAll;    
             end    
            end
          
        % smoothness    
        case 10    
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).smooth;    
             end    
            end
            
        % cwt mean    
        case 11    
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).Cwt;    
             end    
            end
            
        % portion    
        case 12   
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).portion;    
             end    
            end  
    end
    
end

training_X = training_X(2:end,:);


%% Filtering out labeled data
training_Y = labels-1;
% filter out experiments data
filter_0 = (training_Y~=-1);
% filter out data within pre filter
filter_0 = filter_0 & filter;

Index = find(filter_0==1);

%% Filtering out lda training data
training_x = training_X(:,Index);
training_y = training_Y(Index);

%% LDA Filtering

figure(5)
    
subplot(3,1,1)
plot(training_y);
    
r=1;
[Z,W] = LDA(training_x,training_y',r);

cl=1;

%% return W_new into original shape if any selection happens

for i=1:length(Features)
 
    for sensor=1:sensors
        if(mask(i,sensor)==0)
            W_new(sensors*(i-1)+sensor,:) = W(1,:)*0;
        else
            W_new(sensors*(i-1)+sensor,:) = W(cl,:);
            cl=cl+1;
        end
    end
    

end
    


W = W_new;

index1 = find(training_y==1);
class1 = Z(index1);
index2 = find(training_y==0);
class2 = Z(index2);
    
c1m = mean(class1);
c2m = mean(class2);
FoGn = numel(class1);
noFoGn = numel(class2);
    

%% Classifier
addpath('classifiers/');
switch Classifier
    case 1
        [gini,TG] = classifier(c1m,c2m,Z,training_y,FoGn,noFoGn);
        tree=0;

    case 2
        [gini,TG] = classifier2(c1m,c2m,Z,training_y,FoGn,noFoGn);
        tree=0;
    case 3
        [gini,TG] = classifier3(c1m,c2m,Z,training_y,FoGn,noFoGn);
        tree=0;
    case 4
        [tree] = classifier4(c1m,c2m,Z,training_y,FoGn,noFoGn);    
        gini=0;
        TG=0;
end

            
%% Decision Tree
if(Classifier<4)
[DT_score,DT_index]=max(gini(:,2));
DT_threshold=gini(DT_index,1);

subplot(3,1,2)
% plot lda separating result
%figure()
plot(index1,Z(index1),'r.');
hold on

plot(index2,Z(index2),'b.');
hold on

plot(c1m*ones(length(Z)),'r');
hold on
plot(c2m*ones(length(Z)),'b');
hold on
plot(DT_threshold*ones(length(Z)),'y');
hold on

xlabel('time [ms]');
ylabel('feature');


subplot(3,1,3)
if(TG==0)
    plot(Z<DT_threshold);
else
     plot(Z>DT_threshold);
end
else
    DT_threshold=0;
end
end