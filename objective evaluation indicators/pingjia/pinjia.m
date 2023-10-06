function [qa,S,sf] = pinjia(Y1,Y2,YY)
%%灰度图qa,S,sf客观评价指标
qa = analysis_Qabf(Y1, Y2, YY);
S = SD(YY);
sf= MySF(YY);
end

