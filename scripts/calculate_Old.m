function [precision,recall] = calculate_Old(result,labels)
trueFoGs = zeros(size(result));
labelFoGs = zeros(size(result));
filterFoGs = zeros(size(result));

for n=1:length(result)
    if(result(n)==1)
        filterFoGs(n)=1;
    end
    if(labels(n)==2)
        labelFoGs(n)=1;
    end
    if(labels(n)==2&&result(n)==1)
        trueFoGs(n)=1;
    end
    
end
trueFoGn = sum(trueFoGs);
labelFoGn = sum(labelFoGs);
filterFoGn = sum(filterFoGs);

precision = trueFoGn/filterFoGn;
recall = trueFoGn/labelFoGn;


end