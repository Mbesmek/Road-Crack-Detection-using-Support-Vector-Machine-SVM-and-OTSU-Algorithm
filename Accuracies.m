function [accuracy, precision, recall, f1_score, TPR, FPR, c_matrix]=Accuracies(test_y, predict_y)

n_class = length(unique(test_y));
c_matrix = confusionmat(test_y, predict_y);
switch n_class
    case 2
    TP=c_matrix(1,1);
    FN=c_matrix(1,2);
    FP=c_matrix(2,1);
    TN=c_matrix(2,2);
           
    otherwise
        TP=zeros(1,n_class);
        FN=zeros(1,n_class);
        FP=zeros(1,n_class);
        TN=zeros(1,n_class);
        for i=1:n_class
            TP(i)=c_matrix(i,i);
            FN(i)=sum(c_matrix(i,:))-c_matrix(i,i);
            FP(i)=sum(c_matrix(:,i))-c_matrix(i,i);
            TN(i)=sum(c_matrix(:))-TP(i)-FP(i)-FN(i);
        end

end

accuracy = (TP+TN) / (TP+TN+FP+FN)*100;
precision = TP/(TP+FP);
recall = TP/(TP+FN);
f1_score = 2*(recall*precision)/(recall+precision);
TPR = TP/(TP+FN);
FPR = FP/(TN+FP);

