import numpy as np
from calculate_TF import calculate_TF

'''
Both classifiers implemented in this file use one dimensional decision tree
as classifier, they use different metric to find separate line
@ classifier 1 : scaled version of gini index
@ classifier 2 : new evaluation standard

Find line between mean of FoG and non-FoG mean, try 15 lines, select the line gives best metric
'''
def classifier1(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn):
    TG=0
    n=0
    weights = int(noFoGn/FoGn)
    gini = np.zeros([15,4])

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
    print "F1-score is ",gini[DT_index,1]
    DT_threshold=gini[DT_index,0]
    return DT_threshold,TG


def classifier2(noFoG_av,FoG_av,X_train,training_y,FoGn,noFoGn):
    TG=0
    n=0
    gini = np.zeros([15,4])
    filter_result = np.zeros(np.size(training_y))

    if(FoG_av>noFoG_av):
        TG=1
        diff = FoG_av-noFoG_av
        noFoG_line = noFoG_av-0.2*diff
        thdt = noFoG_line
        
        while(thdt<FoG_av+0.2*diff):


            for i in range(len(X_train)):
                if(X_train[i]>=thdt):
                    filter_result[(i)]=1
                elif(X_train[i]<thdt):
                    filter_result[(i)]=0

            labels = training_y+1
            [recall,correctness] = calculate_TF(filter_result,labels)
            gini[n,0] = thdt
            gini[n,1] = (recall*correctness)/(recall+correctness)                          
            gini[n,2] = recall
            gini[n,3] = correctness
            thdt=thdt+0.1*diff
            n=n+1

    else:
        TG=0
        diff = noFoG_av-FoG_av
        FoG_line = FoG_av-0.2*diff
        thdt = FoG_line
        
        while(thdt<noFoG_av+0.2*diff):


            for i in range(len(X_train)):
                if(X_train[i]<=thdt):
                    filter_result[(i)]=1
                elif(X_train[i]>thdt):
                    filter_result[(i)]=0

            labels = training_y+1
            [recall,correctness] = calculate_TF(filter_result,labels)
            gini[n,0] = thdt
            gini[n,1] = (recall*correctness)/(recall+correctness)                          
            gini[n,2] = recall
            gini[n,3] = correctness
            
            thdt=thdt+0.1*diff
            n=n+1
    # Decision Tree
    DT_index=np.argmax(gini[:,1])
    #print gini
    print "correctness is",gini[DT_index,3],"recall is",gini[DT_index,2],"F1-score is ",2*gini[DT_index,1]
    DT_threshold=gini[DT_index,0]
    return DT_threshold,TG