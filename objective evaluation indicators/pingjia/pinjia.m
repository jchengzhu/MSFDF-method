function [qa,S,sf] = pinjia(Y1,Y2,YY)
%%�Ҷ�ͼqa,S,sf�͹�����ָ��
qa = analysis_Qabf(Y1, Y2, YY);
S = SD(YY);
sf= MySF(YY);
end

