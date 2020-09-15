function [gini,TG] = classifier3(c1m,c2m,Z,training_y,FoGn,noFoGn,filterl)
TG=0;
n=1;
weight = round (noFoGn/FoGn);
FoGn =  weight*FoGn;


if(c1m>c2m)
    TG=1;
    diff = c1m-c2m;
    c2m = c2m-0.2*diff;
    thdt = c2m;
   
    while(thdt<c1m+0.2*diff)
        filter_result = zeros(1,length(training_y));
        true_FoG=0;
        true_noFoG=0;
        for(i=1:length(Z))
            if(Z(i)>=thdt&& i+filterl<length(Z))                
                for l=0:filterl
                    filter_result(i+l)=1;
                end
            elseif(Z(i)<thdt)
                %filter_result(i)=0;
            end    
        end
        labels = training_y+1;
        [recall,correctness,x] = calculate_TF(filter_result,labels,0);
        gini(n,1) = thdt;
        gini(n,2) = (recall*correctness)/(recall+correctness);

        thdt=thdt+0.1*diff;
        n=n+1;
    end
   
        
    elseif(c1m<c2m )
        TG=0;
        diff = c2m-c1m;
        thdt = c1m-0.2*diff;
      
       
        
        while(thdt<c2m+0.2*diff)
            filter_result = zeros(1,length(training_y));
            true_FoG=0;
            true_noFoG=0;
            for(i=1:length(Z))           
                if(Z(i)<=thdt&& i+filterl<length(Z))                
                    for l=0:filterl
                        filter_result(i+l)=1;
                    end
                elseif(Z(i)<thdt)
                %filter_result(i)=0;
                 end    
     
            end
            labels = training_y+1;
        [recall,correctness,x] = calculate_TF(filter_result,labels,0);
        gini(n,1) = thdt;
        gini(n,2) = (recall*correctness)/(recall+correctness);
        thdt=thdt+0.1*diff;
        n=n+1;
        end
     
    end
   
    
        

end