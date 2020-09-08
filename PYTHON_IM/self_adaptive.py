import numpy as np
import sys
from get_features import get_features
from threshold_selection import threshold_selection
from auto_configuration import auto_configuration
from fi_lda import lda_analysis
import matplotlib.pyplot as plt
#%%
def self_adaptive(data,pos,metadata,Features,TH_Features,TH_params,LDA_Features,Auto):   
    # get the training window
    stepsize = metadata["stepsize"]
    pos_all = [1000*pos[0,0],1000*pos[0,1]]
    pos_walk = [int(pos[1,0]/stepsize),int((pos[1,1])/stepsize)]
    pos_stop = [int((pos[2,0])/stepsize),int((pos[2,1])/stepsize)]
    thresholds = np.zeros((9,metadata["sensors"]))

    index1 =  data[:,0]>pos_all[0]
    index2 =  data[:,0]<pos_all[1]
    index3 = index1&index2
    filter_result = {}
    features_all={}
    means={}
    Train_data = data[index3,:]
    step_depth = np.zeros(metadata["sensors"])
    # get features
    print "\r\n"
    print "Feature extraction starts..."
    sys.stdout.flush()
    for sensor in range(metadata["sensors"]):
        # Feature extraction for one feature
        
        step_depth[sensor], features = get_features(Features,Train_data[:,sensor+1],Train_data[:,10],metadata,pos_walk,sensor)
        
        # Calculates the threhold of features for one sensor
        for ths in range(len(TH_Features)):
            if(TH_Features[ths]==0):
                means["shift"] = np.mean(features["shift"][pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[0,sensor]=means["shift"]
            elif(TH_Features[ths]==1):
                means["depth"] = np.mean(features["depth"][pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[1,sensor]=means["depth"]
            elif(TH_Features[ths]==2):
                means["counts"] = np.mean((features["counts"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[2,sensor]=means["counts"]
            elif(TH_Features[ths]==3):
                means["entropy"] = np.mean((features["entropy"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[3,sensor]=means["entropy"]
            elif(TH_Features[ths]==4):
                means["sumLoco"] = np.mean((features["sumLoco"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[4,sensor]=means["sumLoco"]
            elif(TH_Features[ths]==5):
                means["I"] = np.mean((features["I"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[5,sensor]=means["I"]
            elif(TH_Features[ths]==6):
                means["freezeIndex"] = np.mean((features["freezeIndex"])[pos_walk[0]:pos_walk[1]])*TH_params[ths]
                thresholds[6,sensor]=means["freezeIndex"]
            elif(TH_Features[ths]==7):
                means["sumAll"] = np.mean((features["sumAll"])[pos_stop[0]:pos_stop[1]])*TH_params[ths]
                thresholds[7,sensor]=means["sumAll"]
            elif(TH_Features[ths]==8):
                means["portion"] = np.mean((features["portion"])[pos_stop[0]:pos_stop[1]])*TH_params[ths]
                thresholds[8,sensor]=means["portion"] 

        features_all[sensor] = features
        # Threshold selection for one sensor
        filter_result[sensor] = threshold_selection(TH_Features,means,features,sensor)

    print "\r\n"
    print "Feature extraction finishes"
    sys.stdout.flush()

    # Filter out data which is not part of experiment
    filter_ori = np.asarray(features["labels"]!=0).flatten()
    #plt.plot(filter_ori)
    #plt.show()
    # Filter out data which is not within the thresholds
    for sensor in range(metadata["sensors"]):
        filter_ori = filter_result[float(sensor)]&filter_ori
    #plt.plot(filter_ori)
    #plt.show()
    
    #plt.plot(features["labels"])
    #plt.show()
    
    
    mask = np.zeros([9,9])

    print "\r\n"
    print "Feature selection starts"
    sys.stdout.flush()

    # Auto configuration will select features that to be processed in LDA
    if(int(Auto)==2):
        auto_configuration(features_all,Features,filter_ori,metadata["sensors"],mask)
    else:
        for fea in (LDA_Features):
            for sensor in range(metadata["sensors"]):
                mask[fea,sensor]=1
    
    print mask
    print "\r\n"
    print "Feature selection finishes"
    sys.stdout.flush()

    print "\r\n"
    print "LDA starts"
    sys.stdout.flush()

    if(int(Auto)==2):
        W,dtth,TG = lda_analysis(features_all,Features,filter_ori,metadata,mask)
    else:
        W,dtth,TG = lda_analysis(features_all,LDA_Features,filter_ori,metadata,mask)

    
    return W,dtth,TG,mask,step_depth,thresholds

    
