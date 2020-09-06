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
    print "INTO PYTHON CODE"
    #%%
    # get parameters from UI interface
    Auto,patient,sensors,classifer,TH_Features,TH_params,LDA_Features,Features = get_params(sys.argv)

    # DEBUG::
    '''
    patient="1"
    sensors=2
    classifer=3

    LDA_Features=[1,2]
    Features=[0,1,2,3,4,5,6,7,8]

    Auto=1
      
    print Features
    print LDA_Features
    print TH_Features
    print TH_params
    print sensors
'''

  

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
    W,dtth,TG,mask,step_depth,thresholds = sa.self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features,Auto)

    # fill data

    Step_depth = np.zeros((9,),dtype=float)
    Thresholds = np.zeros((9,9),dtype=float)
    Paras = np.zeros((9*9,),dtype=float)

    lens = len(step_depth)
    for i in range(lens):
        Step_depth[i] = step_depth[i] 

    print thresholds.shape
    x,lens = thresholds.shape
    for i in range(lens):
        for j in range(9):
            Thresholds[j][i] = thresholds[j][i]     

    print W.shape
    lens = len(W)

    counter=0
    for i in range(9):
        sensor=0
        while(sensor<int(sensors)):
            Paras[i*9+sensor] = W[counter]
            counter=counter+1 
            sensor=sensor+1

    ## save into file
    with open('Parameters/P1T.txt', 'w') as f:
        for item in Step_depth:
            f.write("%s\n" % item)
        for row in Thresholds:
            np.savetxt(f, row)
        for row in mask:
            np.savetxt(f, row)
        for item in Paras:
            f.write("%s\n" % item)        
    
        f.write("%s\n" % dtth)
        f.write("%s\n" % TG)

        
        


    f.close()
# %%

if __name__ == '__main__':
    main_loop(sys.argv[1:])
