function plot_3D_Surface(Z0, Z1, fun, test0, test1, digits, plot_title)
% function plot_3D_Surface(Z0, Z1, fun, test0, test1, digits, plot_title)
% 
% Inputs:
%       Z0 : matrix of data points from class "0"
%       Z1 : matrix of data points from class "1"
%       fun : function handle defining the hyperplane
%       test0 = m0 x 1 boolean vector with all the errors of the first kind
%       test1 = m1 x 1 boolean vector with all the errors of the second
%       kind
%       digits = vector with the class labels
%       plot_title = title for the plot
% 
%% Plot the data points in the 3D plane and the separating surface
figure;
hold on;
scatter3(Z0(~test0,1),Z0(~test0,2),Z0(~test0,3),'r');
scatter3(Z1(~test1,1),Z1(~test1,2),Z1(~test1,3),'b');
scatter3(Z0(test0,1),Z0(test0,2),Z0(test0,3),'^r','filled');
scatter3(Z1(test1,1),Z1(test1,2),Z1(test1,3),'^b','filled');
try 
    fimplicit3(fun,[-10,10],'EdgeColor','none','FaceAlpha',.5,'FaceColor','g')
catch
    disp('Warning: To be able to plot the separating surface please install MATLAB version R2016b or later. ')
end % try catch
ylabel('EV 2')
xlabel('EV 1')
zlabel('EV 3')
grid on
rotate3d on;
legend(['T(x) = ',num2str(digits(1)),', theta = ',num2str(digits(1))],...
    ['T(x) = ',num2str(digits(2)),', theta = ',num2str(digits(2))],...
    ['T(x) = ',num2str(digits(2)),', theta = ',num2str(digits(1))],...
    ['T(x) = ',num2str(digits(1)),', theta = ',num2str(digits(2))])
title(plot_title)