function [Correctness,Recall,Specifity,F1Score] = lda_vali(data,Thresholds,Features,result_features,labels,filter,sensors,Classifier,mask)


training_X =  zeros(1,length(result_features(1).sumAll));
%% Put mask-selected features together
for i=1:length(Features)
    switch Features(i)
        % fast interval
        case 0    
            
            for sensor=1:sensors
                cl = size(training_X,1);
                if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).shift;    
                end
            end
        % depth    
        case 1    
            
            for sensor=1:sensors
                cl = size(training_X,1);
                if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).depth;    
                end
             end 
            
        % counts    
        case 2             
             
            for sensor=1:sensors
                cl = size(training_X,1);
                 if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).counts;    
                 end
            end
            
        %sample entropy    
        case 3             
            
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).entropy;    
             end    
            end
            
        % max correlation    
        case 4             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).Corr;    
             end    
            end
            
        % corr interval    
        case 5
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).shift2;    
             end    
            end
            
        % loco    
        case 6
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).sumLoco;    
             end    
            end
            
        % dominant frequency    
        case 7             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).I;    
             end    
            end
        % freezeIndex    
        case 8             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).freezeIndex;    
             end    
            end    
            
        % freeze+loco    
        case 9             
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).sumAll;    
             end    
            end
          
        % smoothness    
        case 10    
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).smooth;    
             end    
            end
            
        % cwt mean    
        case 11    
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).Cwt;    
             end    
            end
            
        % portion    
        case 12   
            for sensor=1:sensors
             cl = size(training_X,1);
             if(mask(i,sensor)==1)
                training_X(cl+1,:) = result_features(sensor).portion;    
             end    
            end  
    end
    
end

training_X = training_X(2:end,:);


%% Grid search on lenf(how long before a FoG can be labeled as FoG) 
%% and filterl(how long does one detection last)
for filterl=1:1
for lenf=1:1
    
    Labels = labeling2(labels,lenf);
    Labels(1)=0;
    %% Filtering out experiment data for validation purpose 
    
    % filter out experiments data
    filter_0 = (Labels~=0);
    figure(20);
    subplot(3,1,1)
    plot(Labels);
    title('all label');
    
    % filter out experiments data
    Index1 = find(filter_0==1);
    label_exp = Labels(Index1);
    Indexes_vali = 1:length(Labels);
    Indexes_vali = Indexes_vali(Index1);
    subplot(3,1,2)
    plot(label_exp);
    title('label in experiment for validation');
    
    %% filter out data within pre filter for LDA training purpose
    for i=1:length(Labels)
        if(filter(i)==0)    
            if(Labels(i)==2)
                Labels(i)=0;
            end
            
            if(Labels(i)==1)
                Labels(i)=0;
            end 
        end
    end
    % filter out experiments data and data cleaning
    Index2 = find(Labels>=1);
    Indexes_lda = 1:length(Labels);
    Indexes_lda = Indexes_lda(Index2);

    %% Filtering out lda data
    training_Y = Labels-1;
    training_x = training_X(:,Index2);
    training_y = training_Y(Index2);
    
    subplot(3,1,3)
    plot(training_y);
    title('label after threshold filter');

    %% k fold cross-validation
    k=5;
    final_all = [];
    label_all = [];
    
    for counter=1:k

        %% Split training set and test set
        lens = floor(length(training_y)/k);
        test_mask = zeros(1,length(training_y));
        test_mask((counter-1)*lens+1:counter*lens)=1;
        training_data = training_x(:,~test_mask);
        training_label = training_y(:,~test_mask);
        test_data = training_x(:,~~test_mask);
        test_label = training_y(:,~~test_mask);
   

        %% LDA Filtering
        figure(5)
        r=1;
        [Z,W] = LDA(training_data,training_label',r);


        %% Classification with decision tree(depth 1)

        index1 = find(training_label==1);
        class1 = Z(index1);
        index2 = find(training_label==0);
        class2 = Z(index2);


        c1m = mean(class1);
        c2m = mean(class2);
        FoGn = numel(class1);
        noFoGn = numel(class2);

        addpath('classifiers/');
        switch Classifier
            case 1
                [gini,TG] = classifier(c1m,c2m,Z,training_label,FoGn,noFoGn);
                tree=0;

            case 2
                [gini,TG] = classifier3(c1m,c2m,Z,training_label,FoGn,noFoGn);
                tree=0;
            case 3
                [gini,TG] = classifier3(filterl,c1m,c2m,Z,training_label,FoGn,noFoGn);
                tree=0;
            case 4
                [tree] = classifier4(c1m,c2m,Z,training_label,FoGn,noFoGn);    
                gini=0;
                TG=0;
        end


        %% Decision Tree
        if(Classifier<4)
        [DT_score,DT_index]=max(gini(:,2));
        DT_threshold=gini(DT_index,1);

        %% plot training result
        %subplot(4,1,2)
        % plot lda separating result
        %{
        figure()

        plot(index1,Z(index1),'ro');
        hold on

        plot(index2,Z(index2),'bx');
        hold on

        plot(c1m*ones(length(Z)),'r');
        hold on
        plot(c2m*ones(length(Z)),'b');
        hold on
        plot(DT_threshold*ones(length(Z)),'y');
        hold on

        xlabel('time [ms]');
        ylabel('feature');


        subplot(4,1,3)
        if(TG==0)
            plot(Z<DT_threshold);
        else
             plot(Z>DT_threshold);
        end
        else
            DT_threshold=0;
        end
        %}
        
        %% Plot original test data with test label
        lens2 = floor(length(data)/k);
        figs = 4;
        subplot(figs,1,1)
        td = data((counter-1)*lens2+1:lens2*counter,3);
        plot(td);
        title('original test data with label');

        Lb = data((counter-1)*lens2+1:lens2*counter,11); 
        pcol = {[1 1 1],[0 .75 0],'r'};
        % Plot the patches: find the discontinuities in the labels
        f = find(Lb(2:end)-Lb(1:end-1));
        % add a discontinuity at the start and end
        f=[0; f; size(Lb,1)];
        % iterate the discontinuities
        for i2=1:size(f,1)-1
            x1 = (f(i2));           % Time of start in ms 
            x2 = (f(i2+1));          % Time of end in ms
            type = Lb(f(i2)+1);
            y1 = min(td);
            y2 = max(td);
            patch([x1,x2,x2,x1],[y1 y1 y2 y2],pcol{1+type});
            alpha(.5);
        end

      %% Plot test label 
        subplot(figs,1,2)
        plot(1:length(test_label),test_label);
        title('test label')


       %% Get test data result
        new_result = test_data'*W;
        filter_result = zeros(1,length(new_result));

        if(TG==0)
        for i=1:length(new_result)
            if(new_result(i)<=DT_threshold && i+filterl<length(new_result))
               for(l=0:filterl)
               filter_result(i+l)=1;
               end

            elseif(new_result(i)<DT_threshold)
                %filter_result(i)=0;
            end  
        end

        else
        for i=1:length(new_result)
            if(new_result(i)>=DT_threshold && i+filterl<length(new_result))
               for(l=0:filterl)
               filter_result(i+l)=1;
               end

            elseif(new_result(i)<DT_threshold)
                %filter_result(i)=0;
            end 
        end
        end

        %% plot test lda result
                
        index1 = find(test_label==1);

        index2 = find(test_label==0);

        subplot(figs,1,3)

        plot(index1,new_result(index1),'ro');
        hold on

        plot(index2,new_result(index2),'bx');
        hold on

        plot(DT_threshold*ones(length(new_result)),'y');
        hold on
        hold off
        xlabel('time [ms]');
        ylabel('feature');
        title('lda result')
        
        %%

        %% Second filter
    %{
        cl=0;
        post_filter = ones(1,length(new_result));

        for fea = 1:length(Features)
            for sensor=1:sensors
                if(mask(fea,sensor)==1)
                    cl=cl+1;
                    if(Features(fea)==0 && sensor==2)
                       % post_filter = post_filter&(test_data(cl,:)<result_mean(sensor).shift);
                    end
                    if(Features(fea)==6&& sensor<=1)
                      %  post_filter = post_filter&(test_data(cl,:)>result_mean(sensor).sumLoco);
                    end
                    if(Features(fea)==8&& sensor<=1)
                     %   post_filter = post_filter&(test_data(cl,:)>result_mean(sensor).freezeIndex);
                    end

                end
            end
        end


        filter_result = filter_result&post_filter;
%}        
        
        figure(5)
        subplot(figs,1,4)
        plot(filter_result)
        title('filter result with post filter')

        [recall(counter),correctness(counter),specifity(counter)] = calculate_TF(filter_result,test_label+1,0);
        f1score(counter) = 2*(recall(counter)*correctness(counter))/(correctness(counter)+recall(counter));
        final_all =[final_all,filter_result] ;
        label_all = [label_all,test_label];

        end
    end
    figure(12)

    subplot(2,1,1)
    plot(label_exp);
    title('label')
    
    subplot(2,1,2)
    Final_all = zeros(1,length(label_exp));
    
    counter=1;
    for i=1:length(Final_all )
        if(counter<length(final_all))
            if( Indexes_vali(i)~=Indexes_lda(counter))
                Final_all(i) = 0;
            else
                Final_all(i) = final_all(counter);
                counter=counter+1;
            end
        end
        
    end
    plot(Final_all)
    title('result of classifier')
    
    [Recall(filterl,lenf),Correctness(filterl,lenf),Specifity] = calculate_TF(Final_all,label_exp,0);
    F1Score(filterl,lenf) = 2*(Recall(filterl,lenf)*Correctness(filterl,lenf))/(Recall(filterl,lenf)+Correctness(filterl,lenf));
 


end
end


end