clc;
clear;
rng default;
T = readtable('sample_8_aug.xlsx');
X = table2array(T(:, 2:7));
Y = table2array(T(:, 8:12));

D = [X Y(:, 1)];
D = normalize(D);

a1 = isoutlier(X(:, 4), "mean");
% a2= filloutliers(X(:, 4),'nearest',"mean")
% Plot both the original data and outlier values
figure;
hold on;

% Plot original data
plot(X(:, 4), 'b'); % Blue line for original data
% plot(a2)
% Superimpose outliers on top
scatter( find(a1), X(a1, 4), 'r', 'filled'); % Red filled circles for outliers

xlabel(['Data Point']);
ylabel('Input of Precepitation');
title('outlier test by mean');
legend('Original Data', 'Outliers');
hold off;