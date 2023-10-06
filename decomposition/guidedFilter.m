function q = guidedFilter(I,p,r,e)
%Compute local mean of two images by calling function localMean()
mean_I=localMean(I,r);
mean_P=localMean(p,r);

%Compute variance by calling function variance()
var_I=variance(I,r);

%Compute covariance by calling function covariance()
cov_IP=covariance(I,p,r);

%Compute a and b 
a=cov_IP./(var_I+e);
b=mean_P-a.*mean_I;

mean_a=localMean(a,r);
mean_b=localMean(b,r);

%Compute output image through linear relationship.
q=mean_a.*I+mean_b;
end