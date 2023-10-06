function [qa,S,sf] = pinjia1(Y1,Y2,YY)
%[psnr1,psnr2,ss1,ss2,mi,en,qa,vi,S,sf] = pinjiazhibiao(Y1,Y2,YY);
MyFirstGrayPic = rgb2gray(YY);%用已有的函数进行RGB到灰度图像的转换  
  
[rows , cols , colors] = size(YY);%得到原来图像的矩阵的参数  
YY1 = zeros(rows , cols);%用得到的参数创建一个全零的矩阵，这个矩阵用来存储用下面的方法产生的灰度图像  
YY1 = uint8(YY1);%将创建的全零矩阵转化为uint8格式，因为用上面的语句创建之后图像是double型的  
  
for i = 1:rows  
    for j = 1:cols  
        sum = 0;  
        for k = 1:colors  
            sum = sum + YY(i,j ,k) / 3;%进行转化的关键公式，sum每次都因为后面的数字而不能超过255  
        end  
        YY1(i,j) = sum;  
    end  
end

[rows , cols , colors] = size(Y2);%得到原来图像的矩阵的参数
YY2 = zeros(rows , cols);%用得到的参数创建一个全零的矩阵，这个矩阵用来存储用下面的方法产生的灰度图像  
YY2 = uint8(YY2);%将创建的全零矩阵转化为uint8格式，因为用上面的语句创建之后图像是double型的  
  
for i = 1:rows  
    for j = 1:cols  
        sum = 0;  
        for k = 1:colors  
            sum = sum + Y2(i,j ,k) / 3;%进行转化的关键公式，sum每次都因为后面的数字而不能超过255  
        end  
        YY2(i,j) = sum;  
    end  
end 

qa = analysis_Qabf(Y1, YY2, YY1);
S = SD(YY1);
sf= MySF(YY1);
end

