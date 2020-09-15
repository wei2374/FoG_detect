from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
import numpy as np
import matplotlib.pyplot as plt
import classifier
import sys
import os
def lda_analysis(features,Features,filter_ori,metadata,mask):
    training_X = np.zeros(np.size(features[0]["shift"]))
    sensors = metadata["sensors"]
    for i in (Features):
        if(i==0):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["shift"]))

    
        if(i==1):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["depth"]))

    
        if(i==2):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["counts"]))
    
        if(i==3):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["entropy"]))
    
        if(i==4):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["sumLoco"]))

        
        if(i==5):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["I"]))
    
        if(i==6):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["freezeIndex"]))
    
        if(i==7):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["sumAll"]))

        if(i==8):
            for sensor in range(metadata["sensors"]):
                if(mask[i,sensor]==1):
                    training_X = np.vstack((training_X,features[float(sensor)]["portion"]))



    training_X = training_X[1:,:]
    # get labels
    training_Y = features[float(0)]["labels"]-1
    # filter out other data
    filter_0 = training_Y!=-1
    filter_0 = filter_0 & filter_ori

    training_x = training_X[:,filter_0]
    training_y = training_Y[filter_0]

  

    lda = LDA(n_components=1)

    X_train = lda.fit_transform(training_x.transpose(), training_y)
    W_old = lda.coef_
    print "\r\n"
    print "LDA finishes"
    sys.stdout.flush()

    # refill W
   
    cl=0
    W = np.zeros(len(Features)*sensors)
    #print W

    for i in range(len(Features)):    
        for sensor in range(sensors):
            if(mask[Features[i],sensor]==0):
                W[sensors*(i)+sensor] = 0
            else:
                #print W
                #print i
                #print sensor
                
                W[sensors*(i)+sensor] = W_old[0,cl]
                cl=cl+1
    #print W

    #print "finish lda"

    ## Prepare classifier
    FoGs = []
    noFoGs = []
    for points in range(len(training_y)):
        if(training_y[points]==1):
            FoGs.append(X_train[points])
        else:
            noFoGs.append(X_train[points])

    noFoG_av = np.mean(np.array(noFoGs))
    FoG_av = np.mean(np.array(FoGs))
    noFoGn = len(np.array(noFoGs))
    FoGn = len(np.array(FoGs))
    


    if(metadata["classifier"]==1):
        dtth,TG = classifier.classifier1(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn)
    else:
        dtth,TG = classifier.classifier2(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn)

    print "\r\n"
    print "Classification finishes"
    sys.stdout.flush()
    
    dirname = os.path.dirname(__file__)
    name = os.path.join(dirname,"DATA/P1.txt")

    #print X_train.shape()
    with open(name, 'w') as f:
        for item in range(len(X_train)):
            np.savetxt(f, X_train[item])
    f.close()
    
    name = os.path.join(dirname,"DATA/L1.txt")

    with open(name, 'w') as f:
        for item in range(len(training_y)):
             f.write("%s\n" % training_y[item])
    f.close()
   
    result = X_train>dtth
    name = os.path.join(dirname,"DATA/R1.txt")
    with open(name, 'w') as f:
        for item in range(len(result)):
            f.write("%s\n" % result[item])
    f.close()

    print "Saving result finishes"
    sys.stdout.flush()
    '''
    plt.figure()
    result = X_train>dtth
    plt.plot(result)
    plt.show()
    
    plt.figure()
    plt.plot(training_y)
    plt.show()
    
    plt.figure()
    for points in range(len(training_y)):
        if(training_y[points]==1):
            plt.plot(points,X_train[points],'bo')
        else:
            plt.plot(points,X_train[points],'r+')
    
    plt.plot(noFoG_av*np.ones(np.size(X_train)),'r-')
    plt.plot(FoG_av*np.ones(np.size(X_train)),'bo')
    plt.plot(dtth*np.ones(np.size(X_train)),'y.')
      
    plt.show()
     '''
    

    
    return W,dtth,TG

                
                
               
                
        