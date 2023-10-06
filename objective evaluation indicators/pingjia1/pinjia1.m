function [qa,S,sf] = pinjia1(Y1,Y2,YY)
%[psnr1,psnr2,ss1,ss2,mi,en,qa,vi,S,sf] = pinjiazhibiao(Y1,Y2,YY);
MyFirstGrayPic = rgb2gray(YY);%�����еĺ�������RGB���Ҷ�ͼ���ת��  
  
[rows , cols , colors] = size(YY);%�õ�ԭ��ͼ��ľ���Ĳ���  
YY1 = zeros(rows , cols);%�õõ��Ĳ�������һ��ȫ��ľ���������������洢������ķ��������ĻҶ�ͼ��  
YY1 = uint8(YY1);%��������ȫ�����ת��Ϊuint8��ʽ����Ϊ���������䴴��֮��ͼ����double�͵�  
  
for i = 1:rows  
    for j = 1:cols  
        sum = 0;  
        for k = 1:colors  
            sum = sum + YY(i,j ,k) / 3;%����ת���Ĺؼ���ʽ��sumÿ�ζ���Ϊ��������ֶ����ܳ���255  
        end  
        YY1(i,j) = sum;  
    end  
end

[rows , cols , colors] = size(Y2);%�õ�ԭ��ͼ��ľ���Ĳ���
YY2 = zeros(rows , cols);%�õõ��Ĳ�������һ��ȫ��ľ���������������洢������ķ��������ĻҶ�ͼ��  
YY2 = uint8(YY2);%��������ȫ�����ת��Ϊuint8��ʽ����Ϊ���������䴴��֮��ͼ����double�͵�  
  
for i = 1:rows  
    for j = 1:cols  
        sum = 0;  
        for k = 1:colors  
            sum = sum + Y2(i,j ,k) / 3;%����ת���Ĺؼ���ʽ��sumÿ�ζ���Ϊ��������ֶ����ܳ���255  
        end  
        YY2(i,j) = sum;  
    end  
end 

qa = analysis_Qabf(Y1, YY2, YY1);
S = SD(YY1);
sf= MySF(YY1);
end

