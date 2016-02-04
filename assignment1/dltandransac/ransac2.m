close all;

clc;
im = imread('image.jpg');

% imshow(im);
% [x, y] = ginput();

x = [1.914500e+03 1.690500e+03 1.474500e+03 1.270500e+03 1.070500e+03 8.825000e+02 1.926500e+03 1.706500e+03 1.494500e+03 1.290500e+03 1.098500e+03 9.145000e+02 1.934500e+03 1.722500e+03 1.514500e+03 1.318500e+03 1.130500e+03 9.465000e+02 1.898500e+03 1.670500e+03 1.450500e+03 1.242500e+03 1.046500e+03 8.505000e+02 1.850500e+03 1.610500e+03 1.374500e+03 1.154500e+03 9.385000e+02 7.345000e+02];
y = [5.145000e+02 5.185000e+02 5.305000e+02 5.305000e+02 5.345000e+02 5.385000e+02 7.425000e+02 7.425000e+02 7.425000e+02 7.465000e+02 7.425000e+02 7.425000e+02 9.625000e+02 9.585000e+02 9.465000e+02 9.425000e+02 9.385000e+02 9.345000e+02 1.082500e+03 1.066500e+03 1.058500e+03 1.050500e+03 1.038500e+03 1.030500e+03 1.222500e+03 1.206500e+03 1.190500e+03 1.178500e+03 1.166500e+03 1.154500e+03];

X = [0:3:15 0:3:15 0:3:15 0:3:15 0:3:15];
Y = [6*ones(6, 1)'  3*ones(6, 1)' zeros(18, 1)'];
Z = [zeros(18, 1)' 3*ones(6, 1)' 6*ones(6, 1)'];
    
N = 150;

theta = 1;

max = 0;
XI = [x;y;ones(30,1)'];
XW = [X;Y;Z;ones(30,1)'];

for i = 1 : N
    r = [randi([1 18], 1, 3) randi([19 30], 1, 3)];
    P = fdlt(XW(:, r),XI(:, r));
     projected = P * XW;
     projected_x = projected(1, :)./projected(3, :);
     projected_y = projected(2, :)./projected(3, :);
     error_x = (abs(projected_x - x));
     error_y = (abs(projected_y - y));
     error = error_x + error_y;
      t = error < theta;
      number_of_inliers = sum(t);
     if (number_of_inliers > max)
         max = number_of_inliers;
         solution = P;
      end 
end

projected = solution * XW;
projected(1, :) = projected(1, :)./projected(3, :);
projected(2, :) = projected(2, :)./projected(3, :);
imshow(im);
hold on;
plot(projected(1,:), projected(2,:), 'go');
plot(x,y,'r*');
legend({'Projected Points','Original Points'}, 'FontSize',15,'FontWeight','bold');