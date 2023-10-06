function  HF=high_fusion(A,B)

Y1 = gb(A);
Y2 = gb(B);

Y1=Y1.master_map_resized;
Y2=Y2.master_map_resized;

for i=1:256
    for j=1:256
if Y1(i,j)>Y2(i,j)
HF(i,j)=A(i,j);
elseif Y1(i,j)<Y2(i,j)
   HF(i,j)=B(i,j); 
elseif Y1(i,j)-Y2(i,j)<0.01
        HF(i,j)=0.5*A(i,j)+0.5*B(i,j);
end
    end
end
end