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

#def main_loop(argv):
print "INTO PYTHON CODE"
#%%
# get parameters from UI interface
# patient,sensors,classifer,TH_Features,TH_params,LDA_Features,Features = get_params(sys.argv)

# DEBUG::
patient="1"
sensors=2
classifer=3
TH_Features=[8]
TH_params=[5]
LDA_Features=[1]
Features=[0,1,2,3,4,5,6,7]

Auto=2



#creat metadata for the training
metadata = {
    "stepsize": 32,
    "windowsize":128,
    "samplingrate":64,
    "sensors":int(sensors),
    "classifier":int(classifer)   
}



#print Features
    

#load data from DAPHNET dataset
if(int(patient)==2):
    name = ("/home/wei/Documents/Forschung/DAPHNET/dataset_fog_release/dataset/S02R02.txt")
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
Pos =np.array([[[780,3140],[1500,2200],[31000,32000]],
                [[200,1200],[100,3000],[16000,17000]],
                
                [[270,4000],[31800,32200],[30000,31000]],
                [[600,980],[1000,1700],[600,800]],
                [[500,2500],[5000,12000],[500,4500]],
                [[600,1800],[42400,43800],[31000,34000]],
                [[650,1200],[2000,4300],[6200,6400]],
                [[1680,2600],[1000,5000],[7000,7200]]])

pos = Pos[int(patient)-1,:,:]

#%%
sa.self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features,Auto)



# %%
'''
if __name__ == '__main__':
    main_loop(sys.argv[1:])
    '''