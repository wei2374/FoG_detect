import numpy as np

def classifier1(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn):
    TG=0
    n=0
    weights = int(noFoGn/FoGn)
    gini = np.zeros([15,2])
    if(FoG_av>noFoG_av):
        TG=1
        diff = FoG_av-noFoG_av
        noFoG_line = noFoG_av-0.2*diff
        thdt = noFoG_line
        
        while(thdt<FoG_av+0.2*diff):
            true_FoG=0
            true_noFoG=0
            class1=0
            class2=0

            for i in range(len(X_train)):
                if(X_train[i]>=thdt):
                    if(training_y[i]==1):
                        true_FoG = true_FoG+weights
                        class1 = class1+weights
                    else:
                        class1 = class1+1
                elif(X_train[i]<thdt):
                    if(training_y[i]==0):
                        true_noFoG =  true_noFoG+1
                        class2 = class2+1
                    else:
                        class2 = class2+weights

            gini[n,0] = thdt
            p1 = float(true_FoG)/class1
            p2 = float(true_noFoG)/class2
            gini[n,1] = (1-p1)*p1+(1-p2)*p2                            

            thdt=thdt+0.1*diff
            n=n+1

    else:
        TG=0
        diff = noFoG_av-FoG_av
        FoG_line = FoG_av-0.2*diff
        thdt = FoG_line
        
        while(thdt<noFoG_av+0.2*diff):
            true_FoG=0
            true_noFoG=0
            class1=0
            class2=0

            for i in range(len(X_train)):
                if(X_train[i]<=thdt):
                    if(training_y[i]==1):
                        true_FoG = true_FoG+weights
                        class1 = class1+weights
                    else:
                        class1 = class1+1
                elif(X_train[i]>thdt):
                    if(training_y[i]==0):
                        true_noFoG =  true_noFoG+1
                        class2 = class2+1
                    else:
                        class2 = class2+weights

            gini[n,0] = thdt
            p1 = float(true_FoG)/class1
            p2 = float(true_noFoG)/class2
            gini[n,1] = (1-p1)*p1+(1-p2)*p2                            

            thdt=thdt+0.1*diff
            n=n+1
    # Decision Tree
    DT_index=np.argmax(gini[:,1])
    DT_threshold=gini[DT_index,0]
    return DT_threshold,TG