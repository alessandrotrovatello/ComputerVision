function [match,y,x]=template_matching(template,img)
% OUTPUTS:
% match is the output of the normxcorr2 Matlab function;
% y and x are the coordinates of the center of the match
% INPUTS:
% template is the template image;
% img is the image on which the template is looked for
match=normxcorr2(template,img);
% look for the maximum of the NCC, which is the point in which the center
% of the rectangle will be positioned
maximum=max(max(match));
% find the indexes corresponding to the maximum
[y,x]=find(match==maximum);
end