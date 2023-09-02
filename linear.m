clc;
clear;
rng default;

T = readtable('sample_8_aug.xlsx');

X = table2array(T(:, 2:7));
Y = table2array(T(:, 8:12));

coefficients = zeros(5, 7);
rsquared = zeros(1, 5);
rmse=zeros(1,5);

figure;
titles = {'Poly1', 'Poly2', 'Poly3', 'Am', 'Mono'}
for i = 1:5
    c = cvpartition(length(Y(:, i)), 'Holdout', 0.2);
    trainingIdx = training(c);
    XTrain = X(trainingIdx, :);
    YTrain = Y(trainingIdx, i);
    XTest = X(~trainingIdx, :);
    YTest = Y(~trainingIdx, i);
    
    mdl = fitlm(XTrain, YTrain);
    
    coefficients(i, :) = mdl.Coefficients.Estimate';
    rsquared(i) = mdl.Rsquared.Ordinary;
    rmse(i)=mdl.RMSE
    YPred = predict(mdl, XTest);
    
    abs_error = abs(YPred - YTest);
    
    subplot(2, 3, i);
    bar([YPred, YTest, abs_error]);
    title(titles{i});
    legend('Predicted', 'Actual', 'Absolute Error');
end

disp('Model Coefficients:');
disp(coefficients);

disp('R-squared Values:');
disp(rsquared);

disp('rmse is')
disp(rmse)