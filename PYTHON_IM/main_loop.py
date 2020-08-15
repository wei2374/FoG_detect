#%%
import numpy as np
import labeling 
import matplotlib.pyplot as plt
import self_adaptive as sa
from scipy.signal import butter, lfilter, freqz
from scipy import signal
from scipy import fft
import pyfftw
import sys
from get_params import get_params

def main_loop(argv):
    #%%
    # get parameters from UI interface
    patient,sensors,classifer,TH_Features,TH_params,LDA_Features,Features = get_params(sys.argv)

    #creat metadata for the training
    metadata = {
        "stepsize": 32,
        "windowsize":128,
        "samplingrate":64,
        "sensors":int(sensors),
        "classifier":int(classifer)   
    }
   
    #load data from DAPHNET dataset
    if(int(patient)==3):
        name = ("/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/dataset/S03R01.txt")
    else:
        name = ("/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/dataset/S0"+patient+"R01.txt")
    
    data = np.loadtxt(name, usecols=range(0,11))
 
    #%%
    # Relabel the data according to its window
    labels = labeling.relabel(data[:,10],metadata)
    data[:,10] = labels

    # training data
    # 1. lda training data 
    # 2. normal walking gait
    # 3. stop status
    Pos =np.array([[[780,3140],[1500,2200],[10000,12000]],
                    [[680,1000],[1500,5000],[500,1000]],
                    [[270,1015],[1500,2700],[500,1000]],
                    [[270,1015],[1500,2700],[500,1000]],
                    [[600,980],[1000,1700],[600,800]],
                    [[500,2500],[5000,12000],[500,4500]],
                    [[600,1400],[41000,50000],[31000,34000]],
                    [[650,1920],[2000,4300],[500,1500]],
                    [[1680,2600],[1000,5000],[6800,8000]]])

    pos = Pos[int(patient)-1,:,:]
    #%%
    sa.self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features)



# %%

if __name__ == '__main__':
    main_loop(sys.argv[1:])