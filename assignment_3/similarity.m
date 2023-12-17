function [d] = similarity(sim, f1, f2, p1, p2, sigma)
% USAGE: [d] = similarity(sim, f1, f2, p1, p2, sigma)
%   computes the similarity between features f1 and f2 according to the measure 'sim'
%   sim       a string controlling the similarity function
%   f1 f2     pair of features to use for the computations. Different objects depending on the chosen similarity measure:
%               'POSITIONS' mode --> positions of the features (1x2 vectors)
%               'NCC' mode --> positions of the features (1x2 vectors) - corrsponding patches are passed with the parameters p1 and p2
%               'SIFT' mode --> SIFT descriptors (128x1 vectors)
%   p1 p2     patches to be used for the computations, only for 'NCC' mode
%
% returns the requested similarity value for the given pair of features

switch(sim)
        
    case 'NCC' % ----------------------------------------------------------
        
        % normalize the patches
        xnorm = (p1 - mean2(p1))/std2(p1);
        ynorm = (p2 - mean2(p2))/std2(p2);
        
        % normalized cross-correlation between patches
        ncc = 1/(size(p1,1)*size(p1,1))* (sum(sum(xnorm.*ynorm)));
        
        % euclidean distance between postions
        dist = sqrt((f1(1,1)-f2(1,1))^2 + (f1(1,2)-f2(1,2))^2);
        
        % combination of the two contribution
        d = ((ncc + 1)/2)*exp((-dist)/(2*(sigma^2))); %qua faccio direttamente la similarity, quindi in findmatches.m sta così com'è
        
    case 'SIFT' % ---------------------------------------------------------
        
        d = sqrt(sum((f1(:,1)-f2(:,1)).^2)); %qua è una distance, in findmatches.m faccio la similarity (-)
        
    otherwise
        display('Unrecognized similarity function');
        display('Possible values of parameter "sim" are "corners", "NCC", "SIFT"');
    end

end