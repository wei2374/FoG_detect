import numpy as np
from get_features import get_features
from threshold_selection import threshold_selection
from fi_lda import lda_analysis
import matplotlib.pyplot as plt
#%%
def self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features):   
    # get the training window
    stepsize = metadata["stepsize"]
    pos_all = [1000*pos[0,0],1000*pos[0,1]]
    pos_walk = [int(pos[1,0]/stepsize),int((pos[1,1])/stepsize)]
    pos_stop = [int((pos[2,0])/stepsize),int((pos[2,1])/stepsize)]

    index1 =  data[:,0]>pos_all[0]
    index2 =  data[:,0]<pos_all[1]
    index3 = index1&index2
    filter_result = {}
    features_all={}
    means={}
    Train_data = data[index3,:]
    for sensor in range(metadata["sensors"]):
        # Feature extraction for one feature
        features = get_features(Features,Train_data[:,sensor+1],Train_data[:,10],metadata,pos_walk,sensor)
        
        # Calculates the threhold of features for one sensor
        for ths in range(len(TH_Features)):
            if(TH_Features[ths]==0):
                means["shift"] = np.mean(features["shift"][pos_walk[0]:pos_walk[1]])*TH_params[ths]
            elif(TH_Features[ths]==1):
                means["depth"] = np.mean(features["depth"][pos_walk[0]:pos_walk[1]])*TH_params[ths]
            elif(TH_Features[ths]==2):
                means["sumLoco"] = np.mean((features["sumLoco"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
            elif(TH_Features[ths]==5):
                means["freezeIndex"] = np.mean((features["freezeIndex"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
            elif(TH_Features[ths]==6):
                means["I"] = np.mean((features["I"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
            elif(TH_Features[ths]==7):
                means["smooth"] = np.mean((features["smooth"])[pos_stop[0]:pos_stop[1]])*TH_params[ths]
        
        features_all[sensor] = features
        # Threshold selection for one sensor
        filter_result[sensor] = threshold_selection(TH_Features,means,features,sensor)

    print "finish threshold selection"
    # Filter out data which is not part of experiment
    filter_ori = np.asarray(features["labels"]!=0).flatten()
    
    # Filter out data which is not within the thresholds
    for sensor in range(metadata["sensors"]):
        filter_ori = filter_result[float(sensor)]&filter_ori
    
    #plt.plot(filter_ori)
    #plt.show()
    #plt.plot(features["labels"])
    #plt.show()
    print "start LDA"
    lda_analysis(features_all,LDA_Features,filter_ori,metadata)
    

    
