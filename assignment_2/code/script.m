% Lab5 of Computer Vision, Robotics Engineering cohort 2023/2024
% Curated by Ierardi Ambra, Scorrano Andrea, Trovatello Alessandro

clc
clear
close all

% script
addpath("Images")
% IMAGE LOADING:
% image on which the corners are detected:
image=imread("i235.png");
image=double(image);
% first car image:
img1=imread("ur_c_s_03a_01_L_0376.png");
img1_bw=rgb2gray(img1);
[r,c,d]=size(img1);
% these dimensions are used to create a new matrix, "images", with all the 6
% images, in order to avoid performing the same actions on different images
% many times:
images=zeros(r,c,d,6); 
images(:,:,:,1)=double(img1);
% also a matrix of the B&W version of the images is necessary:
images_bw=zeros(r,c,6);
images_bw(:,:,1)=double(img1_bw);
figure,imagesc(img1),colormap gray,title('original image')
% in order to select the template it was necessary to look at the plot of 
% the picture: it was found that the red car is in this range of pixels: 
% 360:425, 690:770
red_template=img1(360:425,690:770);
b=770-690; % base of the image
h=425-360; % height pf the image
% loading the next car frames, on the RGB image and on the B&W one:
img2=imread("ur_c_s_03a_01_L_0377.png");
images_bw(:,:,2)=double(rgb2gray(img2));
images(:,:,:,2)=double(img2);
img3=imread("ur_c_s_03a_01_L_0378.png");
images_bw(:,:,3)=double(rgb2gray(img3));
images(:,:,:,3)=double(img3);
img4=imread("ur_c_s_03a_01_L_0379.png");
images_bw(:,:,4)=double(rgb2gray(img4));
images(:,:,:,4)=double(img4);
img5=imread("ur_c_s_03a_01_L_0380.png");
images_bw(:,:,5)=double(rgb2gray(img5));
images(:,:,:,5)=double(img5);
img6=imread("ur_c_s_03a_01_L_0381.png");
images_bw(:,:,6)=double(rgb2gray(img6));
images(:,:,:,6)=double(img6);
% perform the first matching in order to find the new dimensions of the
% image, to use them to create a new matrix, just as before:
match1=normxcorr2(red_template,images_bw(:,:,1));
[r,c]=size(match1);
% matrix of the matches of the red car: 
red_matches=zeros(r,c,6);
red_matches(:,:,1)=match1;
% allocation of vectors with the coordinates of the center of the red car
% in all of the 6 images:
y=zeros(1,6);
x=zeros(1,6);
for i=1:6
    [red_matches(:,:,i),y(i),x(i)]=template_matching(red_template,images_bw(:,:,i));
end
figure,subplot(2,3,6)
% create a subplot figure with the colored images and the relative center
% and rectangle:
for i=1:6
    subplot(2,3,i)
    % image:
    imagesc(uint8(images(:,:,:,i))),colormap gray,title('detected red car ',num2str(i))
    hold on
    % mark the center:
    plot(x(i)-round(b/2),y(i)-round(h/2),'*r')
    hold on
    % mark the rectangle:
    rectangle('Position',[x(i)-b y(i)-h b h],'EdgeColor','r')
end
sgtitle('detetction of the red car - template matching')

% now same procedure for the BLACK CAR:
% define the template, based on the observation of the original image:
black_template=img1(370:405,575:635);
% perform the NCC on the first frame to record the new dimensions of the
% image:
match1b=normxcorr2(black_template,images_bw(:,:,1));
[r,c]=size(match1b);
% create a blank matrix for all the 6 matches:
black_matches=zeros(r,c,6);
% prepare the vectors of the coordinates of the centers;
y=zeros(1,6);
x=zeros(1,6);
% base of the rectangle/template:
b=635-575;
% height of the rectangle/template:
h=405-370;
% start the timing
tic
% perform the template matching of all the 6 images of the black car:
for i=1:6
    [black_matches(:,:,i),y(i),x(i)]=template_matching(black_template,images_bw(:,:,i));
end
figure,subplot(2,3,6)
% create a subplot figure with the colored images and the relative center
% and rectangle:
for i=1:6
    subplot(2,3,i)
    % image:
    imagesc(uint8(images(:,:,:,i))),colormap gray,title('detected black car ',num2str(i))
    hold on
    % mark the center:
    plot(x(i)-round(b/2),y(i)-round(h/2),'*r') %%TRASFORMAZIONE DELLE COORDINATE
    hold on
    % mark the rectangle:
    rectangle('Position',[x(i)-b y(i)-h b h],'EdgeColor','r')
end
sgtitle('detection of the black car - template matching')
% stop the timing:
t1=toc

% COMPARISON WITH LAB 4:

% red car:
seg_red=color_based_seg(images,360,420,690,770,2);
% black car:
seg_black=color_based_seg(images,390,400,575,595,1);

% THREE DIFFERENT WINDOWS:
% 1st: 10 pixels (for both dimensions) bigger than the first one:
wdw1=img1(365:410,570:640);
% perform the match for the first image to get the sizes:
match=normxcorr2(wdw1,rgb2gray(img1));
[r,c]=size(match);
% create a new matrix to allocate all the matches:
wdw1_match=zeros(r,c,6);
% base of the rectangle:
b=640-570;
% height of the rectangle:
h=410-365;
% vectors to mark the coordinates of all the centers:
x=zeros(1,6);
y=zeros(1,6);
% start the timing:
tic
% perform all the matches:
for i=1:6
    [wdw1_match(:,:,i),y(i),x(i)]=template_matching(wdw1,images_bw(:,:,i));
end
figure,subplot(2,3,6)
% create a subplot figure with the colored images and the relative center
% and rectangle:
for i=1:6
    subplot(2,3,i)
    % image:
    imagesc(uint8(images(:,:,:,i))),colormap gray,title('detected black car ',num2str(i))
    hold on
    % mark the center:
    plot(x(i)-round(b/2),y(i)-round(h/2),'*r')
    hold on
    % mark the rectangle:
    rectangle('Position',[x(i)-b y(i)-h b h],'EdgeColor','r')
end
sgtitle('45X70 window size - black car')
% stop the timing:
t2=toc

%2nd: 20 pixels (for both dimensions) smaller than the first one:
wdw2=img1(380:395,585:625);
% perform the match for the first image to get the sizes:
match=normxcorr2(wdw2,rgb2gray(img1));
[r,c]=size(match);
% create a new matrix to allocate all the matches:
wdw2_match=zeros(r,c,6);
% base of the rectangle:
b=625-585;
% height of the rectangle:
h=395-380;
% vectors to mark the coordinates of all the centers:
x=zeros(1,6);
y=zeros(1,6);
% start the timing:
tic
% perform all the matches:
for i=1:6
    [wdw2_match(:,:,i),y(i),x(i)]=template_matching(wdw2,images_bw(:,:,i));
end
figure,subplot(2,3,6)
% create a subplot figure with the colored images and the relative center
% and rectangle:
for i=1:6
    subplot(2,3,i)
    % image:
    imagesc(uint8(images(:,:,:,i))),colormap gray,title('detected black car ',num2str(i))
    hold on
    % mark the center:
    plot(x(i)-round(b/2),y(i)-round(h/2),'*r')
    hold on
    % mark the rectangle:
    rectangle('Position',[x(i)-b y(i)-h b h],'EdgeColor','r')
end
sgtitle('15X40 window size - black car')
% stop the timing:
t3=toc

%3rd: 50 pixels (for both dimensions) bigger than the first one:
wdw3=img1(345:430,550:660);
% perform the match for the first image to get the sizes:
match=normxcorr2(wdw3,rgb2gray(img1));
[r,c]=size(match);
% create a new matrix to allocate all the matches:
wdw3_match=zeros(r,c,6);
% base of the rectangle:
b=660-550;
% height of the rectangle:
h=430-345;
% vectors to mark the coordinates of all the centers:
x=zeros(1,6);
y=zeros(1,6);
% start the timing:
tic
% perform all the matches:
for i=1:6
    [wdw3_match(:,:,i),y(i),x(i)]=template_matching(wdw3,images_bw(:,:,i));
end
figure,subplot(2,3,6)
% create a subplot figure with the colored images and the relative center
% and rectangle:
for i=1:6
    subplot(2,3,i)
    % image:
    imagesc(uint8(images(:,:,:,i))),colormap gray,title('detected black car ',num2str(i))
    hold on
    % mark the center:
    plot(x(i)-round(b/2),y(i)-round(h/2),'*r')
    hold on
    % mark the rectangle:
    rectangle('Position',[x(i)-b y(i)-h b h],'EdgeColor','r')
end
sgtitle('85X110 window size - black car')
% stop the timing:
t4=toc


% HARRIS CORNER DETECTOR:

harrisCornerDetector(image)
