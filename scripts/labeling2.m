%% labeling
function labels = labeling2(data)
        
    gtframe = data;  % 0=no experiment, 1=no freeze, 2=freeze
    
    pre = find(gtframe==2);           % find FoG position

    if(isempty(pre))
        labels = gtframe;
    
    else
    pre2=[];
    for n=2:length(pre)             % for each FoG period
     if(pre(n)-1==pre(n-1))             
        pre2(n)=0;
     else
        pre2(n)=1;                    % The first one in each period  
     end
    end
    
    pre2(1)=1;
    pre3 = pre(pre2==1);                
    pre3 = cat(1,pre3-1,pre3-2);
    
     % figure(8)
    %   subplot(2,1,1)
     %  plot(1:1:length(gtframe),gtframe);

       for h=1:2
    for n=1:length(pre3)
        gtframe(pre3(h,n)) = 2;
    end
       end
    
    
    %  subplot(2,1,2)
    %   plot(1:1:length(gtframe),gtframe);
   % 
    labels = gtframe;       % extract labels
    end
    
end
 