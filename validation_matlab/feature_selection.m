function mask = feature_selection(Feature_selector,result_features,Features,filter,sensors,patient)
addpath('mi/');
feature_numbers = size(Features,2); 
selected_features = ones(feature_numbers,sensors);

correlation = Feature_selector-1;

for f = 1:feature_numbers
   
    switch(Features(f))
        case 0
            % fast shift
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).shift(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).shift =  mutualinfo(c1,c2);
            result_corr(sensor).shift =rho;
            result_p(sensor).shift =pval;
            
            selected_features_m(f,sensor) = mutual_correlation(sensor).shift;
            selected_features_c(f,sensor) = result_p(sensor).shift;
            selected_features_c2(f,sensor) = result_corr(sensor).shift;
                
            end
            
        
        case 1
            % fast depth
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).depth(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).depth =  mutualinfo(c1,c2);
            result_corr(sensor).depth =rho;
            result_p(sensor).depth =pval;
                    
            selected_features_m(f,sensor) = mutual_correlation(sensor).depth;
            
            selected_features_c(f,sensor) = result_p(sensor).depth;
           selected_features_c2(f,sensor) = result_corr(sensor).depth;
            end
 
        case 2
            % fast counts
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).counts(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).counts =  mutualinfo(c1,c2);
            result_corr(sensor).counts =rho;
            result_p(sensor).counts =pval;
                    
            selected_features_m(f,sensor) = mutual_correlation(sensor).counts;
             
            selected_features_c(f,sensor) = result_p(sensor).counts;
            selected_features_c2(f,sensor) = result_corr(sensor).counts;
            end
            
        case 3
            % entropy
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).entropy(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).entropy =  mutualinfo(c1,c2);
            result_corr(sensor).entropy =rho;
            result_p(sensor).entropy =pval;
               
            selected_features_m(f,sensor) = mutual_correlation(sensor).entropy;
            
            selected_features_c(f,sensor) = result_p(sensor).entropy;
            selected_features_c2(f,sensor) = result_corr(sensor).entropy;
            end
            
            
        case 4
            % Corr
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).Corr(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).Corr =  mutualinfo(c1,c2);
            result_corr(sensor).Corr =rho;
            result_p(sensor).Corr =pval;
                     
            selected_features_m(f,sensor) = mutual_correlation(sensor).Corr;
           
            selected_features_c(f,sensor) = result_p(sensor).Corr;
            selected_features_c2(f,sensor) = result_corr(sensor).Corr;
            end
            

        case 5
            % shift2
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).shift2(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).shift2 =  mutualinfo(c1,c2);
            result_corr(sensor).shift2 =rho;
            result_p(sensor).shift2 =pval;
                    
            selected_features_m(f,sensor) = mutual_correlation(sensor).shift2;
             
            selected_features_c(f,sensor) = result_p(sensor).shift2;
            selected_features_c2(f,sensor) = result_corr(sensor).shift2;
            
            end
            
        case 6
            % sumLoco
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).sumLoco(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).sumLoco =  mutualinfo(c1,c2);
            result_corr(sensor).sumLoco =rho;
            result_p(sensor).sumLoco =pval;
            selected_features_m(f,sensor) = mutual_correlation(sensor).sumLoco;
             
            selected_features_c(f,sensor) = result_p(sensor).sumLoco;
           selected_features_c2(f,sensor) = result_corr(sensor).sumLoco; 
            
            end
            
        case 7
            % I
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).I(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).I =  mutualinfo(c1,c2);
            result_corr(sensor).I =rho;
            result_p(sensor).I =pval;
                     
            selected_features_m(f,sensor) = mutual_correlation(sensor).I;
          
            selected_features_c(f,sensor) = result_p(sensor).I;
            selected_features_c2(f,sensor) = result_corr(sensor).I;
          
            end

         case 8
            % freezeIndex
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).freezeIndex(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).freezeIndex =  mutualinfo(c1,c2);
            result_corr(sensor).freezeIndex =rho;
            result_p(sensor).freezeIndex =pval;
            selected_features_m(f,sensor) = mutual_correlation(sensor).freezeIndex;
             
            selected_features_c(f,sensor) = result_p(sensor).freezeIndex;   
            selected_features_c2(f,sensor) = result_corr(sensor).freezeIndex;
                
            end
            
         case 9
            % sumAll
            for sensor = 1:sensors 
            c1 = normalize(result_features(sensor).sumAll(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).sumAll =  mutualinfo(c1,c2);
            result_corr(sensor).sumAll =rho;
            result_p(sensor).sumAll =pval;
           
            selected_features_m(f,sensor) = mutual_correlation(sensor).sumAll;
             
            selected_features_c(f,sensor) = result_p(sensor).sumAll;            
              selected_features_c2(f,sensor) = result_corr(sensor).sumAll;
            end
            
         case 10
            % smooth
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).smooth(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).smooth =  mutualinfo(c1,c2);
            result_corr(sensor).smooth =rho;
            result_p(sensor).smooth =pval;
            selected_features_m(f,sensor) = mutual_correlation(sensor).smooth;
             
            selected_features_c(f,sensor) = result_p(sensor).smooth;   
            selected_features_c2(f,sensor) = result_corr(sensor).smooth;
               
            
            end
 
            
         case 11
            % Cwt
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).Cwt(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).Cwt =  mutualinfo(c1,c2);
            result_corr(sensor).Cwt =rho;
            result_p(sensor).Cwt =pval;
            selected_features_m(f,sensor) = mutual_correlation(sensor).Cwt;
             
            selected_features_c(f,sensor) = result_p(sensor).Cwt;            
            selected_features_c2(f,sensor) = result_corr(sensor).Cwt;    
            
            end 
 
         case 12
            % portion
            for sensor = 1:sensors
            c1 = normalize(result_features(sensor).portion(filter==1))';
            c2 = result_features(sensor).Label(filter==1)';
            [rho,pval] = corr(c1,c2,'Type','Spearman');
            mutual_correlation(sensor).portion =  mutualinfo(c1,c2);
            result_corr(sensor).portion =rho;
            result_p(sensor).portion =pval;
            selected_features_m(f,sensor) = mutual_correlation(sensor).portion;
             
            selected_features_c(f,sensor) = result_p(sensor).portion;            
               selected_features_c2(f,sensor) = result_corr(sensor).portion;
            
            end            
    end
    
   % mean_value = mean(mean(abs(selected_features),1),2);
    
end

%% Save
filename1 =[ 'feature_s/feature_ms' num2str(patient,'%d') '.mat'];
filename2 =[ 'feature_s/feature_cs' num2str(patient,'%d') '.mat'];
save(filename1,'selected_features_m'); 
save(filename2,'selected_features_c'); 

if(correlation==0)
    selected_features = selected_features_m;
else
    selected_features = selected_features_c;
end
%% Calculate thresholds
selected_features = abs(selected_features);
mean_value = mean(mean(selected_features,1),2);

mean_features = mean(selected_features,1);
mean_axis = mean(selected_features,2);



%% Feature selection 
mask = zeros(size(selected_features));

for f=1:feature_numbers
for sensor = 1:sensors
    if(selected_features(f,sensor)<=0.05)
        mask(f,sensor)=1;
    end
end
end

end