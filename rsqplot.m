clc;
clear;

% Define the data
datasets = {'Poly1', 'Poly2', 'Poly3', 'Am', 'Mono'};

rsqtree = [0.1219, -0.0909, 0.1143, -0.4595, -1.1233];
rsqlinear = [0.5041, 0.4388, 0.4188, 0.4459, 0.3900];
rsqsvm = [-0.0509, 0.2677, 0.5187, 0.5869, 0.3788];

% Create a figure for the grouped bar plot
figure;

% Create grouped bar plot for R-squared values
bar([rsqtree; rsqlinear; rsqsvm]');
ylabel('R-squared (rsq)');
title('Model Comparison (R-squared)');
legend('Tree Model', 'Linear Model', 'SVM Model');
xticklabels(datasets);
