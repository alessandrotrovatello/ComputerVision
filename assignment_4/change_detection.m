%% Task 1: work on the videosurveillance sequence using a simple background obtained as an 
% average between two empty frames

change_detection()
% load two empty images
B1 = double(rgb2gray(imread('EmptyScene01.jpg')));
B2 = double(rgb2gray(imread('EmptyScene02.jpg')));

% compute a simple background model
B = 0.5*(B1 + B2);

% load each image in the sequence, perform the change detection
% show the frame, the background and the binary map
% Observe how the results change as you vary the threshold

tau = 20;

FIRST_IDX = 250; %index of first image
LAST_IDX = 320; % index of last image

for t = FIRST_IDX : LAST_IDX
    
    filename = sprintf('videosurveillance/frame%4.4d.jpg', t);
    It = imread(filename);
    Ig = rgb2gray(It);
    
    Mt = (abs(double(Ig) - B) > tau);
    
    subplot(1, 3, 1), imshow(It);
    subplot(1, 3, 2), imshow(uint8(B));
    subplot(1, 3, 3), imshow(uint8(Mt*255));
    pause(0.01)

end
%% Task 2: working again on the videosurveillance sequence, use now a background model based 
% on running average to incorporate scene changes

FIRST_IDX = 250; %index of first image
LAST_IDX = 320; % index of last image

% Let's use the first N  frames to initialize the background
N = 5;

filename = sprintf('Data/Data/videosurveillance/frame%4.4d.jpg', FIRST_IDX);
B = double(rgb2gray(imread(filename)));
for t = FIRST_IDX+1 : FIRST_IDX + N-1
    
    filename = sprintf('Data/Data/videosurveillance/frame%4.4d.jpg', t);
    B = B + double(rgb2gray(imread(filename)));
    
end

B = B / N;

% Play with these parameters
TAU = 25; 
ALPHA = 0.9;
TAU_prime = 10;

% Now start the change detection while updating the background with the
% running average. For that you have to set the values for TAU and ALPHA

Bprev = B;
for t = FIRST_IDX+N : LAST_IDX
    
    filename = sprintf('Data/Data/videosurveillance/frame%4.4d.jpg', t);
    
    It = imread(filename);
    Ig = rgb2gray(It);
    
    Mt = (abs(double(Ig) - Bprev) > TAU_prime);
    
    % Implement the background update as a running average (SEE THE SLIDES)
    filename_prev = sprintf('Data/Data/videosurveillance/frame%4.4d.jpg', t-1);

    It_prev = imread(filename_prev);
    Ig_prev = rgb2gray(It);

    Dt = abs(double(Ig) - double(Ig_prev));
    if(Dt > TAU)
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