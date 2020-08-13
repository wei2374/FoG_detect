import numpy as np

def threshold_selection(TH_Features,means,features,sensor):
    filter_result = np.ones(np.size(features["shift"]),dtype=bool)
    mask={}
    for ths in range(len(TH_Features)):
        if(TH_Features[ths]==0 and sensor==1 ):
            shift_mask = means["shift"]*np.ones(np.size(features["shift"]))
            mask = features["shift"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==1):
            shift_mask = means["depth"]*np.ones(np.size(features["shift"]))
            mask= features["depth"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==2):
            shift_mask = means["sumLoco"]*np.ones(np.size(features["shift"]))
            mask = features["sumLoco"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==5):
            shift_mask = means["freezeIndex"]*np.ones(np.size(features["shift"]))
            mask = features["freezeIndex"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==6):
            shift_mask = means["I"]*np.ones(np.size(features["shift"]))
            mask = features["I"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==7):
            shift_mask = means["smooth"]*np.ones(np.size(features["shift"]))
            mask = features["smooth"]<shift_mask
            filter_result = filter_result & mask

    return filter_result
        
        
        