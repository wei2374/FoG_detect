%This function saves thresholds and parameters into file   
function save_into_files(patient,sensors,thres_para,lda_features,Thresholds,Classifier)
    
    %saves thresholds
    datadir = '/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/scripts/Parameters/';
    filename = ([datadir 'P' num2str(patient,'%d') 'T.txt']);
    fid = fopen(filename,'w');
     for i=1:length(Thresholds)
        switch Thresholds(i)
                case 0
                     for(sensor=1:sensors)
                        fprintf(fid,'%f ',thres_para.thresholds(sensor).shift);
                     end
                        fprintf(fid,'\n');
                     
                case 7                
                     for(sensor=1:sensors)
                        fprintf(fid,'%f ',thres_para.thresholds(sensor).I);
                     end 

                case 9                
                     for(sensor=1:sensors)
                        fprintf(fid,'%f ',thres_para.thresholds(sensor).sumAll);
                     end 
        end

     end


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

    %saves lda
    filename = ([datadir 'P' num2str(patient,'%d') 'C' num2str(Classifier,'%d') '.txt']);
    fid = fopen(filename,'w');
    
    fprintf(fid,'%f %f \n',thres_para.TG,thres_para.dtth);

     for i=1:length(lda_features)
         for(sensor=1:sensors)
            fprintf(fid,'%f ',thres_para.parameters(sensors*(i-1)+sensor));
         end
            fprintf(fid,'\n');
                     
     end

    
end