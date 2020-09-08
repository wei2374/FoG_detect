import numpy as np
from scipy.stats import spearmanr

def auto_configuration(features_all,Features,filter_ori,sensors,mask):
    print "IN AUTO_CONFIGURATION"
    result_corr = np.ones((9,sensors))
    for f in range(len(Features)):
        if (Features[f]==0):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["shift"][filter_ori==1])
               c1 = features_all[sensor]["shift"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==1):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["depth"][filter_ori==1])
               c1 = features_all[sensor]["depth"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==2):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["counts"][filter_ori==1])
               c1 = features_all[sensor]["counts"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==3):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["entropy"][filter_ori==1])
               c1 = features_all[sensor]["entropy"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p
                
        if (Features[f]==4):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["sumLoco"][filter_ori==1])
               c1 = features_all[sensor]["sumLoco"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==5):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["I"][filter_ori==1])
               c1 = features_all[sensor]["I"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==6):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["freezeIndex"][filter_ori==1])
               c1 = features_all[sensor]["freezeIndex"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==7):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["sumAll"][filter_ori==1])
               c1 = features_all[sensor]["sumAll"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p

        if (Features[f]==8):
            for sensor in range(sensors):
               norm =  np.linalg.norm(features_all[sensor]["portion"][filter_ori==1])
               c1 = features_all[sensor]["portion"][filter_ori==1]/norm
               c2 =  features_all[sensor]["labels"][filter_ori==1]
               coef, p = spearmanr(c1, c2)
               result_corr[f,sensor] = p
    
    # Filtering
    for f in Features:
        for sensor in range(sensors):
            if(result_corr[f,sensor]<=0.05):
                mask[f,sensor]=1
            #if(f==8):
            #    mask[f,sensor]=0