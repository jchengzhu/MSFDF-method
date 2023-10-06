%   This funciton is to compute the local mean
%   It requires two parameters: input image and filter window radius
%   Author: Dan Huang

function mean_I=localMean(P,r)
w_size=r*2+1;
window=ones(w_size);
window=window./(w_size^2);
%compute convolution
mean_I=conv2(P,window,'same');
end
