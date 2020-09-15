function [recall,correctness,specifity] = calculate_TF(filter_result,labels,visualize)
    t_FoGn=0;
    f_FoG=0;
    FoGs=0;
    t_noFoG=0;
    f_noFoG=0;
    noFoGs=0;
    n_f=0;
    correct_fn = 0;
    correct_f =  zeros(1,length(labels));
    t_FoG =  zeros(1,length(labels));
    wrong_f = 0;
    
    if(visualize==1)
    figure(7)
    end
    edge_up = zeros(1,length(labels));
    solve_flag=0;
    miss_flag=0;
    
    for i=2:length(labels)
        if(labels(i)==2&&labels(i-1)==1) %FoG uprising edge
            edge_up(i)=1;
        end
        
        if(labels(i)==1&&labels(i-1)==2) %FoG down edge
            edge_up(i)=2;
        end
    end
    
    for i=1:length(labels)
       
        %% successfully detect before edge is coming
  
        if(edge_up(i)==1 && filter_result(i)==1)
            solve_flag=1;
            
            % detect true fog 
            t_FoG(i)=1;
            
            % record before filter results as correct labeled
            i2 = i;
            while(i2>=1&& filter_result(i2)==1 && i-i2<=4)
                correct_f(i2)=1;
                i2=i2-1;
            end
            if(visualize==1)
            plot(i,labels(i),'y.');
            hold on
            end
        
        %% during the process are saved from FoG
        
        elseif(solve_flag==1 && labels(i)==2)
           
             % record filter results as correct labeled
            if(filter_result(i)==1)
                 correct_f(i)=1;
            end
             t_FoG(i)=1;
            if(visualize==1)
            plot(i,labels(i),'b.');
            
            
            hold on
            end
        
        %% missed coming edge, does not solve in the very begining
        elseif(edge_up(i)==1 && filter_result(i)~=1)
            miss_flag=1;
            
           if(visualize==1)
            plot(i,labels(i),'r.');
            hold on
            end
        
        
        %% successfully solved after the edge comes
        elseif( miss_flag==1 && filter_result(i)==1)
            solve_flag=1;
             t_FoG(i)=1;
            correct_f(i)=1;
            miss_flag=0;
            if(visualize==1)
            plot(i,labels(i),'b.');
            hold on
            end
        
        
        %% one period ends
        elseif(edge_up(i)==2)
            if(solve_flag==1)
                i2=i;
                while(filter_result(i2)==1&&i2<length(labels)&& i2-i<=4)
                 correct_f(i2)=1;
                 i2=i2+1;
                end
            end
            solve_flag=0;
            miss_flag=0;
        
      
        %% during the process are not saved from FoG
        elseif(miss_flag==1 && labels(i)==2)
            
             if(visualize==1)
            plot(i,labels(i),'r.');
            hold on
             end
        
              
        elseif(labels(i)==1||labels(i)==0)
            if(visualize==1)
            plot(i,labels(i),'g.');
            hold on
            end
        end
            
    end
    
    
    for i=1:length(filter_result)
        if(filter_result(i)==1&&(labels(i)>=1))
        n_f = n_f+1;
        end    
    end
    
     for i=1:length(correct_f)
        if(correct_f(i)==1)
        correct_fn = correct_fn+1;
        end    
     end
    
         
     for i=1:length(t_FoG)
        if(t_FoG(i)==1)
        t_FoGn = t_FoGn+1;
        end    
    end
    
    for i=1:length(labels)
        if(labels(i)>=1)
            if(filter_result(i)==1 && labels(i)==2)
                FoGs=FoGs+1;
            end
            
            if(filter_result(i)==1 && labels(i)==1)
                %f_FoG=f_FoG+1;
                noFoGs=noFoGs+1;
            end
            
            if(filter_result(i)==0 && labels(i)==1)
                t_noFoG=t_noFoG+1;
                noFoGs=noFoGs+1;
            end
            
            if(filter_result(i)==0 && labels(i)==2)
                FoGs=FoGs+1;
            end
            
        end
    end
    
    
    recall = t_FoGn/FoGs;
    correctness = correct_fn/n_f;
    specifity = (t_noFoG)/(noFoGs);
    hold off
    
end