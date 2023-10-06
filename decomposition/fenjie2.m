function [FS1,FS2,FS3,CS1,CS2,CS3,BS,S1] = fenjie2(A)
s=3;    r=0.05;   N=4;    T=21; 
E1 = F1(A,s,r,1);       
S1= A-E1;     
iter = 5;
SigmaS = 2;
scale = 0.2;
E11 =E1;
for n=1 : iter
    E11 = F2(E11,E1,SigmaS,scale);
end 
FS1=1.5*A-E11;
CS1=1.5*E1-E11;
E2 = F1(E1,s,r,1); 
E21 =E2;
for n=1 : iter
    E21 = F2(E21,E2,SigmaS,scale);
end 
FS2=1.5*E1-E21;
CS2=1.5*E2-E21;
E3 = F1(E2,s,r,1); 
E31 =E3;
for n=1 : iter
    E31 = F2(E31,E3,SigmaS,scale);
end 
FS3=1.5*E2-E31;
CS3=1.5*E3-E31;
BS=E3;
end

