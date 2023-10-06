function fe = fusion_EA(I1,I2,a)

[m,n] = size(I1);

m1 = mean(I1(:));
m2 = mean(I2(:));
M1 = median(I1(:));
M2 = median(I2(:));
G1 = (m1+M1)/2;
G2 = (m2+M2)/2;

w1 = zeros(m,n);
w2 = zeros(m,n);
W1 = zeros(m,n);
W2 = zeros(m,n);

e = entropy(I1);
f = entropy(I2);
ee=e+f;
ed1=edge_intensity(I1);
ed2=edge_intensity(I2);
eee=ed1+ed2;
for i = 1:m
    for j = 1:n
        w1(i,j) = exp(a*abs(I1(i,j)-G1));
        w2(i,j) = exp(a*abs(I2(i,j)-G2));
        W1(i,j) = w1(i,j)+e+ed1/(w1(i,j)+w2(i,j)+ee+eee);
        W2(i,j) = w2(i,j)+f+ed2/(w1(i,j)+w2(i,j)+ee+eee);
    end
end

fe = zeros(m,n);
for i = 1:m
    for j = 1:n
        if  W1(i,j)> W2(i,j)
        fe(i,j) = I1(i,j);
        else
            fe(i,j) = I2(i,j);
        end
    end
end