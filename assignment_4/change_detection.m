%% Task 1: work on the videosurveillance sequence using a simple background obtained as an 
% average between two empty frames

% load two empty images
B1 = double(rgb2gray(imread('EmptyScene01.jpg')));
B2 = double(rgb2gray(imread('EmptyScene02.jpg')));

% compute a simple background model
B = 0.5*(B1 + B2);

% load each image in the sequence, perform the change detection
% show the frame, the background and the binary map
% Observe how the results change as you vary the threshold

tau = 20;

addpath('Data\videosurveillance\');
elements_list = dir(fullfile('Data\videosurveillance\'));

numberOfImages = length(elements_list);
images = cell(1,numberOfImages-2); 

for i=1:numberOfImages-2
    images{i} = imread(i+".ppm");
end

for t = 1:numberOfImages-2
    
    %filename = sprintf('videosurveillance/frame%4.4d.jpg', t);
    It = images{t};
    Ig = rgb2gray(It);
    
    Mt = (abs(double(Ig) - B) > tau);
    
    subplot(1, 3, 1), imshow(It), title(['Frame ' num2str(t)]);
    subplot(1, 3, 2), imshow(uint8(B)), title(['Background model of frame ' num2str(t-1)]);
    subplot(1, 3, 3), imshow(uint8(Mt*255)), title('Binary map');
    pause(0.01)

end