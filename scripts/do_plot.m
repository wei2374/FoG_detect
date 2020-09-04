function x_plot(file)
  
clear;
     %% load data of patient
    for patient=1:9
        if(patient~=4)
     if(patient==2)
     data = load(['../dataset/S0' num2str(patient,'%d') 'R02.txt']);
     data2 = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     
     elseif(patient==8||patient==9)
     data = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     
     else
     data = load(['../dataset/S0' num2str(patient,'%d') 'R01.txt']);
     data2 = load(['../dataset/S0' num2str(patient,'%d') 'R02.txt']);
         
     end
    %% relabel the data according to its window 
    data(:,11) = relabel(data(:,11));    
   % plot_original(data)
    
   %% parameters
    SR = 64;
    stepSize = 32;
    windowsize = 128;    
    sensors = 9;
    
    
    %% trining data
    pos{1} = [780,3140;1500,2200;31000,32000];
    pos{2} = [200,1200;100,3000;16000,17000];
    pos{3} = [270,4000;31800,32200;30000,31000];
    pos{5} = [600,980;1000,1700;600,800;];
    pos{6} = [500,2500;5000,12000;500,4500;];    
    pos{7} = [600,1800;42400,43800;31000,34000;];
    pos{8} = [650,1200;2000,4300;6200,6400;];
    pos{9} = [1680,2600;1000,5000;7000,7200];
   
    %% Apply self-adaptive method 
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

    Features = [0 1 2 3 6 7 8 9 10];
    
    Thresholds = [9];
    Thresholds_parameters = [5];
    post_threshold = [];
    post_thresholds_parameters = [];
    

    lda_features = [0 1  6 7 8 ];
     
    classifier = 3;
    
   [dthreshold,thresholds,mask,parameters,dtth,TG]= self_adaptive(data,pos{patient},stepSize,windowsize,sensors,Features,Thresholds,Thresholds_parameters,post_threshold,post_thresholds_parameters,lda_features,classifier,patient);
   
    %% Save paramaters get from self-adaptive
    save('self_adaptive.mat','thresholds','mask','parameters','dtth','TG','dthreshold'); 
    thres_para = load('self_adaptive.mat');
    save_into_files(patient,sensors,thres_para,Features,Thresholds,classifier);
   
    
    %% call the function to extract features from data
    [result,labels] = x_fi(data,SR,windowsize,stepSize,sensors,Features,Thresholds,lda_features,thres_para);    
    
    if(patient<8)
    [result2,labels2] = x_fi(data2,SR,windowsize,stepSize,sensors,Features,Thresholds,lda_features,thres_para);    
    result = [result,result2];
    labels = [labels, labels2];
    end
    
    figure(6)
    subplot(2,1,1)
    plot(result);
    title('final filter')
    
    subplot(2,1,2)
    plot(labels);
    title('final labels')
    
    
    [recall(patient),correctness(patient)] = calculate_TF(result,labels,1)
     [recallOld(patient),correctnessOld(patient)] = calculate_Old(result,labels)
   % F1(patient) = 2*(recall(patient)*correctness(patient))/(recall(patient)+correctness(patient))
   % F1Old(patient) = 2*(recallOld(patient)*correctnessOld(patient))/(recallOld(patient)+correctnessOld(patient))
    
    linkaxes
    
        end
    end
    

end

