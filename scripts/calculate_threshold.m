function result_mean=calculate_threshold(Thresholds,Thresholds_parameters,result_features,pos_walk,pos_stop)
%% This function is used to calculate different thresholds to filter out data 

%% Features selection
% 0 : interval
% 1 : auto-correlation
% 2 : locomotion energy (0-3Hz)
% 3 : freezeband energy (3-8Hz)
% 4 : higherband energy (8-32Hz)
% 5 : freezingIndex 
% 6 : dominant frequency
% 7 : smoothness
% 8 : portion above mean

    for i = 1:length(Thresholds)
        switch Thresholds(i)
            
            case 0
                 shift = result_features.shift;
                 mean_sh = mean(shift(pos_walk))*Thresholds_parameters(i);%1:1.6; %6:1.1,%7:1.3
                 result_mean.shift = mean_sh;
              
            
            case 1
                 corr = result_features.depth;
                 mean_corr = mean(corr(pos_walk))*Thresholds_parameters(i);%1:1.6; %6:1.1,%7:1.3
                 result_mean.depth = mean_corr;
                 
            case 2
                 sumLoco =  result_features.counts;
                 mean_l = mean(sumLoco(pos_walk))*Thresholds_parameters(i);
                 result_mean.counts = mean_l;
            
            case 3
                 sumLoco =  result_features.entropy;
                 mean_l = mean(sumLoco(pos_walk))*Thresholds_parameters(i);
                 result_mean.entropy = mean_l;
            
                 
            case 4
                 freezeIndex =  result_features.Corr;  
                 mean_fi = mean(freezeIndex(pos_walk))*Thresholds_parameters(i);
                 result_mean.corr = mean_fi;
            case 5
                 freezeIndex =  result_features.shift2;  
                 mean_fi = mean(freezeIndex(pos_walk))*Thresholds_parameters(i);
                 result_mean.shift2 = mean_fi;
            
            case 6
                 I =  result_features.sumLoco;  
                 mean_i = mean(I(pos_walk))*Thresholds_parameters(i);
                 result_mean.sumLoco = mean_i;
                 
            case 7
                 sum_V =  result_features.I;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.I = mean_s;
            
            case 8
                 sum_V =  result_features.freezeIndex;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.freezeIndex = mean_s; 
                            
            case 9
                 sum_V =  result_features.sumAll;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.sumAll = mean_s; 
                
            case 10
                 sum_V =  result_features.smooth;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.smooth = mean_s;  
             
            case 11
                 sum_V =  result_features.Cwt;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.Cwt = mean_s;                  
             
            case 12
                 sum_V =  result_features.portion;  
                 mean_s = mean(sum_V(pos_stop))*Thresholds_parameters(i);
                 result_mean.portion = mean_s;                  
                 
        end
    end



end