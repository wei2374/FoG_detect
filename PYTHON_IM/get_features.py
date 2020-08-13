import numpy as np
from scipy.signal import butter, lfilter, freqz
from scipy import signal
import scipy 
import pyfftw
import matplotlib.pyplot as plt
#%%
def get_features(Features,Train_data,Labels,metadata,pos_walk,sensor): 
    features={
        "shift": np.ones(np.size(Train_data)/32),
        "depth": np.zeros(np.size(Train_data)/32),
        "smooth": np.zeros(np.size(Train_data)/32),
        "sumLoco" : np.zeros(np.size(Train_data)/32),
        "sumFreeze" : np.zeros(np.size(Train_data)/32),
        "sumHP" : np.zeros(np.size(Train_data)/32),
        "I" : np.zeros(np.size(Train_data)/32),
        "freezeIndex" : np.zeros(np.size(Train_data)/32),
        "labels" : np.zeros(np.size(Train_data)/32),
        "portion" : np.zeros(np.size(Train_data)/32)
    }

    for i in range(len(Features)):
        if((Features[i]==1 or Features[i]==0)and sensor==1):
            func0(Train_data,metadata,features["shift"] ,features["depth"] ,pos_walk)
        elif(Features[i]==7):
            func7(Train_data,metadata,features["smooth"] )
        elif(Features[i]==8):
            func8(Train_data,metadata,features["portion"] )
        elif(Features[i]>=2 and Features[i]<=6):
            func3(Train_data,metadata,features["sumLoco"] ,features["sumFreeze"] ,features["sumHP"] ,features["freezeIndex"],features["I"])
    
    get_label(Train_data,metadata,Labels,features["labels"])
    # label pre-fog as fog
    features["labels"] = prelabel(features["labels"])
    #plt.figure()
    #plt.plot(features["labels"][0:500]) 
    return features
    
def prelabel(label_t):
    buffer = label_t
    pre = np.asarray(np.where(label_t==2))
    lenth = np.size(pre)
    pre = pre.flatten()
    pre2 = np.zeros(np.size(pre))
    for n in range(1,lenth):
        if(pre[n]-1==pre[n-1]):
            pre2[n]=0
        else:
            pre2[n]=1

    pre2[0] = 1
    pre3 = pre[pre2==1]
    pre4 = np.concatenate((pre3-1,pre3-2),axis=0)
    

    for n in range(len(pre4)):
        buffer[pre4[n]]==2

    labels = buffer
    return labels

def get_label(Train_data,metadata,Labels,labels):
    j_start=0
    index=0
    while (j_start < (len(Train_data) - metadata["windowsize"])):
        labels[index] = Labels[j_start] 
        index = index+1
        j_start = j_start+metadata["stepsize"]

#%%
def func0(Train_data,metadata,shift,depth,pos_walk):
    #print "get interval"
    jStart=0
    low_pass_data = butter_lowpass_filter(Train_data, 8,metadata["samplingrate"], order=5)
    index=0
    windowsize = metadata["windowsize"]

    while(jStart<len(low_pass_data)-windowsize):
        train_w = low_pass_data[jStart:jStart+windowsize]
        max_value = np.max(train_w)
        min_value = np.min(train_w)
        depth[index] = max_value - min_value
        index=index+1
        jStart = jStart + metadata["stepsize"]
    
    threshold = np.mean(depth[pos_walk[0]:pos_walk[1]])*0.5
    jStart=0
    index=0

    while(jStart<len(low_pass_data)-windowsize):
        train_w = low_pass_data[jStart:jStart+windowsize]
        buffer = train_w
        count = 1
        p1=1
        p2=1
        I1=1

        for n in range(len(buffer)-1):
            # if increases
            if(buffer[n+1]>buffer[n]):
                p1=n+1
                p2=n+1
            else:
                # does not find one step until the end
                if(n==len(buffer)-1):
                    I1=1
                # find one step 
                elif(buffer[p1]-buffer[p2]>threshold):
                    I1=p2
                    count=I1
                    break
                else:
                    p2=n+1
        # restart to find another point from current pos
        p1=count
        p2=count
        I2=I1
        for n in range(count,len(buffer)-1):
            # if increases
            if(buffer[n+1]>buffer[n]):
                p1=n+1
                p2=n+1
            else:
                # only find one step in the window
                if(n==len(buffer)-1):
                    I2=I1
                # find another step 
                elif(buffer[p1]-buffer[p2]>threshold):
                    I2=p2
                    break
                else:
                    p2=n+1

        # no step is found
        if(I1==1 and I2==1):
            interval=-10
        else:
            interval=abs(I2-I1)
        
        shift[index] = interval
        index = index+1
        jStart = jStart + metadata["stepsize"]
        
    
    
#%%
def func7(Train_data,metadata,smoothness):
    #print "get smoothness"
    jStart=0
    index=0
    windowsize = metadata["windowsize"]
    while(jStart<len(Train_data)-jStart):
        train_w = Train_data[jStart:jStart+windowsize]
        smoothness[index] = 0
        for j in range(1,len(train_w)):
            smoothness[index] =  smoothness[index] + (train_w[j]-train_w[j-1])*(train_w[j]-train_w[j-1])

        smoothness[index] = smoothness[index]/(windowsize-1)
        
        jStart = jStart+metadata["stepsize"]
        index = index+1

#%%
def func8(Train_data,metadata,portion):
    #print "get portion"
    jStart=0
    index=0
    windowsize = metadata["windowsize"]
    while(jStart<len(Train_data)-jStart):
        train_w = Train_data[jStart:jStart+windowsize]

        for j in range(1,len(train_w)):
            mean = np.mean(train_w)
            p1=0
            for n in range(len(train_w)):
                if train_w[n]>mean:
                    p1=p1+1
            
        portion[index] = p1/len(train_w)
        
        jStart = jStart+metadata["stepsize"]
        index = index+1


# This function is used to get frequency information 
def func3(Train_data,metadata,sumLoco,sumFreeze,sumHP,freezeIndex,I):
    jStart=0
    index=0
    windowsize = metadata["windowsize"]
    NFFT = windowsize

    f_nr_LBs  = 0
    f_nr_FBe  = 5
    f_nr_LBe  = 5
    f_nr_FBs  = 15
    f_hp_LBe  = 15
    f_hp_FBs  = 31

    windowsize = metadata["windowsize"]
    while(jStart<len(Train_data)-jStart):
        train_w = Train_data[jStart:jStart+windowsize]
        train_w = train_w - np.mean(train_w)
        ar = train_w
        ai = np.zeros(np.size(ar))
        a = ar + 1j*ai
        fft_object = pyfftw.builders.fft(a)
        b = fft_object()
        Pyy = b*np.conjugate(b) / NFFT
        
        sumLoco[index]  = (np.sum(Pyy[f_nr_LBs:f_nr_LBe+1])-(Pyy[f_nr_LBs]+Pyy[f_nr_LBe])/2)/metadata["samplingrate"]
        sumFreeze[index]  = (np.sum(Pyy[f_nr_LBe:f_nr_FBs+1])-(Pyy[f_nr_LBe]+Pyy[f_nr_FBs])/2)/metadata["samplingrate"]
        sumHP[index]  = (np.sum(Pyy[f_hp_LBe:f_hp_FBs+1])-(Pyy[f_hp_LBe]+Pyy[f_hp_FBs])/2)/metadata["samplingrate"]
        freezeIndex[index] = sumFreeze[index]/sumLoco[index]
        I[index] = np.argmax(Pyy)+1
        jStart = jStart+metadata["stepsize"]
        index = index+1





def butter_lowpass(cutoff, fs, order=5):
    nyq = 0.5 * fs
    normal_cutoff = cutoff / nyq
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return b, a

def butter_lowpass_filter(data, cutoff, fs, order=5):
    b, a = butter_lowpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y    

# %%
