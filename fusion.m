% Image Fusion Project: Combining Infrared and Visible Images
% Using Gaussian Elimination for Weight Calculation and Gaussian Filtering

% Clear workspace and close all figures
clear; close all;

% Load images
visible_image = imread('visible_image.jpg');   % Replace with your visible image path
infrared_image = imread('infrared_image.jpg');  % Replace with your infrared image path

% Resize images to be the same size
[rows, cols, ~] = size(visible_image);
infrared_image = imresize(infrared_image, [rows, cols]);

% Enhanced Gaussian Filter Function
function filtered_img = gaussian_filter(img, sigma)
    % Create Gaussian filter with adjusted size
    gaussFilter = fspecial('gaussian', [7 7], sigma);
    % Apply Gaussian filter
    filtered_img = imfilter(double(img), gaussFilter, 'symmetric');
end

% Gaussian Elimination Function
function x = gaussian_elimination(A, b)
    % Augmented matrix
    Ab = [A, b];
    n = size(A, 1);
    
    % Forward elimination
    for i = 1:n
        % Pivoting
        [~, maxIndex] = max(abs(Ab(i:n, i)));
        maxIndex = maxIndex + i - 1;
        if maxIndex ~= i
            Ab([i, maxIndex], :) = Ab([maxIndex, i], :);
        end
        
        % Elimination
        for j = i + 1:n
            factor = Ab(j, i) / Ab(i, i);
            Ab(j, :) = Ab(j, :) - factor * Ab(i, :);
        end
    end

    % Back substitution
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (Ab(i, end) - Ab(i, 1:n-1) * x(1:n-1)) / Ab(i, i); % Ensure proper indexing
    end
end

% Function for image fusion using weighted average
function fused_image = image_fusion(img1, img2, weight1, weight2)
    % Normalize weights to sum to 1
    total_weight = weight1 + weight2;
    weight1 = weight1 / total_weight; % Normalize weight1
    weight2 = weight2 / total_weight; % Normalize weight2
    
    % Calculate fused image
    fused_image = weight1 * double(img1) + weight2 * double(img2);
    
    % Clip values to the range [0, 255]
    fused_image = min(max(fused_image, 0), 255);
end

% Apply Gaussian filter with adjusted parameters
sigma_visible = 1.5;  % Standard deviation for visible image filtering
sigma_infrared = 1;   % Standard deviation for infrared image filtering
filtered_visible = gaussian_filter(visible_image, sigma_visible);
filtered_infrared = gaussian_filter(infrared_image, sigma_infrared);

% Calculate weights using variance to emphasize the clearer image
var_visible = var(filtered_visible(:));
var_infrared = var(filtered_infrared(:));

% You can tweak the weight calculation strategy here based on your needs
weights = [var_visible, var_infrared];
total_weight = sum(weights);
weights = weights / total_weight; % Normalize weights to sum to 1

% Perform image fusion using the calculated weights
fused_image = image_fusion(filtered_visible, filtered_infrared, weights(1), weights(2));

% Enhance contrast of the fused image
if size(fused_image, 3) == 3
    % If the image is RGB, adjust each channel separately
    fused_image(:,:,1) = imadjust(uint8(fused_image(:,:,1))); % Red channel
    fused_image(:,:,2) = imadjust(uint8(fused_image(:,:,2))); % Green channel
    fused_image(:,:,3) = imadjust(uint8(fused_image(:,:,3))); % Blue channel
else
    % If the image is grayscale, adjust directly
    fused_image = imadjust(uint8(fused_image)); 
end

% Sharpen the fused image
fused_image = imsharpen(fused_image); % Sharpening the image

% Display results
figure('Color', 'w', 'Position', [100, 100, 1200, 400]);

% Show filtered visible image
subplot(1, 3, 1);
imshow(uint8(filtered_visible));
title('Filtered Visible Image', 'FontSize', 14);
axis image;  % Keep the aspect ratio
grid on;

% Show filtered infrared image
subplot(1, 3, 2);
imshow(uint8(filtered_infrared));
title('Filtered Infrared Image', 'FontSize', 14);
axis image;  % Keep the aspect ratio
grid on;

% Show fused image
subplot(1, 3, 3);
imshow(uint8(fused_image));
title('Fused Image', 'FontSize', 14);
axis image;  % Keep the aspect ratio
grid on;

% Display calculated weights
disp('Calculated Weights:');
disp(['Visible Image Weight: ', num2str(weights(1))]);
disp(['Infrared Image Weight: ', num2str(weights(2))]);
