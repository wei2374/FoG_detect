import numpy as np
def get_params(params):

    #print params
    #get patient number, sensors numbers
    patient = params[1]
    sensors = params[2]
    classifer = params[30]
    
    #get threshold features
    THS=[]
    #print "THS"
    for i in params[3:21:2]:
        THS.append(i)
    #    print i 

    #get threshold features parameters
    THP=[]
    #print "THP"
    for i in params[4:22:2]:
        THP.append(i)
    #    print i

    #get threshold features selected
    features=[]
    thparams=[]
    for i in range(len(THS)):
        if(THS[i]=="1"):
            features.append(i)
            thparams.append(float(THP[i]))
        #    print i
        #    print THP[i]
    
    TH_Features = np.asarray(features)
    TH_params = np.asarray(thparams)

    # Auto
    Auto = params[31]
    if(Auto==2):
        sensors = 9
        classifer = 2
        LDA_Features=[]
        Features = np.asarray([0,1,2,3,4,5,6,7,8])

    else:
            
        #get lda features
        LDAS=[]
        #print "LDAS"
        for i in params[21:30]:
            LDAS.append(i)
        #    print i

        #get lda features selected
        ldafeatures=[]
        for i in range(len(THS)):
            if(LDAS[i]=="1"):
                ldafeatures.append(i)
        #        print i
        LDA_Features = np.asarray(ldafeatures)

        #get all features selected
        Features_ALL = sorted(features+ldafeatures)  
        temp = []
        for x in Features_ALL:
            if x not in temp:
                temp.append(x)
        features = temp
        Features = np.asarray(features)

    return Auto,patient,sensors,classifer,TH_Features,TH_params,LDA_Features,Features