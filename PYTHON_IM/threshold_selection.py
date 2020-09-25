import numpy as np

def threshold_selection(TH_Features,means,features,sensor):
    '''
    @ TH_Features : Features selected used as threshold
    @ means : The mean values calculated from walking period and standing period
    @ features : Feature extraction result for windows
    @ sensor : channel of sensor
    This function returns the result of feature thresholding result as a 0101 mask
    '''
    filter_result = np.ones(np.size(features["shift"]),dtype=bool)
    mask={}
    for ths in range(len(TH_Features)):
        # The window is only suspicious of being a possible FoG if its step interval is 
        # smaller than 
        # mean step interval value during normal walking * parameter
        if(TH_Features[ths]==0 and sensor==1 ):
            shift_mask = means["shift"]*np.ones(np.size(features["shift"]))
            mask = features["shift"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==1):
            shift_mask = means["depth"]*np.ones(np.size(features["shift"]))
            mask= features["depth"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==2):
            shift_mask = means["counts"]*np.ones(np.size(features["counts"]))
            mask = features["counts"]<shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==3):
            shift_mask = means["entropy"]*np.ones(np.size(features["entropy"]))
            mask = features["entropy"]>shift_mask
            filter_result = filter_result & mask 
        elif(TH_Features[ths]==4):
            shift_mask = means["sumLoco"]*np.ones(np.size(features["sumLoco"]))
            mask = features["sumLoco"]>shift_mask
            filter_result = filter_result & mask                    
        elif(TH_Features[ths]==5):
            shift_mask = means["I"]*np.ones(np.size(features["I"]))
            mask = features["I"]>shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==6):
            shift_mask = means["freezeIndex"]*np.ones(np.size(features["freezeIndex"]))
            mask = features["freezeIndex"]>shift_mask
            filter_result = filter_result & mask
        # The window is only suspicious of being a possible FoG if its energy is 
        # larger than 
        # mean energy value during stop * parameter    
        elif(TH_Features[ths]==7):
            shift_mask = means["sumAll"]*np.ones(np.size(features["sumAll"]))
            mask = features["sumAll"]>shift_mask
            filter_result = filter_result & mask
        elif(TH_Features[ths]==8):
            shift_mask = means["portion"]*np.ones(np.size(features["portion"]))
            mask = features["portion"]>shift_mask
            filter_result = filter_result & mask

    return filter_result
        
        
        