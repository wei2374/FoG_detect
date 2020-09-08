import numpy as np

def calculate_TF(filter_result,labels):
    t_FoGn=0
    f_FoG=0
    FoGs=0
    t_noFoG=0
    f_noFoG=0
    noFoGs=0
    n_f=0
    correct_fn = 0
    #print np.shape(labels)
    length, = np.shape(labels)
    correct_f =  np.zeros(length)
    t_FoG =   np.zeros(length)
    wrong_f = 0
    
 
    edge_up = np.zeros(length)
    solve_flag=0
    miss_flag=0
    
    # label rising edge and falling edge
    for i in range(1,length):
        if(labels[i]==2 and labels[(i-1)]==1): 
            edge_up[i]=1
        
        if(labels[(i)]==1 and labels[(i-1)]==2):
            edge_up[(i)]=2
       
    
    for i in range(1,length):
       
        if(edge_up[(i)]==1 and filter_result[(i)]==1):
            solve_flag=1 
            t_FoG[(i)]=1
            
            # record before filter results as correct labeled
            i2 = i
            while(filter_result[(i2)]==1):
                correct_f[(i2)]=1
                i2=i2-1
       
        

        
        elif(solve_flag==1 and labels[(i)]==2):
           
            if(filter_result[(i)]==1):
                 correct_f[(i)]=1
            
            t_FoG[(i)]=1
            
        elif(edge_up[(i)]==1 and filter_result[(i)]!=1):
            miss_flag=1
            
        
        elif( miss_flag==1 and filter_result[(i)]==1):
            solve_flag=1
            t_FoG[(i)]=1
            correct_f[(i)]=1
            miss_flag=0
            
        
        elif(edge_up[(i)]==2):
            if(solve_flag==1):
                i2=i
                while(filter_result[(i2)]==1 and i2<len(labels)):
                    correct_f[(i2)]=1
                    i2=i2+1
            solve_flag=0
            miss_flag=0
        
    
    for i in range(length):
        if(filter_result[(i)]==1 and (labels[(i)]>=1)):
            n_f = n_f+1
    
    for i in range(length):
        if(correct_f[(i)]==1):
            correct_fn = correct_fn+1
    
         
    for i in range(length):
        if(t_FoG[(i)]==1):
            t_FoGn = t_FoGn+1
        

    for i in range(length):
        if(labels[(i)]>=1):
            if(filter_result[(i)]==1 and labels[(i)]==2):
                FoGs=FoGs+1
          
            
            if(filter_result[(i)]==1 and labels[(i)]==1):
                noFoGs=noFoGs+1
            
            
            if(filter_result[(i)]==0 and labels[(i)]==1):
                noFoGs=noFoGs+1
            
            
            if(filter_result[(i)]==0 and labels[(i)]==2):
                FoGs=FoGs+1
            
    
    
    recall = float(t_FoGn)/float(FoGs)
    correctness = float(correct_fn)/float(n_f)
    return recall, correctness