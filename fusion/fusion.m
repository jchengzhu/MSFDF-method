function  LF=fusion(S1,S2)
map=abs(SF_Engerg1(S1))>=abs(SF_Engerg1(S2));
LF=S1.*map+~map.*S2;

