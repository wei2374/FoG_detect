function [gini,TG] = classifier2(c1m,c2m,Z,training_y,FoGn,noFoGn)
TG=0;
n=1;
weight = round (noFoGn/FoGn);
%weight=1;
FoGn =  weight*FoGn;

if(c1m>c2m)
    TG=1;
    diff = c1m-c2m;
    c2m = c2m-0.2*diff;
    thdt = c2m;
   
    while(thdt<c1m+0.2*diff)
        true_FoG=0;
        true_noFoG=0;
        for(i=1:length(Z))
            if(Z(i)>=thdt && training_y(i)==1)
                true_FoG=true_FoG+weight;
            elseif(Z(i)<thdt && training_y(i)==0)
                true_noFoG=true_noFoG+1;
            end    
        end
        
        gini(n,1) = thdt;
        gini(n,2) = (true_FoG/FoGn)^2+(true_noFoG/noFoGn)^2;

        thdt=thdt+0.1*diff;
        n=n+1;
    end
   
        
    elseif(c1m<c2m )
        TG=0;
        diff = c2m-c1m;
        thdt = c1m-0.2*diff;
      
       
        
        while(thdt<c2m+0.2*diff)
            true_FoG=0;
            true_noFoG=0;
            for(i=1:length(Z))
                if(Z(i)<=thdt && training_y(i)==1)
                    true_FoG=true_FoG+weight;
                elseif(Z(i)>thdt && training_y(i)==0)
                    true_noFoG=true_noFoG+1;
                end         
            end
            gini(n,1) = thdt;
            gini(n,2) = 1*(true_FoG/FoGn)^2+1*(true_noFoG/noFoGn)^2;
        thdt=thdt+0.1*diff;
        n=n+1;
        end
     
    end
   
    
        

end