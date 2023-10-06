%% MSFDF 彩色医学图像融合
close all; clear all; clc;
addpath source_images;
addpath functions;
%% MR/PET,CT/PET图像融合
[imagename1 imagepath1]=uigetfile('实验图像\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
Y1=imread(strcat(imagepath1,imagename1)); %输入MR或CT图像
[imagename2 imagepath2]=uigetfile('实验图像\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image'); 
Y2=imread(strcat(imagepath2,imagename2)); %输入PET图像
A = im2double(Y1);   
B = im2double(Y2);   
if size(A,3)>1
    A=rgb2gray(A);    
end
[hei, wid] = size(A);
B_YUV=ConvertRGBtoYUV(B);   
BB=B_YUV(:,:,1);        
%% MSFDF分解  
tic;
[FS1,FS2,FS3,CS1,CS2,CS3,BS,S1] = fenjie2(A);
[BFS1,BFS2,BFS3,BCS1,BCS2,BCS3,BBS,BS1] = fenjie2(BB);
%% 边缘层
LGE1=STO(S1).*local_energy(S1,4);         
LGE2=STO(BS1).*local_energy(BS1,4);
map=(LGE1>LGE2);
map=majority_consist_new(map,21);        
FS=map.*S1+~map.*BS1;                  
%% 纹理层
Q = fusion_EA(FS1,BFS1,20);
W = fusion_EA(FS2,BFS2,20);
E = fusion_EA(FS3,BFS3,20);
FSS=2/4*Q+1/4*W+1/4*E;
%% 轮廓层
M=fusion(CS1,BCS1);
N=fusion(CS2,BCS2);
O=fusion(CS3,BCS3);
CSS=2/4*M+1/4*N+1/4*O;
%% 平滑层
s=5;
h=1;
x=5;
y1=nsctdec(BS,[1,1,1,1],'pkva','9-7');
y2=nsctdec(BBS,[1,1,1,1],'pkva','9-7');
n=length(y1);
y{1}=Low_fusion(y1{1},y2{1});
for l=2:n
    if l<5
        for d=1:length(y1{l})
            y{l}{d}=high_fusion(y1{l}{d},y2{l}{d});
        end
    end
    if l>=5
        for d=1:length(y1{l})
            y{l}{d}=highpass_fuse(y1{l}{d},y2{l}{d});
        end
    end
end
YY=nsscrec(y,'pkva','9-7');
%% 逆MSFDF重构
F=0.6*YY+0.1*CSS+1*FS+0.9*FSS;
F_YUV=zeros(hei,wid,3);
F_YUV(:,:,1)=F;
F_YUV(:,:,2)=B_YUV(:,:,2);
F_YUV(:,:,3)=B_YUV(:,:,3);
final_F=ConvertYUVtoRGB(F_YUV);   
toc;
%% 客观评价
Y1=Y1(:,:,1);
[psnr1,psnr2,ss1,ss2,mi] = pinjiazhibiao1(Y1,Y2,final_F);
disp([psnr1,psnr2,ss1,ss2,mi])
[qa,S,sf] = pinjia1(A,B,final_F);
disp([qa,S,sf])
imshow(final_F,'Border','tight');