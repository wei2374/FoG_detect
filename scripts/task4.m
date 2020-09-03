datadir = '../dataset/';
SR = 64;            % Sample rate in herz
stepSize=64;        % Step size in samples
offDelay=2;         % Evaluation delay in seconds: tolerates delay after detecting
onDelay=2;          % Evaluation delay in seconds: tolerates delay before detecting

% Parameters to optimize per sensor placement/orientation and subject
%TH.freeze  =  3 ;
% subject [1 3 7 8 10] threshold 3
TH.freeze  =  [3 1.5 3 1.5 1.5 1.5 3 3 1.5 3];
%%
%  *
%TH.freeze  =  [1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5 1.5];
TH.power   = 2.^ 12 ;
%TH.power   = 2.^ 11.5 ;


% Sensors: 0=ankle, 1=above knee, 2=hip
% axis: 0=horizontal forward, 1=vertical, 2=horizontal lateral

% 4,10 have no freeze
for isubject=[1:7]
    if(isubject~=4)
    % 0:2
    for isensor=0:2
        % 0:2
        for iaxis=0:2

            fprintf(1,'Subject %02d sensor %d axis %d\n',isubject,isensor,iaxis);
            
            fileruns = dir([datadir 'S' num2str(isubject,'%02d') 'R*.txt']);
            resrun=[0 0 0 0 0];
    
            %for r = 1:length(fileruns)
            for r = 2:2
                filename = [datadir fileruns(r).name];
                fprintf(1,'\tProcessing %s\n',filename);

                data = load(filename);
        
                % Moore's algorithm
                % We collect features with all sensors and all axis
                res1(1+isensor*3+iaxis) = x_fi1(data(:,2+isensor*3+iaxis),SR,stepSize,data);
                
               %%
                % All data is available
                if(isensor==2 && iaxis==2)
                
                % Put all data into a big array    
                sum_V_all = [];
                I_all = [];
                fi_all = []; 
                 for n=1:9
                   sum_V_all = [sum_V_all;res1(n).sum_V];
                   I_all = [I_all;res1(n).I];
                   fi_all = [fi_all;res1(n).freezeIndex];
                 end
                
                
               %%
               % Label 
               if(isubject~=4)  % No FoG for patient 4
                    
               
               gtframe = data(res1(1).time-128,11);                % 0=no experiment, 1=no freeze, 2=freeze
               xp = find(gtframe~=0);
               pre = find(gtframe==2);            % find FoG
               if(size(pre,1)~=0) 
               pre2=[];
               
               for n=2:length(pre)-1
                    if(pre(n)-1==pre(n-1))
                        pre2(n)=0;
                    else
                        pre2(n)=1;
                    end
                end
                
                pre2(1)=1;
                pre3 = pre(pre2==1);
                pre3 = cat(1,pre3-1,pre3-2);
                
                for n=1:length(pre3)
                    gtframe(pre3(n)) = 3;
                end
               end
                
                labels = gtframe(xp);       % subtract 1 to have 0 or 1 as labels
                FoG_data = [sum_V_all(:,xp);I_all(:,xp);fi_all(:,xp);labels'];               

               end
               
               %%
                datadir2 = 'data_tests/';
               
                switch isubject
                   
                    case 1
                        save([datadir2 'FoG_data_test_1.mat'],'FoG_data');
                    case 2
                        save([datadir2 'FoG_data_test_2.mat'],'FoG_data');
                    case 3
                        save([datadir2 'FoG_data_test_3.mat'],'FoG_data');
                    case 5
                        save([datadir2 'FoG_data_test_5.mat'],'FoG_data');
                    case 6
                        save([datadir2 'FoG_data_test_6.mat'],'FoG_data');
                    case 7
                        save([datadir2 'FoG_data_test_7.mat'],'FoG_data');
                   
                end
                
                end

                
               
                % Extension of Baechlin to handle low-enery situations
                % (e.g. standing)
                res1(1).quot(res1(1).sum < TH.power) = 0;

                % Classification
                lframe = (res1(1).quot>TH.freeze(isubject))';

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % We do not want to compute performance on the "non experiment" part, 
                % e.g. when the sensors are attached on body or the user is not yet
                % doing the task. 
                % Therefore we remove the non-experiment parts, which correspond
                % to label '0'.
                % After transformation, there are only frames corresponding to the
                % experiment with label 0=no freeze, 1=freeze
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                % Ground truth of the frames
                gtframe = data(res1(1).time,11);                % 0=no experiment, 1=no freeze, 2=freeze
                % Identify the part of the data corresponding to the experiment
                xp = find(gtframe~=0);

                % Remove the non experiment part from the ground truth and classification 
                gtframe2 = gtframe(xp)-1;       % subtract 1 to have 0 or 1 as labels
                lframe2 = lframe(xp);           % 0=no freeze, 1=freeze
                
        
                subplot(2,1,1)
                plot(1:1:length(lframe2),lframe2(:))
                
                subplot(2,1,2)
                plot(1:1:length(gtframe2),gtframe2(:))
                
                res = x_countTxFx(gtframe2,lframe2,offDelay*SR/stepSize,onDelay*SR/stepSize);
                resrun = resrun + res;

                fprintf(1,'\t\tAxis %d. TP: %d  TN: %d FP: %d FN: %d. Tot freeze: %d\n',iaxis,res);
                
                 %figure;
                 %subplot(2,1,1);
                 %plot(gtframe2);
                 %subplot(2,1,2);
                 %plot(lframe2);
                 %linkaxes;

            end
            fprintf(1,'\tTotal TP: %d  TN: %d FP: %d FN: %d. Tot freeze: %d\n',resrun);    
            fprintf(1,'\tSensitivity: %.2f Specificity: %.2f\n',resrun(1)/(resrun(1)+resrun(4)),resrun(2)/(resrun(2)+resrun(3)));

        end
    end
end %subject

end
