import numpy as np
import sys
from sampen import sampen
from scipy.signal import butter, lfilter, freqz
from scipy import signal
import scipy 
import pyfftw
import matplotlib.pyplot as plt

#%%
def get_features(Features,Train_data,Labels,metadata,pos_walk,sensor): 
   
   '''
   Features ID :
   0. shift : step interval
   1. depth : max-min in one window
   2. counts : number of steps detected in one window
   3. sample entropy : measure the periodic in window (not used because too expensive)
   4. sumLoco : energy in locomation band(0-3Hz)
   5. I : dominant frequency  
   6. freezeIndex : sumFreeze/sumLoco 
   7. sumAll : energy in locomation band(0-3Hz) + energy in freeze band(3-8Hz)
   8. portion : variogram,smoothness of data 

   '''
    features={
        "shift": np.ones(np.size(Train_data)/32),
        "depth": np.zeros(np.size(Train_data)/32),
        "counts": np.zeros(np.size(Train_data)/32),
        "sumLoco" : np.zeros(np.size(Train_data)/32),
        "sumAll" : np.zeros(np.size(Train_data)/32),
        "entropy" : np.zeros(np.size(Train_data)/32),
        "I" : np.zeros(np.size(Train_data)/32),
        "freezeIndex" : np.zeros(np.size(Train_data)/32),
        "labels" : np.zeros(np.size(Train_data)/32),
        "portion" : np.zeros(np.size(Train_data)/32)
    }

    # This value is used to keep the step_depth of a general normal walking pattern
    # It is used to detect one step
    step_depth=0

    # Only call func0 once if 0,1,2 features are need to claculate
    flag_step=0
    # Only call func3 once if 4,5,6,7 features are need to claculate
    flag_freq=0
    
    for i in range(len(Features)):
        if(flag_step==0 and (Features[i]==1 or Features[i]==0 or Features[i]==2)):
            print "Getting shift and depth and counts for sensor",(int(sensor)/3)," on axis ",(int(sensor)%3),"..."
            sys.stdout.flush()
            flag_step=1
            step_depth = func0(Train_data,metadata,features["shift"] ,features["depth"] ,features["counts"] ,pos_walk)
        elif(Features[i]==3):
            print "Getting sample entropy for sensor ",(int(sensor)/3) ," on axis " ,(int(sensor)%3),"..."
            sys.stdout.flush()
            func1(Train_data,metadata,features["entropy"] )

        elif(flag_freq==0 and Features[i]>=4 and Features[i]<=7):
            print "Getting Frequency components ",(int(sensor)/3) ," on axis ", (int(sensor)%3),"..."
            sys.stdout.flush()
            flag_freq = 1
            func3(Train_data,metadata,features["sumLoco"] ,features["I"] ,features["freezeIndex"] ,features["sumAll"])
    

        #elif(Features[i]==9):
        #    func7(Train_data,metadata,features["smooth"] )
        elif(Features[i]==8):
            func7(Train_data,metadata,features["portion"] )
    
    print "pre-labeling data..."
    sys.stdout.flush()

    get_label(Train_data,metadata,Labels,features["labels"])
    # label pre-fog as fog
    # features["labels"] = prelabel(features["labels"])
    #plt.figure()
    #plt.plot(features["labels"][0:500]) 
    return step_depth,features
    
def prelabel(label_t):
    # labeling winodws before FoG as FoG (not used in this case)
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
    # Function that decides wheter to label current window as a FoG or non-FoG
    j_start=0
    index=0
    while (j_start < (len(Train_data) - metadata["windowsize"])):
        train_window = Labels[j_start:j_start+metadata["windowsize"]]
        counter1=0
        counter2=0
        for la in train_window:
            if(la==2):
                counter2 = counter2+1
            if(la==1):
                counter1 = counter1+1
        
        
        labels[index] = 0
        if(counter1>0.7*metadata["windowsize"]):
            labels[index] = 1
        if(counter2>=0.3*metadata["windowsize"]):
            labels[index] = 2
        
        index = index+1
        j_start = j_start+metadata["stepsize"]

#%%
def func0(Train_data,metadata,shift,depth,counts,pos_walk):
    # This function serves to extract step interval, step depth and step counts feature
    jStart=0
    low_pass_data = butter_lowpass_filter(Train_data, 8,metadata["samplingrate"], order=5)
    index=0
    windowsize = metadata["windowsize"]

    # Find the threshold
    while(jStart<len(low_pass_data)-windowsize):
        train_w = low_pass_data[jStart:jStart+windowsize]
        max_value = np.max(train_w)
        min_value = np.min(train_w)
        depth[index] = max_value - min_value
        index=index+1
        jStart = jStart + metadata["stepsize"]
    
    threshold = np.mean(depth[pos_walk[0]:pos_walk[1]])*0.55
    step_depth = threshold
    jStart=0
    index=0

    # find interval
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

        #find counts
        b_counts=0
        p1=1
        p2=1
        for n in range(len(buffer)-1):
            if(buffer[n+1]>buffer[n]):
                p1=n+1
                p2=n+1
            else:           
                if(n==len(buffer)-1):
                    I1=1
                elif(buffer[p1]-buffer[p2]>threshold):
                    I1=p2
                    b_counts=b_counts+1
                    p1=n+1
                    p2=n+1
                else:
                    p2=n+1
        
        counts[index] = b_counts
        index = index+1
        jStart = jStart + metadata["stepsize"]  
    return step_depth

#%%
def func1(Train_data,metadata,entropy):
    # calculate sample entropy
    m=2
    jStart=0
    index=0
    windowsize = metadata["windowsize"]
    while(jStart<len(Train_data)-windowsize):
        train_w = Train_data[jStart:jStart+windowsize]
        r = 0.2*np.std(train_w)
        entropy[index] = sampen(train_w, m, r)

        jStart = jStart+metadata["stepsize"]
        index = index+1

#%%
def func7(Train_data,metadata,smoothness):
    #print "get smoothness"
    jStart=0
    index=0
    windowsize = metadata["windowsize"]
    while(jStart<len(Train_data)-windowsize):
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
    while(jStart<len(Train_data)-windowsize):
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
def func3(Train_data,metadata,sumLoco,I,freezeIndex,sumAll):
    # This function calculate frequency related features
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
    while(jStart<len(Train_data)-windowsize):
        train_w = Train_data[jStart:jStart+windowsize]
        train_w = train_w - np.mean(train_w)
        ar = train_w
        ai = np.zeros(np.size(ar))
        a = ar + 1j*ai
        fft_object = pyfftw.builders.fft(a)
        b = fft_object()
        Pyy = b*np.conjugate(b) / NFFT
        
        sumLoco[index]  = (np.sum(Pyy[f_nr_LBs:f_nr_LBe+1])-(Pyy[f_nr_LBs]+Pyy[f_nr_LBe])/2)/metadata["samplingrate"]
        sumAll[index]  = (np.sum(Pyy[f_nr_LBe:f_nr_FBs+1])-(Pyy[f_nr_LBe]+Pyy[f_nr_FBs])/2)/metadata["samplingrate"]
        freezeIndex[index] = sumAll[index]/sumLoco[index]
        sumAll[index] = sumAll[index]+sumLoco[index]
        
        I[index] = np.argmax(Pyy[0:64])+1
        jStart = jStart+metadata["stepsize"]
        index = index+1





## Low pass filter that used by step interval calculation
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
