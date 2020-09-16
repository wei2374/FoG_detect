function testing(file)
  
clear;
     %% load data of patient
    for patient=8:9
        if(patient~=4)
     if(patient==2)
     data = load(['../dataset/S0' num2str(patient,'%d') 'R02.txt']);
     data2 = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
 
     % Three dataset is available
     elseif(patient==3)
     data = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     data2 = load(['../dataset/S0' num2str(patient,'%d') 'R02.txt']);
     data3 = load(['../dataset/S0' num2str(patient,'%d') 'R03.txt']);
     data2 = [data2;data3];

     % Only one dataset is available
     elseif(patient==8||patient==9||patient==16)
     data = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     data2 = data(1,:);
          
     else
     data = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     data2 = load(['../dataset/S0' num2str(patient,'%d') 'R02.txt']);
  
     end
   
    %% Plot original data
    plot_original(data)

    
    
    %% part of data that labels the normal walking and stop
    pos{1} = [780,3140;1500,2200;31000,32000];
    pos{2} = [200,1200;100,3000;16000,17000];
    pos{3} = [270,4000;31800,32200;30000,31000];
    pos{5} = [600,1650;1100,1600;600,800;];
    pos{6} = [500,2500;5400,6000;500,4500;];    
    pos{7} = [600,1800;1200,2000;31000,34000;];
    pos{8} = [650,1200;4000,4500;6200,6400;];
    pos{9} = [400,1300;1500,2500;49000,50000];
   

    %% Features selection
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

    %% Features that used for training
    Features = [0 1 2 6 7 8 9 10 12];
        
    %% Features that used for thresholding
    Thresholds = [7,9];
    Thresholds_parameters = [0,0];
    %1. mutual information
    %2. spearman's rank correlation
    Feature_selector = 2;
    %1.scaled gini index
    %2.new metrics   
    classifier = 3;     
    SR = 64;
    stepSize = 32;
    windowsize = 128;    
    sensors = 9;
    
    %% Apply self-adaptive method 
   [result_features,labels,filter,mask]= self_adaptive(Feature_selector,data,data2,pos{patient},stepSize,windowsize,sensors,Features,Thresholds,Thresholds_parameters,classifier,patient);
   
  
    %% LDA + validation
    datas = [data;data2];
    [Correctness,Recall,Specifity,F1Score] = lda_vali(datas,Thresholds,Features,result_features,labels,filter,sensors,classifier,mask);
    fprintf(1,'Result for patient %d \tCorrecness: %.2f Recall: %.2f Specifity: %.2f\n F1score: %.2f\n',patient,Correctness,Recall,Specifity,F1Score);

    
        end
    end
    

end


