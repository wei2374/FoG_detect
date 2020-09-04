from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
import numpy as np
import matplotlib.pyplot as plt
import classifier

def lda_analysis(features,LDA_Features,Features,filter_ori,metadata,mask,Auto):
    training_X = np.zeros(np.size(features[float(1)]["shift"]))
    sensors = metadata["sensors"]
    if(Auto==1):
        for i in (LDA_Features):
            if(i==0):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["shift"]))
            elif(i==1):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["depth"]))
            elif(i==2):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["counts"]))
            elif(i==3):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["entropy"]))
            elif(i==4):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["sumLoco"]))
            elif(i==5):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["I"]))
            elif(i==6):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["freezeIndex"]))
            elif(i==7):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["sumAll"]))
            elif(i==8):
                for sensor in range(metadata["sensors"]):
                    training_X = np.vstack((training_X,features[float(sensor)]["portion"]))
    else:
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
    training_Y = features[float(1)]["labels"]-1
    # filter out other data
    filter_0 = training_Y!=-1
    filter_0 = filter_0 & filter_ori

    training_x = training_X[:,filter_0]
    training_y = training_Y[filter_0]

  

    lda = LDA(n_components=1)

    X_train = lda.fit_transform(training_x.transpose(), training_y)
    W_old = lda.coef_
    
    # refill W
    if(Auto==2):
        cl=0
        W = np.zeros(len(Features)*sensors)
        print W

        for i in range(len(Features)):    
            for sensor in range(sensors):
                if(mask[i,sensor]==0):
                    W[sensors*(i)+sensor] = 0
                else:
                    print W_old.shape
                    W[sensors*(i)+sensor] = W_old[0,cl]
                    cl=cl+1
    else:
        W = W_old

    print "finish lda"

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
    

    dtth,TG = classifier.classifier1(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn)
    print "finish classify"
    return W,dtth,TG
    
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
        
    


                
                
               
                
        