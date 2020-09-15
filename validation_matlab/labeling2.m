%% labeling
function labels = labeling2(data,lenf)
        
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
    pre4 =[1];
    for l=1:lenf
    pre4 = [pre4,pre3-l];
    end
    % pre3 = cat(1,pre3-1,pre3-2,pre3+1,pre3+2,pre3+3,pre3+4);
  
    % figure(8)
    %   subplot(2,1,1)
     %  plot(1:1:length(gtframe),gtframe);

    
  % for l = 1:length(gtframe)
   % if(gtframe(l)==2)
    %    gtframe(l)=1;
   %end
     %for h=1:lenf
    for n=1:length(pre4)        
        gtframe(pre4(n)) = 2;
    end
     %  end
       
       
    
    %  subplot(2,1,2)
    %   plot(1:1:length(gtframe),gtframe);
   % 
    labels = gtframe;       % extract labels
    end
    
end
 