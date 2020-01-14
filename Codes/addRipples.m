function I_ripple = addRipples(I, Type, Mag)
%% ADDRIPPLES adds Horizontal or Vertical Ripples to the Image.
%
%   Input
%       I	  - Input Image
%       Type  - Horizontal or Vertical Ripples {'Hori', 'Vert'}
%       Mag   - Magnitude of Ripples
%
%   Output
%       I_ripple - Image with Ripples.

%% Function starts here

% Get the Size of the Input Image
[r,c] = size(I);
period = 10; % No. of rows
offset = 1 - Mag; % How much the cosine is raised above 0

% Create the Ripples
switch Type
    case 'Hori' % Horizontal
        rowVector = (1 : r)';
        Ripples = Mag * (1 + cos(2 * pi * rowVector / period))/2 + offset;
        RipplesImage = repmat(Ripples, [1, c]);
        
    case 'Vert' % Vertical
        colVector = (1: c);
        Ripples = Mag * (1 + cos(2 * pi * colVector / period))/2 + offset;
        RipplesImage = repmat(Ripples, [r, 1]);
end

% Add Rippes to the Input Image
I_ripple = RipplesImage .* double(I);

end

