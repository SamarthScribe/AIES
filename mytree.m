function [ rmse] = mytree(a)



rng default;

T = readtable('sample_8_aug.xlsx');

X = table2array(T(:, 2:7));
Y = table2array(T(:, a));

c = cvpartition(length(Y),"Holdout",0.20);
trainingIdx = training(c); 
XTrain = X(trainingIdx,:);
YTrain = Y(trainingIdx,:);
testIdx = test(c); 
XTest = X(testIdx,:);
YTest = Y(testIdx,:);

mdl=fitrtree(XTrain,YTrain);
ypred=predict(mdl,XTest);

rsq=1 - sum((YTest - ypred).^2) / sum((YTest - mean(YTest)).^2);
rmse = sqrt(mean((YTest - ypred).^2));
abserror=abs(ypred-YTest);
bar([YTest,ypred,abserror])
legend('Predicted','Actual','Error')