%%%%%%%%%%%%%%%%%%%% FILTERING IN FREQUENCY DOMAIN WITH SPATIAL ENHANCEMENT %%%%%%%%%%%%%%%%%%%%

close all; 
clear; clc;
format long g;

%% Add Periodic high frequency Noise to the Image

I = imread('cameraman.tif');
[rows, columns, numberOfColorBands] = size(I);
if numberOfColorBands > 1
    I = rgb2gray(I);
end

figure,
subplot(2,3,1), imshow(I, []), title('Original Image');

% Add Ripples
I_ripple = addRipples(I, 'Hori', 0.5);
subplot(2,3,2), imshow(I_ripple,[]), title('Image with Periodic Noise');

%% Compute Discrete Fourier Transform of the Noisy Image
F = fftshift(fft2(I));
Freq = log(abs(F));
subplot(2,3,3), imshow(Freq,[]), title('Fourier Transform of Noisy Image')

%% Create a Notch Filter Mask and Apply on the Frequency Image
Thresh = 10.645;
Mask = [110,110;150,150];
Freq_notch = notchfilt(F, Mask, Low_Thresh, High_Thresh);

%% Compute Inverse Discrete Fourier Transform to Restore the Image
IDFT = abs(ifft2(fftshift(Freq_notch)));
minValue = min(min(IDFT));
maxValue = max(max(IDFT));
subplot(2,3,5), imshow(IDFT,[]), title('Restored Image');

%% Perform Spatial Enhancement on the Restored Image
b = imsharpen(IDFT,'Radius',1,'Amount',1.5);
subplot(2,3,6), imshow(b,[]), title('Enhanced Image(Sharpening)');

% b = medfilt2(G);
% subplot(2, 3, 6), imshow(b,[]);
% title('Enhanced Image (Median Filter)');