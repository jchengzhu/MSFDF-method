%   This funciton is to compute the variance
%   It requires two parameters: input image and filter window radius
%   Author: Dan Huang

function var_I = variance(I,r)
%Compute local mean by calling function localMean()
mean_I=localMean(I,r);

%Compute correlation 
corr_I=localMean(I.*I,r);

%Compute variance
var_I=corr_I-mean_I.*mean_I;
end