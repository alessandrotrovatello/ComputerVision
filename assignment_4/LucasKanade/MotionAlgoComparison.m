clc
clear
close all

addpath("Code_and_images\Code_and_images\")
addpath("Data\Data\videosurveillance\")
% addpath("Data\Data\stennis\")
% addpath("Data\Data\sphere\")

%% optical flow:

directory = 'C:\Users\ambra\Documents\CV\lab7\optical_flow\optical_flow\Data\sphere';
% directory = 'C:\Users\ambra\Documents\CV\lab7\optical_flow\optical_flow\Data\videosurveillance';
% directory = 'C:\Users\ambra\Documents\CV\lab7\optical_flow\optical_flow\Data\stennis';

files = dir(fullfile(directory, '*.ppm'));

images = cell(1, numel(files));
percorso=cell(1,numel(files));
for i = 1:numel(files)
    percorso{i} = fullfile(directory, files(i).name);
    images{i} = imread(percorso{i});
    images{i}=rgb2gray(images{i});
end


dim=max(size(images));
u=zeros(dim,1);
v=zeros(dim,1);
for i=1:dim
    if i~=20
        [u,v]=TwoFramesLK(percorso{i},percorso{i+1},3);
        map=zeros(size(im1),dim);
        map=sqrt(u.*u+v.*v);
        figure
        subplot()
        imshow(map)
    end
end

%% running average:
% [Mt1,FIRST_IDX1, LAST_IDX1]=change_detection();
[Mt2,FIRST_IDX2, LAST_IDX2,N]=background_model_based();
% figure
% for t = FIRST_IDX1 : LAST_IDX1
%     imshow(uint8(Mt1*255));
%     pause(0.1)
% end
figure
for t = FIRST_IDX2+N : LAST_IDX2
    imshow(uint8(Mt2*255));
    pause(0.1)
end