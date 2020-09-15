function display_Errors(test0, test1, digits)
% function display_Error(test0, test1, digits) displays the errors
% 
% Displays the number of errors and the error rate of each type
% 
% Inputs:
%       test0 = m0 x 1 boolean vector with all the errors of the first kind
%       test1 = m1 x 1 boolean vector with all the errors of the second
%       kind
%       digits = vector with the class labels
% 
error0 = sum(test0);
error1 = sum(test1);
total_samples = length(test0) + length(test1);
%% Display the number of errors and the error rate
disp(['Errors T(x) = ',num2str(digits(2)),...
    ', theta = ',num2str(digits(1)),': ', num2str(error0), ' errors'])
disp(['Errors T(x) = ',num2str(digits(1)),...
    ', theta = ',num2str(digits(2)),': ', num2str(error1), ' errors'])
disp(['Errors T(x) = ',num2str(digits(2)),...
    ', theta = ',num2str(digits(1)),': ', num2str(error0/length(test0)*100),'%'])
disp(['Errors T(x) = ',num2str(digits(1)),...
    ', theta = ',num2str(digits(2)),': ', num2str(error1/length(test1)*100),'%'])
disp(['Total errors: ', num2str(((error0 + error1)/(total_samples))*100),'%'])