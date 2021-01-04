clc; close all; clear all;
n=10; %Number of Photo
ratio=input('Test Ratio between 0-1:' ); 
pPhoto=addPositivePhoto(n);
nPhoto=addNegativePhoto(n);
[w h]=size(pPhoto{1,1});
X=zeros(w,h,n);
for i=1:n/2
    X(:,:,i)=pPhoto{1,i};
    Y(i,1)=1;
end
i=i+1;
for j=1:n/2
    X(:,:,i)=nPhoto{1,j};
    Y(i,1)=0;
    i=i+1;
end
% xglcm=glcm(X);
[x_train,x_test,y_train,y_test] = dataSplit(X,Y,ratio);

%%
[w, h, number] = size(x_train);
x_trainf = reshape(x_train,[number,w*h]);

[w, h, number] = size(x_test);
x_testf = reshape(x_test,[number,w*h]);
 svm1 =fitcecoc(x_trainf,y_train);
 %%
 [predicted_labels,score,cost] = predict(svm1,x_testf);

[accuracyRaw, precisionRaw, recallRaw, f1_scoreRaw, TPRRaw, FPRRaw, c_matrixRaw]=Accuracies(y_test,predicted_labels)
metricWithoutGlcm=table([accuracyRaw, precisionRaw, recallRaw, f1_scoreRaw, TPRRaw, FPRRaw]);

[X_roc,Y_roc] = perfcurve(y_test,predicted_labels,1);
figure;
plot(X_roc,Y_roc)
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC SVM Without GLCM')
%%

xGlcm_train=glcm(x_train)';
xGlcm_test=glcm(x_test)';
% y_test=y_test';
% y_train=y_train';
% 
% [w, h, number] = size(xGlcm_train);
% xGlcm_train = reshape(xGlcm_train,[number,w*h]);
% 
% [w, h, number] = size(xGlcm_test);
% xGlcm_test = reshape(xGlcm_test,[number,w*h]);

 svm1 =fitcecoc(xGlcm_train,y_train);
 [predicted_labels,score,cost] = predict(svm1,xGlcm_test);

[accuracy, precision, recall, f1_score, TPR, FPR, c_matrix]=Accuracies(y_test,predicted_labels)
metricWithGlcm=table([accuracy, precision, recall, f1_score, TPR, FPR]);

%%
[X_roc,Y_roc] = perfcurve(y_test,predicted_labels,1);
figure;
plot(X_roc,Y_roc)
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC SVM With GLCM')
%% Kernel


parC=[0.5,1,10,100,500,1000];


for i=1:6
m=fitcsvm(xGlcm_train,y_train,'Standardize',true,'KernelFunction','linear',...
                'KernelScale','auto','BoxConstraint', parC(1,i));
[predicted_labels_kernel,score_kernel,cost_kernel] = predict(m,xGlcm_test);
[accuracy_kernelLinear, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel, c_matrix_kernel]=Accuracies(y_test,predicted_labels_kernel)
metricWithGlcmLinearKernel(1,i)=table([accuracy_kernelLinear, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel]);
end

for i=1:6
m=fitcsvm(xGlcm_train,y_train,'Standardize',true,'KernelFunction','polynomial',...
                'KernelScale','auto','BoxConstraint', parC(1,i));
[predicted_labels_kernel,score_kernel,cost_kernel] = predict(m,xGlcm_test);
[accuracy_kernelPoly, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel, c_matrix_kernel]=Accuracies(y_test,predicted_labels_kernel)
metricWithGlcmPolyKernel(1,i)=table([accuracy_kernelPoly, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel]);
end

for i=1:6
m=fitcsvm(xGlcm_train,y_train,'Standardize',true,'KernelFunction','rbf',...
                'KernelScale','auto','BoxConstraint', parC(1,i));
[predicted_labels_kernel,score_kernel,cost_kernel] = predict(m,xGlcm_test);
[accuracy_kernelRBF, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel, c_matrix_kernel]=Accuracies(y_test,predicted_labels_kernel)
metricWithGlcmRBFKernel(1,i)=table([accuracy_kernelRBF, precision_kernel, recall_kernel, f1_score_kernel, TPR_kernel, FPR_kernel]);
end


