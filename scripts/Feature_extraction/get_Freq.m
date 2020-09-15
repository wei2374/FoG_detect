function [sumLoco,sumFreeze,sumHP,freezeIndex,I] = get_Freq(data,windowsize,stepsize,sensor)
%% This function is used to find the autocorrelation
%% Frequency band selection
SR = 64;
NFFT = windowsize;

locoBand=[0.5 3];
freezeBand=[3 8];
f_res = SR / NFFT;
f_nr_LBs  = round(locoBand(1)   / f_res);
f_nr_LBs( f_nr_LBs==0 ) = [];
f_nr_FBe  = round(freezeBand(2) / f_res);
f_nr_LBe  = round(locoBand(2)   / f_res);
f_nr_FBs  = round(freezeBand(1) / f_res);
f_hp_LBe  = 16;
f_hp_FBs  = 32;

j_start = 1;
train_data =  data;
index = 1;

while j_start < length(train_data)- windowsize
    train_w = train_data(j_start:j_start+windowsize-1,sensor);
    
     y = train_w;
     y = y - mean(y);
     Y = fft(y,NFFT);
     Pyy = Y.* conj(Y) / NFFT;
     
     areaLocoBand   = x_numericalIntegration( Pyy(f_nr_LBs:f_nr_LBe), SR );
     areaFreezeBand = x_numericalIntegration( Pyy(f_nr_FBs:f_nr_FBe),  SR );
     areaHPBand = x_numericalIntegration( Pyy(f_hp_LBe:f_hp_FBs),  SR );
     sumLoco(index) = areaLocoBand;%+areaFreezeBand;
     sumFreeze(index) = areaFreezeBand;
     sumHP(index) = areaHPBand;
     
     if(areaLocoBand>0)
        freezeIndex(index) = areaFreezeBand/areaLocoBand;
     else
        freezeIndex(index)=0;
     end
     
     %% Dominant frequency
     % Find the component with maximum energy
     [M,I(index)]= max(Pyy,[],1);
    
    index=index+1;
    j_start = j_start + stepsize;
end
    
    
   
    
end