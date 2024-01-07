% Lab7 of Computer Vision, Robotics Engineering cohort 2023/2024
% Curated by Ierardi Ambra, Scorrano Andrea, Trovatello Alessandro

clc, clear, close all

%addpath('Data\sflowg\'); elements_list = dir(fullfile('Data\sflowg\'));
%addpath('Data\sphere\'); elements_list = dir(fullfile('Data\sphere\'));
%addpath('Data\statua\'); elements_list = dir(fullfile('Data\statua\'));
addpath('Data\stennis\'); elements_list = dir(fullfile('Data\stennis\'));
%addpath('Data\videosurveillance\'); elements_list = dir(fullfile('Data\videosurveillance\'));

numberOfImages = length(elements_list);
images = cell(1,numberOfImages-2); 

for i=1:numberOfImages-2
    images{i} = imread(i+".ppm");
end

[Mt2,numberOfImages,N]=background_model_based(images,false); % Set the parameter to 'true' to print the frames
dim=max(size(images));
u=zeros(dim,1);
v=zeros(dim,1);
set_subplot(800,600);
for i=1:dim-1
    [u,v]=TwoFramesLK(images{i},images{i+1},3,i,false);
    map=zeros(size(u,1),size(u,2));
    map=sqrt(u.*u+v.*v);
    subplot(2,2,3)
    imshow(map)
    title("Magnitude of the optical flow");
    subplot(2,2,4)
    imshow(uint8(Mt2(:,:,i)*255));
    title('Binary map');
    pause(0.05)
end
