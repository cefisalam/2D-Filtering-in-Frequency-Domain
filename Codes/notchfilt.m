function Freq_notch = notchfilt(F, Mask, Low_Thresh, High_Thresh)
%% NOTCHFILT performs Notch Filtering on an Image in Frequency Domain.
%
%   Input
%       Freq   - Input Image in Frequency Domain
%       Mask   - Coordinates to exclude the central peak {[x1, y1; x2, y2]}
%       Low_ Thresh, High_Thresh - Bandpass Threshold of Image in Frequency Domain
%
%   Output
%       Freq_notch - Filtered Image (Periodic Noise will be removed from Frequency Image)

%% Function starts here

% Find the location of the High Frequency Peaks
Freq = log(abs(F));
Peaks = (Low_Thresh < Freq) && (Freq < High_Thresh); % Binarize the image
M = Mask;
%subplot(2,3,4), imshow(Peaks, []), title('Peaks');

% Exclude the Central Peak in the Mask
Peaks(M(1):M(2),M(3):M(4)) = 0;
%subplot(2,3,4), imshow(Peaks, []), title('Notch Filter Mask');

% Remove the Peaks from the Frequency Image
F(Peaks) = 0;

% Take log magnitude so we can see it better in the display.
Freq_notch = F;
subplot(2,3,4), imshow(log(abs(F)), []), title('Output after Notch Filtering');

end

