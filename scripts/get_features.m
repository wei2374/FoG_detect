function [result_features,dthreshold] = get_features(Features,Train_data,windowsize,stepsize,sensor,pos_walk,train)

addpath('Feature_extraction/');

dthreshold=0;
data = Train_data;
flag_idc=0;
flag_f = 0;
flag_c = 0;

%% Get label
[Label] = get_label(data,windowsize,stepsize,sensor);
%% label preFog as FoG 
labels = labeling2(Label);
result_features.Label = labels;

%% Start feature selection    
for i = 1:length(Features)
    switch Features(i)
        case num2cell(0:2)
            %% Get interval,depth or counts
            if(flag_idc~=1)
                [shift,depth,counts,dthreshold] = get_interval(data,windowsize,stepsize,sensor,pos_walk,train);
                result_features.shift = shift;
                
                result_features.depth = depth;
                result_features.counts = counts;
                flag_idc = 1;
            end

        case 3
            %% Get entropy
            [entropy] = get_SampEn(data,windowsize,stepsize,sensor);
            result_features.entropy = entropy;

        case num2cell(4:5)
            %% Get correlation and interval
            if(flag_c~=1)
                [shift,Corr] = get_corr(data,windowsize,stepsize,sensor);
                result_features.Corr = Corr;
                result_features.shift2 = shift;
                flag_c=1;
            end
            
         case num2cell(6:9)
            %% Get frequency related information
            if(flag_f~=1)
                [sumLoco,sumFreeze,sumHP,freezeIndex,I] = get_Freq(data,windowsize,stepsize,sensor);
                result_features.sumLoco = sumLoco;
                
                result_features.I = I;

                
                result_features.freezeIndex = freezeIndex;
                
                
                result_features.sumAll = sumLoco+sumFreeze;
 
                flag_f=1;
            end
            
        case 10
            %% Get smoothness
            [smooth] = get_smoothness(data,windowsize,stepsize,sensor);
            result_features.smooth = smooth;
        
        case 11
            %% Get cwt info
            [Cwt] = get_cwt(data,windowsize,stepsize,sensor);
            result_features.Cwt = Cwt;
            
        case 12
            %% Get portion
            [portion] = get_portion(data,windowsize,stepsize,sensor);    
            result_features.portion = portion;
        
  
    end

end


   
end