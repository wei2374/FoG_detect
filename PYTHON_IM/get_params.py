import numpy as np
def get_params(params):
    '''
    This function serves to gives values to variables that we are going to use in our code
    The return values are :
    @ Auto: auto select or manual select lda features and sensor number
    @ patient: patient id
    @ sensors: how many sensors to use
    @ classifer: metric for decision tree 
    @ TH_Features: threshold features  
    @ TH_params: parameters that use to calculate threshold for each feature 
    @ LDA_Features: manually selected LDA features 
    @ Features: compilation of LDA features and threshld features
    '''
    
    #get patient ID
    patient = params[1]
    #get numbers of sensor channels to use, we can choose only 3(only ankle), 6(ankle+knee) or 9(ankle+knee+waist)
    sensors = params[2]
    #the metric for one dimensional decision tree, new evaluation standard or gini index
    classifer = params[30]
    
    #get threshold features, which features is going to be used as filter
    THS=[]
    #print "THS"
    for i in params[3:21:2]:
        THS.append(i)
    #    print i 

    #get threshold features parameters, used to calculate the threshold for features.
    THP=[]
    #print "THP"
    for i in params[4:22:2]:
        THP.append(i)
    #    print i

    #get threshold features from binary to decimal(from 0101... mask to 1 2 3 ...)
    features=[]
    thparams=[]
    for i in range(len(THS)):
        if(THS[i]=="1"):
            features.append(i)
            thparams.append(float(THP[i]))
    
    # change from list to arrray
    TH_Features = np.asarray(features)
    TH_params = np.asarray(thparams)

    # Auto mode? 
    Auto = params[31]

    #get lda features
    LDAS=[]
    #print "LDAS"
    for i in params[21:30]:
        LDAS.append(i)
    #    print i

    #get lda features from binary to decimal(from 0101... mask to 1 2 3 ...)
    ldafeatures=[]
    for i in range(len(THS)):
        if(LDAS[i]=="1"):
            ldafeatures.append(i)
    #        print i
    LDA_Features = np.asarray(ldafeatures)

    # get all features selected, a intersection of all lda features and threshold features,
    # This is the features we need to calculate
    Features_ALL = sorted(features+ldafeatures)  
    temp = []
    for x in Features_ALL:
        if x not in temp:
            temp.append(x)
    features = temp
    Features = np.asarray(features)

    return Auto,patient,sensors,classifer,TH_Features,TH_params,LDA_Features,Features