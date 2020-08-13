#%%
import numpy as np
import labeling 
import matplotlib.pyplot as plt
import self_adaptive as sa
from scipy.signal import butter, lfilter, freqz
from scipy import signal
from scipy import fft
import pyfftw
#def main_loop():
#%%

sensors = 6
Features = np.array([0,4,5,7])
TH_Features = np.array([0,7])
TH_params = np.array([0.8,5])
LDA_Features = np.array([0,4,5])

metadata = {
    "stepsize": 32,
    "windowsize":128,
    "samplingrate":64,
    "sensors":3,
    "classifier":1   
}

name = ("/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/dataset/S01R01.txt")
data = np.loadtxt(name, usecols=range(0,11))
#%%
# This function is used to relabel the data according to its window
labels = labeling.relabel(data[:,10],metadata)
data[:,10] = labels

Pos =np.array([[[780,3140],[1500,2200],[10000,12000]]])
pos = Pos[0,:,:]
#%%
sa.self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features)



# %%
'''
if __name__ == '__main__':
    try:
        main_loop()
    except rospy.ROSInterruptException:
        pass
'''