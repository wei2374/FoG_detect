% Compute the freezing index
% SR: Sample rate in herz
% Original version allowed various FFT sizes - now FFT and window size must
% be equal

function res = x_fi2(data,SR,stepSize,dataA)   

    NFFT = 256;
    locoBand=[0.5 3];
    freezeBand=[3 8];
    windowLength=256;
        
    f_res = SR / NFFT;
    f_nr_LBs  = round(locoBand(1)   / f_res);
    f_nr_LBs( f_nr_LBs==0 ) = [];
    f_nr_LBe  = round(locoBand(2)   / f_res);
    f_nr_FBs  = round(freezeBand(1) / f_res);
    f_nr_FBe  = round(freezeBand(2) / f_res);

    d = NFFT/2;

    % Online implementation
    % jPos is the current position, 0-based, we take a window 
    jPos = windowLength+1;      % This should not be +1 but we follow Baechlin's implementation.
    i=1;
    
    % Iterate the FFT windows
    while jPos <= length(data)       
        jStart = jPos - windowLength + 1;
        % Time (sample nr) of this window
        time(i) = jPos;             
               
        % get the signal in the window
        y = data(jStart:jPos);
        y_mean(i) = mean(y);
        y = y - mean(y); % make signal zero-mean

        % Compute FFT
        Y = fft(y,NFFT);
        % Compute the energy on each frequency components
        Pyy = Y.* conj(Y) / NFFT;
        
        %%
        % put everything in this time window into a buffer
        buffer(i,:) = y;
        
        %%
         % --- calculate sumLocoFreeze and freezeIndex ---
         areaLocoBand   = x_numericalIntegration( Pyy(f_nr_LBs:f_nr_LBe), SR );
         areaFreezeBand = x_numericalIntegration( Pyy(f_nr_FBs:f_nr_FBe),  SR );
        
         sumLocoFreeze(i) = areaFreezeBand + areaLocoBand;
 
         freezeIndex(i) = areaFreezeBand/areaLocoBand;
         if(isnan(freezeIndex(i)))
         freezeIndex(i) = 0;
         
         end
         % --------------------
        label(i) = dataA(jPos,11);
        % next window

        % Ground truth of the frames
        gtframe(i) = dataA(jPos,11);
       
        jPos = jPos + stepSize;
        i = i + 1;
        %break;
    end

%%
%{
for i=1:length(freezeIndex)-1
        if(~warnA(i))
            freezeIndex(i)=0;
        end
end
%}
%%
%{
save ('label.mat','label');
save ('dominantF.mat','I');
save ('mean.mat','y_mean');
save ('freezeIndex.mat','freezeIndex');
save ('neighbour_V.mat','sum_V');
save ('portion_above','pa');
%}
%%
%{
FoG_data = [I;freezeIndex;sum_V;label];
% Identify the part of the data corresponding to the experiment
xp = find(gtframe~=0);
gtframe2 = gtframe(xp)-1; 
FoG_data = FoG_data(:,xp); 
save ('FoG_data.mat','FoG_data');
%}
%%
sum1 = 0;
for i=1:length(freezeIndex)-1
    if(freezeIndex(i)>3)
        sum1=sum1+1;
    end
end

pro2 = sum1/(length(freezeIndex)-1);
    
res.sum = sumLocoFreeze;
res.quot = freezeIndex;
res.time = time;
res.buffer = buffer;

end