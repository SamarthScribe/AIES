rng default
clc;
clear;
T = readtable('sample_8_aug.xlsx');
x = table2array(T(:, 2:7));
% Create arrays to store R-squared values and test errors for each model
rSquaredValues = zeros(1, 5); % Assuming you have 5 target variables (columns 8 to 12)
testErrors = zeros(1, 5);
rmse=zeros(1, 5);
titles = {'Poly1', 'Poly2', 'Poly3', 'Am', 'Mono'};
for i = 8:12 % Loop through columns 8 to 12 as target variables
    y = table2array(T(:, i));

    % Split the data into training and testing sets (80% train, 20% test)
    cvp = cvpartition(size(x, 1), 'Holdout', 0.2);
    xTrain = x(cvp.training, :);
    yTrain = y(cvp.training, :);
    xTest = x(cvp.test, :);
    yTest = y(cvp.test, :);

    % Train the SVM regression model on the training data
    Mdl = fitrsvm(xTrain, yTrain);

    % Predict on the test data
    yPred = predict(Mdl, xTest);

    % Calculate the R-squared value
    rSquared = 1 - sum((yTest - yPred).^2) / sum((yTest - mean(yTest)).^2);
    rSquaredValues(i-7) = rSquared;

    % Calculate the test error (Mean Squared Error)
    testError = loss(Mdl, xTest, yTest);
    testErrors(i-7) = testError;
    r=sqrt(mean((yTest - yPred).^2));
    rmse(i-7) = r

    % Create a bar plot of predicted vs. actual values with absolute error
    figure;
    bar([yTest, yPred, abs(yTest - yPred)]);
    xlabel('Data Point');
    ylabel(['Target Variable ', num2str(i)]);
    title(titles{i-7});
    legend('Actual', 'Predicted', 'Absolute Error');

    % Display the R-squared value and test error for the current model
    disp(['R-squared for Target Variable ', num2str(i), ': ', num2str(rSquared)]);
    disp(['Test Error (Mean Squared Error) for Target Variable ', titles{i-7}, ': ', num2str(testError)]);
end

% Display the R-squared values and test errors for each target variable
disp('R-squared Values for Each Target Variable:');
disp(rSquaredValues);
disp('Test Errors (Mean Squared Error) for Each Target Variable:');
disp(testErrors);
disp('rsme')
disp(rmse)

% Repeat SVR model development using cross-validation (5-fold)
for i = 8:12
    y = table2array(T(:, i));

    % Train the SVM regression model with cross-validation
    Mdl = fitrsvm(x, y, 'Standardize', true, 'KFold', 10);

    % Calculate the cross-validation loss
    crossValLoss(i-7) = kfoldLoss(Mdl);

%     % Display the cross-validation loss for the current model
%     disp(['Cross-Validation Loss for Target Variable ', titles{i-7}, ': ', num2str(crossValLoss)]);
end
disp('the k fold losses are:')
disp(crossValLoss)