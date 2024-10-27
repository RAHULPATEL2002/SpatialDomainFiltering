%% LAB:05 Spatial Domain Filtering Based Restoration (UI22EC58)
% Aim: Spatial domain filtering based restoration
% A) Generate degraded images by adding Gaussian, Salt, Pepper, and Salt & Pepper noise
% B) Restore using various spatial filter operations

% Roll No: UI22EC58
clc; 
clear all; 
close all; 
datetime

%% A) Read Image and Add Different Types of Noise

% Read the original image (convert to grayscale if needed)
original_image = imread('ckt_board.tif');
if size(original_image, 3) == 3
    original_image = rgb2gray(original_image);  % Convert to grayscale if the image is in color
end

% Display the original image
figure;
imshow(original_image);
title('Original Image UI22EC58');

%% Add Different Types of Noise

% Add Gaussian Noise
gaussian_noise_img = imnoise(original_image, 'gaussian', 0, 0.01);

% Add Salt Noise (affecting only bright pixels)
salt_noise_img = original_image;
salt_pixels = rand(size(salt_noise_img)) < 0.05;  % 5% of pixels
salt_noise_img(salt_pixels) = 255;  % Set affected pixels to white (255)

% Add Pepper Noise (affecting only dark pixels)
pepper_noise_img = original_image;
pepper_pixels = rand(size(pepper_noise_img)) < 0.05;  % 5% of pixels
pepper_noise_img(pepper_pixels) = 0;  % Set affected pixels to black (0)

% Add Salt & Pepper Noise (affecting both bright and dark pixels randomly)
salt_pepper_noise_img = imnoise(original_image, 'salt & pepper', 0.05);

% Display the noisy images
figure;
subplot(2,2,1);
imshow(gaussian_noise_img);
title('Gaussian Noise UI22EC58');

subplot(2,2,2);
imshow(salt_noise_img);
title('Salt Noise UI22EC58');

subplot(2,2,3);
imshow(pepper_noise_img);
title('Pepper Noise UI22EC58');

subplot(2,2,4);
imshow(salt_pepper_noise_img);
title('Salt & Pepper Noise UI22EC58');

%% B) Apply Various Spatial Filter Operations for Restoration

% Define the filter size for all filters
filter_size = [3 3];

% 1. Arithmetic Mean Filter
arithmetic_mean_filter = fspecial('average', filter_size);

% Apply Arithmetic Mean Filter to all noisy images
arithmetic_mean_gaussian = imfilter(gaussian_noise_img, arithmetic_mean_filter);
arithmetic_mean_salt = imfilter(salt_noise_img, arithmetic_mean_filter);
arithmetic_mean_pepper = imfilter(pepper_noise_img, arithmetic_mean_filter);
arithmetic_mean_salt_pepper = imfilter(salt_pepper_noise_img, arithmetic_mean_filter);

% 2. Geometric Mean Filter (Custom implementation)
geometric_mean_gaussian = exp(imfilter(log(double(gaussian_noise_img) + 1), ones(filter_size), 'replicate')) .^ (1 / 9);
geometric_mean_salt = exp(imfilter(log(double(salt_noise_img) + 1), ones(filter_size), 'replicate')) .^ (1 / 9);
geometric_mean_pepper = exp(imfilter(log(double(pepper_noise_img) + 1), ones(filter_size), 'replicate')) .^ (1 / 9);
geometric_mean_salt_pepper = exp(imfilter(log(double(salt_pepper_noise_img) + 1), ones(filter_size), 'replicate')) .^ (1 / 9);

% 3. Harmonic Mean Filter (Custom implementation)
harmonic_mean_gaussian = 9 ./ (imfilter(1 ./ (double(gaussian_noise_img) + 1), ones(filter_size), 'replicate'));
harmonic_mean_salt = 9 ./ (imfilter(1 ./ (double(salt_noise_img) + 1), ones(filter_size), 'replicate'));
harmonic_mean_pepper = 9 ./ (imfilter(1 ./ (double(pepper_noise_img) + 1), ones(filter_size), 'replicate'));
harmonic_mean_salt_pepper = 9 ./ (imfilter(1 ./ (double(salt_pepper_noise_img) + 1), ones(filter_size), 'replicate'));

% 4. Contra-Harmonic Mean Filter (Custom implementation)
Q = 1.5;  % Control parameter
contra_harmonic_gaussian = imfilter(double(gaussian_noise_img).^(Q+1), ones(filter_size)) ./ ...
    (imfilter(double(gaussian_noise_img).^Q, ones(filter_size)) + eps);
contra_harmonic_salt = imfilter(double(salt_noise_img).^(Q+1), ones(filter_size)) ./ ...
    (imfilter(double(salt_noise_img).^Q, ones(filter_size)) + eps);
contra_harmonic_pepper = imfilter(double(pepper_noise_img).^(Q+1), ones(filter_size)) ./ ...
    (imfilter(double(pepper_noise_img).^Q, ones(filter_size)) + eps);
contra_harmonic_salt_pepper = imfilter(double(salt_pepper_noise_img).^(Q+1), ones(filter_size)) ./ ...
    (imfilter(double(salt_pepper_noise_img).^Q, ones(filter_size)) + eps);

% 5. Median Filter
median_gaussian = medfilt2(gaussian_noise_img, filter_size);
median_salt = medfilt2(salt_noise_img, filter_size);
median_pepper = medfilt2(pepper_noise_img, filter_size);
median_salt_pepper = medfilt2(salt_pepper_noise_img, filter_size);

% 6. Min Filter (Custom implementation)
min_gaussian = ordfilt2(gaussian_noise_img, 1, ones(filter_size));
min_salt = ordfilt2(salt_noise_img, 1, ones(filter_size));
min_pepper = ordfilt2(pepper_noise_img, 1, ones(filter_size));
min_salt_pepper = ordfilt2(salt_pepper_noise_img, 1, ones(filter_size));

% 7. Max Filter (Custom implementation)
max_gaussian = ordfilt2(gaussian_noise_img, 9, ones(filter_size));
max_salt = ordfilt2(salt_noise_img, 9, ones(filter_size));
max_pepper = ordfilt2(pepper_noise_img, 9, ones(filter_size));
max_salt_pepper = ordfilt2(salt_pepper_noise_img, 9, ones(filter_size));

% 8. Mid-point Filter (Custom implementation)
mid_point_gaussian = (min_gaussian + max_gaussian) / 2;
mid_point_salt = (min_salt + max_salt) / 2;
mid_point_pepper = (min_pepper + max_pepper) / 2;
mid_point_salt_pepper = (min_salt_pepper + max_salt_pepper) / 2;

%% Display Restored Images in Two Figures for Each Noise

% Gaussian Noise Restoration
figure;
subplot(2, 2, 1); imshow(arithmetic_mean_gaussian, []); title('Arithmetic Mean (Gaussian)');
subplot(2, 2, 2); imshow(geometric_mean_gaussian, []); title('Geometric Mean (Gaussian)');
subplot(2, 2, 3); imshow(harmonic_mean_gaussian, []); title('Harmonic Mean (Gaussian)');
subplot(2, 2, 4); imshow(contra_harmonic_gaussian, []); title('Contra-Harmonic (Gaussian)');

figure;
subplot(2, 2, 1); imshow(median_gaussian, []); title('Median (Gaussian)');
subplot(2, 2, 2); imshow(min_gaussian, []); title('Min (Gaussian)');
subplot(2, 2, 3); imshow(max_gaussian, []); title('Max (Gaussian)');
subplot(2, 2, 4); imshow(mid_point_gaussian, []); title('Mid-point (Gaussian)');

% Salt Noise Restoration
figure;
subplot(2, 2, 1); imshow(arithmetic_mean_salt, []); title('Arithmetic Mean (Salt)');
subplot(2, 2, 2); imshow(geometric_mean_salt, []); title('Geometric Mean (Salt)');
subplot(2, 2, 3); imshow(harmonic_mean_salt, []); title('Harmonic Mean (Salt)');
subplot(2, 2, 4); imshow(contra_harmonic_salt, []); title('Contra-Harmonic (Salt)');

figure;
subplot(2, 2, 1); imshow(median_salt, []); title('Median (Salt)');
subplot(2, 2, 2); imshow(min_salt, []); title('Min (Salt)');
subplot(2, 2, 3); imshow(max_salt, []); title('Max (Salt)');
subplot(2, 2, 4); imshow(mid_point_salt, []); title('Mid-point (Salt)');

% Pepper Noise Restoration
figure;
subplot(2, 2, 1); imshow(arithmetic_mean_pepper, []); title('Arithmetic Mean (Pepper)');
subplot(2, 2, 2); imshow(geometric_mean_pepper, []); title('Geometric Mean (Pepper)');
subplot(2, 2, 3); imshow(harmonic_mean_pepper, []); title('Harmonic Mean (Pepper)');
subplot(2, 2, 4); imshow(contra_harmonic_pepper, []); title('Contra-Harmonic (Pepper)');

figure;
subplot(2, 2, 1); imshow(median_pepper, []); title('Median (Pepper)');
subplot(2, 2, 2); imshow(min_pepper, []); title('Min (Pepper)');
subplot(2, 2, 3); imshow(max_pepper, []); title('Max (Pepper)');
subplot(2, 2, 4); imshow(mid_point_pepper, []); title('Mid-point (Pepper)');

% Salt & Pepper Noise Restoration
figure;
subplot(2, 2, 1); imshow(arithmetic_mean_salt_pepper, []); title('Arithmetic Mean (S&P)');
subplot(2, 2, 2); imshow(geometric_mean_salt_pepper, []); title('Geometric Mean (S&P)');
subplot(2, 2, 3); imshow(harmonic_mean_salt_pepper, []); title('Harmonic Mean (S&P)');
subplot(2, 2, 4); imshow(contra_harmonic_salt_pepper, []); title('Contra-Harmonic (S&P)');

figure;
subplot(2, 2, 1); imshow(median_salt_pepper, []); title('Median (S&P)');
subplot(2, 2, 2); imshow(min_salt_pepper, []); title('Min (S&P)');
subplot(2, 2, 3); imshow(max_salt_pepper, []); title('Max (S&P)');
subplot(2, 2, 4); imshow(mid_point_salt_pepper, []); title('Mid-point (S&P)');
