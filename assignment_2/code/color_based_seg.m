function out=color_based_seg(images,a,b,C,D,type)
% OUTPUT:
%   the segmentation matrix of images
% INPUTS:
%   images: the matrix of colored images;
%   a, b, C and D are the indexes (in height and lenght) delimiting the car
%   to be spotted;
%   type is a number: if it is 1 it means we are looking for the black car,
%   while if it is something else, it means that we are looking for the red
%   car

% convert the first image in HSV:
img_hsv=rgb2hsv(images(:,:,:,1));
% mark the size of this matrix
[r,c,d]=size(img_hsv);
% create a new matrix to store all the 6 images:
hsv=zeros(r,c,d,6);
% convert all the six images and store them in the new matrix:
hsv(:,:,:,1)=img_hsv;
hsv(:,:,:,2)=rgb2hsv(images(:,:,:,2));
hsv(:,:,:,3)=rgb2hsv(images(:,:,:,3));
hsv(:,:,:,4)=rgb2hsv(images(:,:,:,4));
hsv(:,:,:,5)=rgb2hsv(images(:,:,:,5));
hsv(:,:,:,6)=rgb2hsv(images(:,:,:,6));
% matrix to store the 6 Hue components of interest
hue=zeros(b-a+1,D-C+1,6);
% store the Hue components
for i=1:6
    hue(:,:,i)=hsv(a:b,C:D,1,i);
end
if type==1 % Black car:
    % find the mean and the standard deviation in that rectangle in the
    % first image
    m=mean2(hsv(a:b,C:D,1,1)); 
    s=std2(hsv(a:b,C:D,1,1));
    % find the sizes of the hsv matrix
    sizes=size(hsv,1,2);
    % create the segmentation matrix:
    seg=zeros(sizes(1),sizes(2),6);
    % for each image, put to 1 the pixels which have the value in the range
    % m-s<=x<=m+s, all the others remain equal to 0:
    for k=1:6
        for i=1:sizes(1)
            for j=1:sizes(2)
                if hsv(i,j,1,k)>=(m-s) && hsv(i,j,1,k)<=(m+s)
                    seg(i,j,k)=1;
                end
            end
        end
    end
else % Red car:
    % find the sizes of the hsv:
    sizes=size(hsv,1,2);
    % for each image, put to 1 the pixels which have the value in the
    % range 0.97<=x<=1, all the others remain equal to 0:
    for k=1:6
        for i=1:sizes(1)
            for j=1:sizes(2)
                if hsv(i,j,1,k)>=0.97 && hsv(i,j,1,k)<=1
                    seg(i,j,k)=1;
                end
            end
        end
    end
end
% create the two subplots:
f1=figure;subplot(2,3,6);
f2=figure;subplot(2,3,6);
for j=1:6
    figure(f1);
    prop=regionprops(logical(seg(:,:,j)), 'Area','Centroid','BoundingBox');
    [rr,cc]=size(prop);
    area=zeros(rr,1);
    for i=1:rr
        area(i)=prop(i).Area;
    end
    [M,index]=max(area);
    xc=floor(prop(index).Centroid(1));
    yc=floor(prop(index).Centroid(2));
    ul_corner_width=prop(index).BoundingBox;
    subplot(2,3,j),imagesc(seg(:,:,j)),colormap gray,title('detected object');
    hold on
    plot(xc,yc,'*r');
    rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0]);
    figure(f2);
    subplot(2,3,j),imagesc(uint8(images(:,:,:,j))),colormap gray,title('detected object');
    hold on
    plot(xc,yc,'*r');
    rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0]);
end
figure(f1);
if type==1
    sgtitle('detection of the black car - Hue channel with threshold')
else
    sgtitle('detection of the red car - Hue channel with threshold')
end
figure(f2);
if type==1
    sgtitle('detection of the black car - color-based segmentation')
else
    sgtitle('detection of the red car - color-based segmentation')
end
out=seg;
end