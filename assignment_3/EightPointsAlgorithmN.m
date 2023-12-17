function [F]=EightPointsAlgorithmN(P1,P2)
[nP1, T1] = normalise2dpts(P1);
[nP2, T2] = normalise2dpts(P2);
F=EightPointsAlgorithm(nP1,nP2);
F=transpose(T2)*F*T1;
end