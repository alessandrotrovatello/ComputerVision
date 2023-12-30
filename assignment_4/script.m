clc
clear
close all


%addpath('Data\sflowg\'); elements_list = dir(fullfile('Data\sflowg\'));
addpath('Data\sphere\'); elements_list = dir(fullfile('Data\sphere\'));
%addpath('Data\statua\'); elements_list = dir(fullfile('Data\statua\'));
%addpath('Data\stennis\'); elements_list = dir(fullfile('Data\stennis\'));
%addpath('Data\videosurveillance\'); elements_list = dir(fullfile('Data\videosurveillance\'));

numberOfImages = length(elements_list);
images = cell(1,numberOfImages-2); 

for i=1:numberOfImages-2
    images{i} = imread(i+".ppm");
end

for i=1:numberOfImages-3
    TwoFramesLK(images{i},images{i+1},3);
end
