function [F]=EightPointsAlgorithm(P1,P2)

[size1, size2]=size(P1);
r=max([size1, size2]);
% write down the matrix A, that is the affinity matrix
A=ones(r,9);
for i=1:r
    M=P2(:,i).*transpose(P1(:,i));
    %A(i,:)=reshape(M,[1,9]);
    A(i,:)=[M(1,:), M(2,:), M(3,:)];
end

%SVD decomposition of A:
[U,D,V]=svd(A);
f=V(:,end);
F=reshape(f,[3,3])';
[U,D,V]=svd(F);
D(3,3)=0;
F=U*D*transpose(V);

end