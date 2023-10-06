function [psnr1,psnr2,ss1,ss2,mi] = pinjiazhibiao(Y1,Y2,YY)
%%灰度图psnr1,psnr2,ss1,ss2,mi客观评价指标
psnr1=mypsnr(Y1, YY);
psnr2=mypsnr(Y2, YY);
ss1=ssim(Y1, YY);
ss2=ssim(Y2, YY);
mi =analysis_MI(Y1,Y2,YY);
end

