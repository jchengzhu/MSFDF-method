function [J,w] = F2(I,G,SigmaS,scale)

padMethod = 'symmetric';
patchSize = floor(4*SigmaS) + 1;
if mod(patchSize,2) == 0
   patchSize = patchSize + 1;
end

N = patchSize*patchSize;
hs = ones(patchSize)/N;

muG = (imfilter(G, hs,padMethod));
muGG = (imfilter(G.*G, hs,padMethod));
w = max(max(0,muGG - muG.*muG),[],3);

SigmaR = scale*mean(w(:));
w = w./SigmaR;
w = 1./(1+w.^2); 

ha = fspecial('gaussian',patchSize,SigmaS);
normalizeFactor = imfilter(w,ha,padMethod);
if size(I, 3) == 3
    w = cat(3,w,w,w); 
    normalizeFactor = cat(3,normalizeFactor,normalizeFactor,normalizeFactor);
end
J = imfilter(w.*I,ha,padMethod)./(eps+normalizeFactor) ;
end

