function [lda_result] = apply_lda(W,result_features,Features,sensors)
%% Training X for all training data
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

lda_result=zeros(1,length(result_features(1).sumAll));
for i=1:length(Features)
    switch Features(i)
        case 0   
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).shift; 
            end
        case 1    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).depth; 
            end
        case 2    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).counts; 
            end
        case 3    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).entropy; 
            end  
        case 4    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).Corr; 
            end               
        case 5
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).shift2; 
            end
        case 6
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).sumLoco;        
            end
        case 7    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).I; 
            end
        case 8    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).freezeIndex; 
            end             
        case 9    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).sumAll; 
            end   
        case 10    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).smooth; 
            end 
        case 11    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).Cwt; 
            end 
        case 12    
            for sensor=1:sensors
                lda_result = lda_result + W((i-1)*sensors+sensor)*result_features(sensor).portion; 
            end             
    end
end
end