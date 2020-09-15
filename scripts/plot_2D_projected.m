function plot_2D_projected(Z_sorted,y_sorted)
    figure(1)
    filter1 = find(y_sorted==1);
    filter2 = find(y_sorted==2);
    %filter3 = find(y_sorted==3);
    
    
    class1 = Z_sorted(filter1,:);
    class2 = Z_sorted(filter2,:);
    %class3 = Z_sorted(filter3,:);
    
    plot(class1(:,1),class1(:,2),'r.');
    hold on
    plot(class2(:,1),class2(:,2),'b.');
    hold on
    %plot(class3(:,1),class3(:,2),'g.');
    
    xlabel('1st component');
    ylabel('2nd component');
    
    
    
end