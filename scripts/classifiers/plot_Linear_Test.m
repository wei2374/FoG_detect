function plot_Linear_Test(w, w0, Z0, Z1, digits, plot_title)
% function plot_Linear_Test(w, w0, Z0, Z1, digits) plots the 3D projected
% data points in Z0 and Z1 with the serparating linear Hyperplane defined
% by w and w0
%
% Inputs:
%       w = 1 x 3 normal vector to the separating hyperplane
%       w0 = scalar tranlation factor
%       Z0 = m0 x 3 matrix of data point of class "0"
%       Z1 = m1 x 3 matrix of data point of class "1"
%       digits = 1 x 2 vector of class labels

%% Calculate the incorrect predictions
test0 = w*Z0.' - w0 > 0;
test1 = w*Z1.' - w0 <= 0;

%% Display the error rate
if ~exist('plot_title','var')
    disp('Linear Test')
else
    disp(['Linear Test (', plot_title, ')']);
end

display_Errors(test0, test1, digits);

%% Plot the data points and the separating hyperplane
if size(Z0,2) == 3 && size(Z1,2) == 3
    fun = @(x,y,z) (w(1)*x + w(2)*y + w(3)*z - w0);
    plot_3D_Surface(Z0, Z1, fun, test0, test1, digits, plot_title)
end

