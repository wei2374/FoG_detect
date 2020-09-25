function plot_filtered(data,labels,pre_filter2)
filtered_FoG = 0;
all_FoG=0;
all_noFoG=0;
filtered_noFoG=0;

filtered = zeros(1,length(labels));


for i=1:length(labels)
    if(labels(i)==2)
        all_FoG = all_FoG+1;
    end
    if(labels(i)==2 && pre_filter2(i)==0)
        filtered_FoG = filtered_FoG+1;
        filtered(i)=1;
    end
    if(labels(i)==1)
        all_noFoG=all_noFoG+1;
    end
    if(labels(i)==1 && pre_filter2(i)==0)
        filtered_noFoG = filtered_noFoG+1;
        filtered(i)=1;
    end
end
filtered_percentage = filtered_FoG/all_FoG
correct_percentage = filtered_noFoG/all_noFoG
FoG_p = all_FoG/(all_FoG+all_noFoG)

filtered_all =[];
labels_all = [];
for i=1:length(filtered)
    filtered_all =[filtered_all, filtered(i)*ones(1,32)];
end
for i=1:length(labels)
    labels_all =[labels_all, labels(i)*ones(1,32)];
end

figure(34)
plot(filtered_all);
pcol = {[1 1 1],[0 .75 0],'r'};
% Plot the patches: find the discontinuities in the labels
f = find(filtered_all(2:end)-filtered_all(1:end-1));
% add a discontinuity at the start and end
f=[0; f'; size(filtered_all,2)];
% Plot the patches: find the discontinuities in the labels
f2 = find(labels_all(2:end)-labels_all(1:end-1));
% add a discontinuity at the start and end
f2=[0; f2'; size(labels_all,2)];



% iterate the discontinuities
for i2=1:size(f,1)-1
    x1 = (f(i2));           % Time of start in ms 
    x2 = (f(i2+1));          % Time of end in ms
    type = filtered_all(f(i2)+1);
    y1 = -10000;
    y2 = 10000;
    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
    alpha(.5);
end

hold on

% iterate the discontinuities
for i2=1:size(f2,1)-1
    x1 = (f2(i2));           % Time of start in ms 
    x2 = (f2(i2+1));          % Time of end in ms
    type = labels_all(f2(i2)+1);
    y1 = -10000;
    y2 = 10000;
    patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
    alpha(.5);
end


hold on
plot(data(:,3));


end