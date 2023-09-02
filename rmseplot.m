clc;
clear;

% Define the data
datasets = {'Poly1', 'Poly2', 'Poly3', 'Am', 'Mono'};

rmsetree=[58.4929 116.2897 99.7997 169.2590 13.5943];
rmselinear=[76.4720 116.7245 129.9684 156.1558 11.0983];
rmsesvm=[63.9909 194.406 101.9746 9.2025 8.9685];

% Create a figure for the grouped bar plot
figure;

% Create grouped bar plot for R-squared values
bar([rmsetree; rmselinear; rmsesvm]');
ylabel('Root mean squared error (rmse)');
title('Model Comparison (R-squared)');
legend('Tree Model', 'Linear Model', 'SVM Model');
xticklabels(datasets);
