clc
clear
close all

%% Optical Flow

addpath('Data\sflowg\'); elements_list = dir(fullfile('Data\sflowg\'));
%addpath('Data\sphere\'); elements_list = dir(fullfile('Data\sphere\'));
%addpath('Data\statua\'); elements_list = dir(fullfile('Data\statua\'));
%addpath('Data\stennis\'); elements_list = dir(fullfile('Data\stennis\'));
%addpath('Data\videosurveillance\'); elements_list = dir(fullfile('Data\videosurveillance\'));

numberOfImages = length(elements_list);
images = cell(1,numberOfImages-2); 

for i=1:numberOfImages-2
    images{i} = imread(i+".ppm");
end

dim=max(size(images));
u=zeros(dim,1);
v=zeros(dim,1);
for i=1:numberOfImages-1
    if i~=20
        [u,v]=TwoFramesLK(images{i},images{i+1},3,i);
        map=zeros(size(u,1),size(u,2));
        map=sqrt(u.*u+v.*v);
        subplot(2,2,4)
        imshow(map)
        title("Magnitude of the optical flow")
    end
end

%% Running Average:

%[Mt1,FIRST_IDX1, LAST_IDX1]=change_detection();
[Mt2,numberOfImages,N]=background_model_based();
% figure
% for t = FIRST_IDX1 : LAST_IDX1
%     imshow(uint8(Mt1*255));
%     pause(0.1)
% end
figure
for t = 1:numberOfImages
    imshow(uint8(Mt2*255));
    pause(0.1)
end