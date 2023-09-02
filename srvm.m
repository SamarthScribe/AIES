rng default
clc;
clear all;
close all;
T = readtable('sample_8_aug.xlsx');
x = table2array(T(:, 2:7));

% Create an array to store test errors for each target variable
testErrors = zeros(1, 5); % Assuming you have 5 target variables (columns 8 to 12)

for i = 8:12 % Loop through columns 8 to 12 as target variables
    y = table2array(T(:, i));

    % Split the data into training and testing sets (80% train, 20% test)
    rng(42); % For reproducibility, you can change the seed (42) as desired
    cvp = cvpartition(size(x, 1), 'Holdout', 0.2);
    xTrain = x(cvp.training, :);
    yTrain = y(cvp.training, :);
    xTest = x(cvp.test, :);
    yTest = y(cvp.test, :);

    % Train the SVM regression model on the training data
    Mdl = fitrsvm(xTrain, yTrain);

    % Predict on the test data
    yPred = predict(Mdl, xTest);

    % Calculate the test error for the current target variable
    testError = loss(Mdl, xTest, yTest);
    
    % Store the test error in the array
    testErrors(i-7) = testError;

    % Plot the actual vs. predicted values
    figure;
    plot(yTest, 'b', 'DisplayName', 'Actual');
    hold on;
    plot(yPred, 'r', 'DisplayName', 'Predicted');
    xlabel('Data Point');
    ylabel(['Target Variable ', num2str(i)]);
    title(['Actual vs. Predicted Values for Target Variable ', num2str(i)]);
    legend('show');
end

% Display the test errors for each target variable
disp('Test Errors (Mean Squared Error) for Each Target Variable:');
disp(testErrors);
