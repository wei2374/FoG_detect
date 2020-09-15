classdef random_forest
    % random_forest is a class to define a random forest of classification
    % tree which are built using recursive binary splitting
    properties
        %% A random_forest object has the following properties:
        %   trees : cell to store classification trees
        %   X_total : matrix with training data
        %   X_test : matrix with test data
        %   estimates : matrix of the class estimation of each tree
        %   num_trees : number of trees in the random forest
        trees = {};
        X_total = [];
        X_test = [];
        estimations = [];
        num_trees = 0;
    end
    methods
        function rf = random_forest(Data, Data_Test, num_trees)
            %% rf = random_forest(Data, Data_Test, num_trees)
            % Method to create a random_forest object
            % Input:
            %       Data : matrix of the training data
            %       Data_Test : matrix of the test data
            %       num_trees : number of trees in the random forest
            %
            % Output:
            %       tree : random_forest object
            
            % Initialise the random forest rf
            rf.X_total = Data;
            rf.X_test = Data_Test;
            rf.num_trees = num_trees;
            rf.trees = cell(rf.num_trees,1);
            
        end
        
        function rf = build_forest(rf)
            %% rf = build_forest(rf)
            % Method to build a binary decision tree
            % Input:
            %       rf : input random forest object
            %
            % Output:
            %       tree : built random forest
            
            fprintf('Building random forest...\n')
            for i = 1:rf.num_trees
                % Build a classification tree and store it in the cell
                % rf.trees
                disp(['Tree: ',num2str(i),'/',num2str(rf.num_trees)])
                binary_tree = decision_tree(rf.get_bootstrap);
                % Note, we set the boolean random_Feature to true to build
                % the classification trees in the random forest
                binary_tree.random_feature = true;
                rf.trees{i} = binary_tree.build_tree;
            end
            disp('Finished building random forest.')
            
        end
        
        function Z_out = get_bootstrap(rf)
            %% Z_out = get_bootstrap(rf)
            % Method to get a bootstrap copy of the training data, i.e.,
            % resample Z_train with replacement
            % Input:
            %       rf : input random forest object
            %
            % Output:
            %       Z_out : matrix of resampled training data
            
            M = size(rf.X_total,1);
            % Define a random vector of indices
            index = randi(M, [M,1]);
            Z_out = rf.X_total(index,:);
        end
        
        function [error_Rate, error_Rates, estimations] =...
                aggregate_forest(rf, Z_Data, bool_Disp)
            %% [error_Rate, error_Rates, estimations] =...
            %    aggregate_forest(rf, Z_Data, bool_Disp)
            % Method to get a aggregate the estimations of the individual
            % classification trees to get an error rate of the random
            % forest
            % Input:
            %       rf : input random forest object
            %       Z_data : matrix of data samples to get estimations of
            %       bool_Disp : boolean to set whether the error rates
            %       should be displayed or not
            %
            % Output:
            %       error_rate : error rate of the random forest
            %       error_rates : error rate of each classification tree
            %       estimations : matrix of size M x num_trees with the
            %       estimation of each tree in each row
            
            if ~exist('bool_Disp','var')
                bool_Disp = false;
            end
            
            if bool_Disp
                fprintf('\nError Rates: \n');
            end
            
            % Get the error rate and estimation of each classification in
            % the random forest
            estimations = zeros(size(Z_Data,1),rf.num_trees);
            error_Rates = zeros(rf.num_trees,1);
            for j = 1:rf.num_trees
                [error_Rates(j), estimations(:,j)] = ...
                    rf.trees{j}.estimate_test(Z_Data,rf.trees{j}.tree_depth);
                % Display the error rate if wanted
                if bool_Disp
                    txt =sprintf('Tree: %d -> Test Error: %.2f', j, error_Rates(j)*100);
                    disp([txt, '%'])
                end
            end
            
            % Calculate the error rate of the aggregated estimations, i.e.,
            % get the error rate of the random forest
            correct = mode(estimations,2) == Z_Data(:,end);
            error_Rate = sum(~correct)/length(correct);
            % Display the error rate if wanted
            if bool_Disp
                txt =sprintf('Forest Test Error: %.2f', error_Rate*100);
                disp([txt, '%'])
            end
        end
        
        function plot_errors(rf, bool_Disp, bool_RefDT)
            %% plot_errors(rf, bool_Disp, bool_RefDT)
            % Method to plot the error of the random forest against the
            % number of trees in the random forest
            % Input:
            %       rf : input random forest object
            %       bool_Disp : boolean to set whether the error rates are
            %       displayed or not
            %       bool_RefDT : boolean to set whether a reference
            %       decision tree should be built.
            %
            
            if ~exist('bool_Disp','var')
                bool_Disp = false;
            end
            if ~exist('bool_RefDT','var')
                bool_RefDT = true;
            end
            
            if bool_RefDT
                % First build a classification tree to full depth for reference
                disp('Build a tree for reference.')
                binary_tree = decision_tree(rf.X_total);
                binary_tree = binary_tree.build_tree;
                error_CT_Test = binary_tree.estimate_test(rf.X_test);
            end
            
            % Get the training estimations and test estimations
            if bool_Disp
                fprintf('\nTraining Set:');
            end
            [~, ~, rf_Est_Train] = rf.aggregate_forest(rf.X_total,...
                bool_Disp);
            if bool_Disp
                fprintf('\nTest Set:');
            end
            [~, ~, rf_Est_Test] = rf.aggregate_forest(rf.X_test,...
                bool_Disp);
            
            % Calculate the error rate with different number of
            % classification trees
            rf_Error_Train = zeros(1,rf.num_trees);
            rf_Error_Test = zeros(1,rf.num_trees);
            for i = 1:rf.num_trees
                correct = mode(rf_Est_Train(:,1:i),2) == rf.X_total(:,end);
                rf_Error_Train(i) = sum(~correct)/length(correct);
                correct = mode(rf_Est_Test(:,1:i),2) == rf.X_test(:,end);
                rf_Error_Test(i) = sum(~correct)/length(correct);
            end
            
            % Plot the test and training error rates with the fully grown
            % classification tree test error rate as a reference
            figure;
            plot(1:rf.num_trees,rf_Error_Test);
            hold on;
            plot(1:rf.num_trees,rf_Error_Train);
            if bool_RefDT
                hline = refline(0,error_CT_Test);
                hline.Color = [0.4660    0.6740    0.1880];
                legend('Random Forest Test',...
                    'Random Forest Train',...
                    'Class. Tree Test');
            else
                legend('Random Forest Test',...
                    'Random Forest Train');
            end
            
            xlabel('Number of Trees')
            ylabel('Error Rate')
            grid on;
            title('Error Rate vs. Number of Trees in the Random Forest')
            
            
        end
        
        function plot_trees(rf, bool_PrintLabels, num_Plots)
            %% plot_trees(rf, bool_PrintLabels, num_Plots)
            % Method to plot num_Plots of the classification trees in the
            % random forest
            % Input:
            %       rf : input random forest object
            %       bool_PrintLabels : boolean to set whether the node
            %       labels should be printed
            %       num_Plots : set the number of classification trees from
            %       the random forest should be plotted
            %
            
            if ~exist('bool_PrintLabels','var')
                bool_PrintLabels = false;
            end
            
            if ~exist('num_Plots', 'var')
                num_Plots = rf.num_trees;
            end
            
            % Use the decision tree object's plot_tree method to plot the
            % trees
            for j = 1:num_Plots
                rf.trees{j}.plot_tree(bool_PrintLabels);
            end
        end
        
        function plot_3D(rf, bool_Mode)
            %% plot_3D(rf)
            % Method to plot the 3D test data with a colour scheme to
            % indicate how certain the random forest is with each decision
            % Input:
            %       rf : input random forest object
            %       bool_Mode : boolean to indicate whether the mean
            %       class or the mode class should be plotted
            %
            
            if ~exist('bool_Mode', 'var')
                bool_Mode = true;
            end
            
            if size(rf.X_test, 2) == 4
                % Get the estimations of the random forest using the test
                % data
                [~,~, estimation] = rf.aggregate_forest(rf.X_test);
                labels = unique(rf.X_test(:,end)).';
                num_Classes = length(labels);
                % If there are two classes we can relabel the classes to 0
                % and 1, and average the estimations to get a colour map of
                % the random forest's estimates
                if num_Classes == 2 && bool_Mode
                    for i = 1:length(labels)
                        ind = find(estimation == labels(i));
                        if i == 1
                            estimation(ind) = 0;
                        else
                            estimation(ind) = 1;
                        end
                    end
                    
                    figure;
                    scatter3(rf.X_test(:,1),rf.X_test(:,2), rf.X_test(:,3),...
                        50,mean(estimation,2));
                    colormap jet
                    colorbar
                else
                    figure;
                    scatter3(rf.X_test(:,1),rf.X_test(:,2), rf.X_test(:,3),...
                        50,mode(estimation,2));
                    colormap jet
                    colorbar
                end
                title(['Test Data Estimates using a Random Forest with ',...
                    num2str(rf.num_trees),' Trees'])
                xlabel('z_1')
                ylabel('z_2')
                zlabel('z_3')
                view([-45,20])
                rotate3d on;
                grid on;
            end
        end
    end
end
