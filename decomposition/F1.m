
function res = F1(I,sigma_s,sigma_r,iteration)

if ~exist('iteration','var') 
    iteration = 4;           
end

if ~exist('sigma_s','var')
    sigma_s = 3;             
end

if ~exist('sigma_r','var')
    sigma_r = 0.1;          
end

res = I.*0; 

for i=1:iteration
    disp(['RGF iteration ' num2str(i) '...']);
    for c=1:size(I,3)
        G = res(:,:,c);
        res(:,:,c) = BF(I(:,:,c),G,min(G(:)),max(G(:)),sigma_s,sigma_r);
    end
end

end
