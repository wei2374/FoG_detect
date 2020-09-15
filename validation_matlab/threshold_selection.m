function [filter_result,Label] = threshold_selection(Thresholds,means,features,sensor,pre)

%% Features selection
visualize =0;
pcol = {[1 1 1],[0 .75 0],'r'};
filter_result = ones(size(features.sumAll));
len = length(Thresholds)+2;
if(visualize==1)
figure(3)
end


% Plot the patches: find the discontinuities in the labels
f = find(features.Label(2:end)-features.Label(1:end-1));
% add a discontinuity at the start and end
f=[0; f'; size(features.Label,2)];
            
  for i=1:len-2
    switch Thresholds(i)
        case 0 
            if(sensor>=0&& pre==0) % only for the ankle sensor
                shift_mask = means.shift*(ones(size(features.shift)));
                mask.shift = features.shift < shift_mask;
                filter_result = filter_result & mask.shift;
                if(visualize==1)
                    subplot(len,1,i)
                    plot(features.shift);
                    hold on
                    plot(shift_mask,'r-');
                    
                    ylabel('step interval');
                    xlabel('time[ms]');
                    
                    title('step interval for sensor'+ string(sensor-1)); 
                   
                    hold off
                    
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 = -10;
                    y2 = 100;
                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
                end
            end
            
         case 1
            if(sensor>=1 && pre==0) % only for the ankle sensor
                shift_mask = means.depth*(ones(size(features.depth)));
                mask.depth = features.depth < shift_mask;
                filter_result = filter_result & mask.depth;
                if(visualize==1)
                    subplot(len,1,i)
                    plot(features.depth);
                    hold on
                    plot(shift_mask,'r-');
                    ylabel('step depth');
                    xlabel('time[ms]');
                    
                    title('step depth for sensor'+ string(sensor-1)); 

                    hold off
                    
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 = 0;
                    y2 = 4000;


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
                end
            end
            
        case 2
            if(pre==0)
            loco_mask = means.counts*(ones(size(features.counts)));
            mask.counts = features.counts<loco_mask;
            filter_result = filter_result & mask.counts;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.counts);
                hold on
                plot(loco_mask,'r-');
                ylabel('step counts');
                xlabel('time[ms]');

                title('step counts for sensor'+ string(sensor-1)); 
                hold off
                
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 = 0;
                    y2 = 10;


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
            end
            end
            
        case 3
            if(pre==0)
            loco_mask = means.entropy*(ones(size(features.entropy)));
            mask.entropy = features.entropy<loco_mask;
            filter_result = filter_result & mask.entropy;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.entropy);
                hold on
                plot(loco_mask,'r-');
                ylabel('sample entropy');
                xlabel('time[ms]');

                title('sample entropy for sensor'+ string(sensor-1)); 
                hold off
                
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.entropy);
                    y2 = max(features.entropy);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
            end
            end   
            
        case 4
            if(pre==0)
            loco_mask = means.Corr*(ones(size(features.Corr)));
            mask.Corr = features.Corr<loco_mask;
            filter_result = filter_result & mask.Corr;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.Corr);
                hold on
                plot(loco_mask,'r-');
                ylabel('max auto-correlation');
                xlabel('time[ms]');

                title('max auto-correlation for sensor'+ string(sensor-1)); 
                hold off
                
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.Corr);
                    y2 = max(features.Corr);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
            end
            end       
            
        case 5
            if(pre==0)
            loco_mask = means.shift2*(ones(size(features.shift2)));
            mask.shift2 = features.shift2<loco_mask;
            filter_result = filter_result & mask.shift2;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.shift2);
                hold on
                plot(loco_mask,'r-');
                ylabel('max auto-correlation');
                xlabel('time[ms]');
                title('auto-correlation shift for sensor'+ string(sensor-1)); 
                hold off
                
                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.shift2);
                    y2 = max(features.shift2);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
            end
            end  
            
            
        case 6
            if(pre==0)
            I_mask = means.sumLoco*(ones(size(features.sumLoco)));
            mask.sumLoco = features.sumLoco>I_mask;
            filter_result = filter_result & mask.sumLoco;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.sumLoco);
                hold on
                plot(I_mask,'r-');
                ylabel('locomotion');
                xlabel('time[ms]');
                title('locomotion energy for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.sumLoco);
                    y2 = max(features.sumLoco);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                
                end
            end
            
        case 7
            if(pre==0)
            I_mask = means.I*(ones(size(features.I)));
            mask.I = features.I>I_mask;
            filter_result = filter_result & mask.I;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.I);
                hold on
                plot(I_mask,'r-');
                ylabel('dominant frequency');
                xlabel('time[ms]');
                title('dominant frequency for sensor'+ string(sensor-1)); 
                hold off
           
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.I);
                    y2 = max(features.I);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                 end
            end  
            
        case 8
            if(pre==0)
            I_mask = means.freezeIndex*(ones(size(features.freezeIndex)));
            mask.freezeIndex = features.freezeIndex>I_mask;
            filter_result = filter_result & mask.freezeIndex;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.freezeIndex);
                hold on
                plot(I_mask,'r-');
                ylabel('freezeIndex');
                xlabel('time[ms]');
                title('freezeIndex for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.freezeIndex);
                    y2 = max(features.freezeIndex);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
                end
            end   
        case 9
            if(pre==0)
            I_mask = means.sumAll*(ones(size(features.sumAll)));
            mask.sumAll = features.sumAll>I_mask;
            filter_result = filter_result & mask.sumAll;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.sumAll);
                hold on
                plot(I_mask,'r-');
                ylabel('sumAll');
                xlabel('time[ms]');
                title('sumAll for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.sumAll);
                    y2 = max(features.sumAll);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
            end   
            end
        case 10
            if(pre==0)
            I_mask = means.smooth*(ones(size(features.smooth)));
            mask.smooth = features.smooth>I_mask;
            filter_result = filter_result & mask.smooth;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.smooth);
                hold on
                plot(I_mask,'r-');
                ylabel('smooth');
                xlabel('time[ms]');
                title('smooth for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.smooth);
                    y2 = max(features.smooth);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
            end  
            end

        case 11
            if(pre==0)
            I_mask = means.Cwt*(ones(size(features.Cwt)));
            mask.Cwt = features.Cwt>I_mask;
            filter_result = filter_result & mask.Cwt;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.Cwt);
                hold on
                plot(I_mask,'r-');
                ylabel('cwt');
                xlabel('time[ms]');
                title('cwt for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.Cwt);
                    y2 = max(features.Cwt);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
            end 
            end
            
        case 12
            if(pre==0)
            I_mask = means.portion*(ones(size(features.portion)));
            mask.portion = features.portion>I_mask;
            filter_result = filter_result & mask.portion;
            if(visualize==1)
                subplot(len,1,i)
                plot(features.portion);
                hold on
                plot(I_mask,'r-');
                ylabel('portion');
                xlabel('time[ms]');
                title('portion for sensor'+ string(sensor-1)); 
                hold off
            
                                                % iterate the discontinuities
                for i2=1:size(f,1)-1
                    x1 = (f(i2));           % Time of start in ms 
                    x2 = (f(i2+1));          % Time of end in ms
                    type = features.Label(f(i2)+1);
                    y1 =  min(features.portion);
                    y2 = max(features.portion);


                    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                    alpha(.5);
                end
            end
            end
          
    end
  end
  
  

    
        
   % features.Label = labeling2(features.Label);
    Label = features.Label;
    %% Label
    
    if(visualize==1)
    figure(3)
    subplot(len,1,i+1)
    plot(features.Label);
    title('labels')

    subplot(len,1,i+2)
    plot(filter_result);
    title('result')
    end
    
    
end