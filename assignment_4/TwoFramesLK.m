function [Uf,Vf] = TwoFramesLK(image1, image2, windowSize, index,gradient)

At = image1;
At1 = image2;

[rows, cols, dep]=size(At);
if (dep==3)
    At = im2gray(At);
    At1 = im2gray(At1);
end

[Uf,Vf] = LucasKanade(At, At1, windowSize);

figure(1)
subplot(2,2,1)
imshow(At)
title(['Frame ' num2str(index)]);
subplot(2,2,2)
imshow(At1)
title(['Frame ' num2str(index+1)]);

%figure(2)
% SEE help quiver for more information
%SCOMMENTA QUESTA RIGA

%the 10 inside means each time we skip 10 pixels because otherwise (less
%than 10) is unreadable
if gradient
    subplot(2,2,3)
    quiver(Uf(1:10:size(Uf,1), 1:10:size(Uf,2)), -Vf(1:10:size(Vf,1), 1:10:size(Vf,2)))
    title("Gradient")
    axis ij
end

%Uso quiver(u, -v, 0) per visualizzare il campo vettoriale (u,v)
%
%COMMENTA QUESTA RIGA:
%quiver(Reduce((Reduce(medfilt2(flipud(U),[5 5])))), -Reduce((Reduce(medfilt2(flipud(V),[5 5])))), 0), axis equal

end