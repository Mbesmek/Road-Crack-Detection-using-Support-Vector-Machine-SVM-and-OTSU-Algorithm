function [x_Test,x_Train,y_Test,y_Train] = dataSplit(X,Y,testRatio)

[w h,n]=size(X);
testRatio=ceil(n*testRatio);
randNum=randperm(n);

x_Test=X(:,:,randNum(1:testRatio));
x_Train=X(:,:,randNum(testRatio+1:end));

y_Test=Y(randNum(1:testRatio));
y_Train=Y(randNum(testRatio+1:end));

end
