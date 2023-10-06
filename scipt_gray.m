%% MSFDF �Ҷ�ҽѧͼ���ں�
close all; clear all; clc;
addpath source_images;
addpath functions;
%% CT/MR,MR-T1/MR-T2ͼ���ں�
[imagename1 imagepath1]=uigetfile('ʵ��ͼ��\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
Y1=imread(strcat(imagepath1,imagename1)); % ����CT��MR-T1ͼ��
[imagename2 imagepath2]=uigetfile('ʵ��ͼ��\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image'); 
Y2=imread(strcat(imagepath2,imagename2)); % ����MR��MR-T2ͼ��
Y1=Y1(:,:,1);
A = im2double(Y1);   
B = im2double(Y2);  

if size(A,3)==3
    A=rgb2gray(A);   
end
if size(B,3)==3
    B=rgb2gray(B); 
end

%% MSFDF�ֽ�
tic;
[FS1,FS2,FS3,CS1,CS2,CS3,BS,S1] = fenjie(A);
[BFS1,BFS2,BFS3,BCS1,BCS2,BCS3,BBS,BS1] = fenjie(B);
%% ��Ե��
LGE1=STO(S1).*local_energy(S1,4);         
LGE2=STO(BS1).*local_energy(BS1,4);
map=(LGE1>LGE2);
map=majority_consist_new(map,21);        
FS=map.*S1+~map.*BS1;                   
%% �����
Q = fusion_EA(FS1,BFS1,20);
W = fusion_EA(FS2,BFS2,20);
E = fusion_EA(FS3,BFS3,20);
FSS=2/4*Q+1/4*W+1/4*E;
%% ������
M=fusion(CS1,BCS1);
N=fusion(CS2,BCS2);
O=fusion(CS3,BCS3);
CSS=2/4*M+1/4*N+1/4*O;
%% ƽ����
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
%% ��MSFDF�ع�
YYY=0.9*YY+0.4*CSS+FS+0.3*FSS;
toc;
%% �͹�����
[psnr1,psnr2,ss1,ss2,mi] = pinjiazhibiao(Y1,Y2,YYY);
disp([psnr1,psnr2,ss1,ss2,mi])
[qa,S,sf] = pinjia(A,B,YYY);
disp([qa,S,sf])
%% ��������
imshow(YYY,'Border','tight');