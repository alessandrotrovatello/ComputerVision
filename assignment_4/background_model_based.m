%% Task 2: working again on the videosurveillance sequence, use now a background model based 

function [Mt,numberOfImages,N]=background_model_based()
% on running average to incorporate scene changes
 
%addpath('Data\videosurveillance\');
addpath('Data\stennis\');
%elements_list = dir(fullfile('Data\videosurveillance\'));
elements_list = dir(fullfile('Data\stennis\'));
numberOfImages = length(elements_list);
images = cell(1,numberOfImages-2);
 
for i=1:numberOfImages-2
    images{i} = imread(i+".ppm");
end
 
% Let's use the first N  frames to initialize the background
N = 5;
 
B = double(rgb2gray(images{1}));
 
for t = 2 : numberOfImages-2
    B = B + double(rgb2gray(images{t}));
end
 
B = B / N;
 
% Play with these parameters
TAU = 25;
ALPHA = 0.9;
TAU_prime = 0;
 
% Now start the change detection while updating the background with the
% running average. For that you have to set the values for TAU and ALPHA
 
Bprev = B;
for t = 1:numberOfImages-3
    
    It = images{t+1};
    Ig = rgb2gray(It);
    
    Mt = (abs(double(Ig) - Bprev) > TAU);
    
    % Implement the background update as a running average (SEE THE SLIDES)
 
    It_prev = images{t};
    Ig_prev = rgb2gray(It);
 
    Dt = abs(double(Ig) - double(Ig_prev));
    if(Dt > TAU_prime)
        Bt = Bprev;
    else
        Bt = (1-ALPHA) * Bprev + ALPHA * double(Ig);
    end
    %keyboard
    subplot(1, 3, 1), imshow(It);
    subplot(1, 3, 2), imshow(uint8(Bt));
    subplot(1, 3, 3), imshow(uint8(Mt*255));
    pause(0.1)
    Bprev = Bt;
    
end
end