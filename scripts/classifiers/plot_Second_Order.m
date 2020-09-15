function plot_Second_Order(mu0, mu1, C0, C1, Z0, Z1, digits, plot_title)
% function plot_Second_Order(w, w0, Z0, Z1, digits) plots the 3D projected
% data points in Z0 and Z1 with the serparating second-order surface
%
% Inputs:
%
%       Z0 = m0 x 3 matrix of data point of class "0"
%       Z1 = m1 x 3 matrix of data point of class "1"
%       digits = 1 x 2 vector of class labels

%% Check if the variable plot_title exists
if ~exist('plot_title','var')
    plot_title = '';
end

%% First define the function of the separating surface
if size(Z0,2) == 3 && size(Z1,2) == 3
    inv_C0 = inv(C0);
    inv_C1 = inv(C1);
    fun = @(x, y ,z) (0.5*log(det(C0)/det(C1)) ...
        + 0.5*(...
        (x - mu0(1)).*(...
        (x - mu0(1))*inv_C0(1,1) + (y - mu0(2))*inv_C0(2,1) + (z - mu0(3))*inv_C0(3,1))...
        +(y - mu0(2)).*(...
        (x - mu0(1))*inv_C0(1,2) + (y - mu0(2))*inv_C0(2,2) + (z - mu0(3))*inv_C0(3,2))...
        +(z - mu0(3)).*(...
        (x - mu0(1))*inv_C0(1,3) + (y - mu0(2))*inv_C0(2,3) + (z - mu0(3))*inv_C0(3,3)))...
        - 0.5*(...
        (x - mu1(1)).*(...
        (x - mu1(1))*inv_C1(1,1) + (y - mu1(2))*inv_C1(2,1) + (z - mu1(3))*inv_C1(3,1))...
        +(y - mu1(2)).*(...
        (x - mu1(1))*inv_C1(1,2) + (y - mu1(2))*inv_C1(2,2) + (z - mu1(3))*inv_C1(3,2))...
        +(z - mu1(3)).*(...
        (x - mu1(1))*inv_C1(1,3) + (y - mu1(2))*inv_C1(2,3) + (z - mu1(3))*inv_C1(3,3))));
    %% Calculate the incorrect predictions
    test0 = fun(Z0(:,1), Z0(:,2), Z0(:,3)) > 0;
    test1 = fun(Z1(:,1), Z1(:,2), Z1(:,3)) < 0;
    
    %% Plot the data points and the separating surface
    plot_3D_Surface(Z0, Z1, fun, test0, test1, digits, plot_title)
    
else
    fun = @(x) (log_R(mu0, mu1, C0, C1, x));
    %% Calculate the incorrect predictions
    test0 = fun(Z0) > 0;
    test1 = fun(Z1) < 0;
    
end

%% Display the error rates
if strcmp(plot_title, '')
    disp('Second-Order Separating Surface');
else
    disp(['Second-Order Separating Surface (', plot_title, ')']);
end
display_Errors(test0, test1, digits);

