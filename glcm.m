function [features] = glcm(X)
[w h n]=size(X);
 offset=[0 1; -1 1; -1 0; -1 -1];

for i=1:n  
M = graycomatrix(X(:,:,i), 'GrayLimits', [0, 255], 'NumLevels', 256, 'Offset', offset, 'Symmetric', true);
stats1 = graycoprops(M,'all');
features(:,i)= struct2array(stats1);

end