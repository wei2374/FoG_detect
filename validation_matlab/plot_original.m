function plot_original(data)
 pcol = {[1 1 1],[0 .75 0],'r'};
 
    SR=64;
    
    yltext={'X','Y','Z'};
    ttext={'sensor ankle','sensor knee', 'sensor hip'};
    figure(33)
    %subplot(4,1,4)
    for sensorpos = 0:0
        for sensoraxis = 1:1
            
            %subplot(3,3,1+sensoraxis*3 + sensorpos);
            %subplot(3,1,1+sensoraxis);
            
            % Plot the patches: find the discontinuities in the labels
            f = find(data(2:end,11)-data(1:end-1,11));
            % add a discontinuity at the start and end
            f=[0; f; size(data,1)];

            
            
            % iterate the discontinuities
            for i=1:size(f,1)-1
                x1 = data(f(i)+1,1)/1000;           % Time of start in ms 
                x2 = data(f(i+1),1)/1000;           % Time of end in ms
                type = data(f(i)+1,11);
                y1 = -1000;
                y2 = -2000;
                
                %if type~=2
%                    continue;
 %               end
                
                patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
                %fprintf(1,'Patch type %d in [%d-%d]\n',type,x1,x2);
                
            end

            hold on;
            %low_pass = lowpass(data(:,2+sensorpos*3+sensoraxis),10,SR);
            plot(data(:,1)/1000,data(:,2+sensorpos*3+sensoraxis));
            hold off
            %plot(data(:,1)/1000,low_pass);
            
            a=axis;
            a(1)=data(1,1)/1000;
            a(2)=data(end,1)/1000;
            a(3)=-3500;
            a(4)=+3000;
            axis(a);
            
            xlabel('time [s]');
            ylabel(['Acc ' yltext{1+sensoraxis} '[mg]']);
            title(ttext{1+sensorpos});
            
        end
    end
    end
    