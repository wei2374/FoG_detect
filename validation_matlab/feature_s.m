for patient = 1:9
    if(patient ~=4)
        
    fc = load(['feature_s/feature_cs' num2str(patient) '.mat'])';
    fm= load(['feature_s/feature_ms' num2str(patient) '.mat'])';
    
    features_c(patient,:,:) = fc.selected_features_c;
    features_m(patient,:,:) = fm.selected_features_m;
    
    
    [one,features,sensors] = size(features_c(patient,:,:));
    datac = reshape(features_c(patient,:,:),[features,sensors]);
    datam = reshape(features_m(patient,:,:),[features,sensors]);
    datac = abs(datac);
    datam = abs(datam);
    
    
    c_axis(patient,:) = mean(abs(datac),1);
    c_fea(patient,:) = mean(abs(datac),2);
    m_axis(patient,:) = mean(abs(datam),1);
    m_fea(patient,:) = mean(abs(datam),2);
    
    %% Creating masks
    mask_c = zeros(size(datac));
    mask_m = zeros(size(datam));

    mean_value_c = mean(mean(datac,1),2);
    mean_value_m = mean(mean(datam,1),2);
    mean_value_c = median(median(datac,1),2);
    mean_value_m = median(median(datam,1),2);
    

    for f=1:size(datac,1)

    for sensor = 1:sensors
        if(datac(f,sensor)<=0.05)
            mask_c(f,sensor)=1;
        end
    end

    for sensor = 1:sensors
        if(datam(f,sensor)>mean_value_m)
            mask_m(f,sensor)=1;
        end
    end

    end
    MaskC(patient,:,:) = mask_c;
    MaskM(patient,:,:) = mask_m;
    
    

    end
    
    
end
c_axis(4,:) = c_axis(3,:);
m_axis(4,:) = m_axis(3,:);
c_fea(4,:) = c_fea(3,:);
%{
figure()
subplot(2,1,1)
boxplot(c_axis);
xlabel('channels');
title('Spearmann correlation with respect to all channels')

subplot(2,1,2)
boxplot(m_axis);
xlabel('channels');
title('Mutual information with respect to all channels')

figure()
subplot(2,1,1)
boxplot(c_fea,{'step interval(fast)','step depth','step counts','sample entropy','locomotion','dominant f','freeze Index','all energy', 'smoothness'});
title('Spearmann correlation with respect to all features')

subplot(2,1,2)
boxplot(m_fea,{'step interval(fast)','step depth','step counts','sample entropy','correlation','step interval(corr)','locomotion','dominant f','freeze Index','all energy', 'smoothness','wavelet mean','porion'});
title('Spearmann correlation')
title('Mutual information with respect to all features')
%}

%% Feature selection 
sumMC = zeros(10,10);
sumMM = zeros(size(datac));
for patient = 1:9
     for f=1:size(datac,1)
    for sensor = 1:sensors
        sumMC(f,sensor) = sumMC(f,sensor)+MaskC(patient,f,sensor);
        sumMM(f,sensor) = sumMM(f,sensor)+MaskM(patient,f,sensor);       
    end
     end

end
sumMC(10,:) =[0,0,0,0,0,0,0,0,0,0];
sumMC(:,10) =[0,0,0,0,0,0,0,0,0,0];

figure()
surf(sumMC,'flat','interp')
colorbar

%figure()
%surf(sumMM)