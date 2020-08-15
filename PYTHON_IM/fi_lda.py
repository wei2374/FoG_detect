from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
import numpy as np
import matplotlib.pyplot as plt
import classifier

def lda_analysis(features,LDA_Features,filter_ori,metadata):
    training_X = np.zeros(np.size(features[float(1)]["shift"]))
    for i in (LDA_Features):
        if(i==0):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["shift"]))
        elif(i==1):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["depth"]))
        elif(i==2):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["sumLoco"]))
        elif(i==3):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["sumFreeze"]))
        elif(i==4):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["sumHP"]))
        elif(i==5):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["freezeIndex"]))
        elif(i==6):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["I"]))
        elif(i==7):
            for sensor in range(metadata["sensors"]):
                training_X = np.vstack((training_X,features[float(sensor)]["smooth"]))
    
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
    W = lda.coef_

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
        
    


                
                
               
                
        