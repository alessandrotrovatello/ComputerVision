%Lab2 of Computer Vision, Robotics Engineering cohort 2023/2024
%Curated by Ierardi Ambra, Scorrano Andrea, Trovatello Alessandro

%Include Functions
addpath('Include')

%Image reading
i235 = imread("i235.png","png");
tree = imread("tree.png","png");

%Print Original images and their histograms
print_original(i235,'i235',tree,'Tree'); % print_original(original_image1,'name_image1',original_image2,'name_image2')

%Cycle for plot different images
for i=1:2
    switch i
        case 1
            a = i235;
        case 2
            a = tree;
    end
% 1.Noises Addiction
    % Add Salt & Pepper and Gaussian noise and print relative histograms.
    [gauss,sp] = add_noise(a,0.2,20); % add_noise(original_image, noise_density, standard_deviation)

% 2.Remove Noises
    % Remove Gauss Noise by Moving Average Filter
    gauss_byavg3 = rm_byaveraging(gauss,3,'Gauss'); % rm_byaveraging(noisy_image, spatial_support, 'noise_name')
    gauss_byavg7 = rm_byaveraging(gauss,7,'Gauss'); 
    % Remove Gauss Noise by Low-pass Gaussian Filter
    gauss_bylpg3 = rm_lowpassgaussian(gauss,3,'Gauss'); % rm_lowpassgaussian(noisy_image, spatial_support, 'noise_name')
    gauss_bylpg7 = rm_lowpassgaussian(gauss,7,'Gauss'); 
    % Remove Gauss Noise by Median Filter
    gauss_bymdn3 = rm_median(a,gauss,3,'Gauss'); % rm_median(original_image, noisy_image, spatial_support, noise_name')
    gauss_bymdn7 = rm_median(a,gauss,7,'Gauss');
    % Remove Salt and Pepper Noise by Moving Average Filter
    sp_byavg3 = rm_byaveraging(sp,3,'Salt and Pepper'); % rm_byaveraging(noisy_image, spatial_support, noise_name)
    sp_byavg7 = rm_byaveraging(sp,7,'Salt and Pepper');
    % Remove Salt and Pepper Noise by Low-pass Gaussian Filter
    sp_bylpg3 = rm_lowpassgaussian(sp,3,'Salt and Pepper'); % rm_lowpassgaussian(noisy_image, spatial_support, noise_name)
    sp_bylpg7 = rm_lowpassgaussian(sp,7,'Salt and Pepper');
    % Remove Salt and Pepper Noise by Median Filter
    sp_bymdn3 = rm_median(a,sp,3,'Salt and Pepper'); % rm_median(original_image, noisy_image, spatial_support, noise_name)
    sp_bymdn7 = rm_median(a,sp,7,'Salt and Pepper');

% 3.Implement the slides 41-45 “practice with linear filters”:
    % Slide 41
    three = no_change(a,7); % no_change(original_image, spatial_support)
    % Slide 42
    three_right = shift_right(a,7); % shift_left(original_image, spatial_support)
    % Slide 43
    three_blur = blur_box(a,7); % blur_box(original_image, spatial_support)
    % Slide 44
    three_sharp = sharpening(a,7); % sharpening(original_image, spatial_support)
    % Slide 45
    image_details = details(a,three_blur); % details(original_image, noisy_image)
    sharpened = sharp(a,image_details,0.5); % sharp(original_image, details_image, a)

% 4.Apply the Fourier Transform (FFT) on the provided images:
    % Display the magnitude (log) of the transformed images
    fft1 = fft_image(a,'original image without'); % fft_image(input_fft, 'name_filter')
    % Display the magnitude of the transformed low-pass Gaussian filter (spatial support of 101x101 pixels with sigma=5)
    h = fspecial('gaussian', 101, 5); 
    fft2 = fft_image(h,'low-pass Gaussian'); % fft_image(input_fft, 'name_filter')
    % display the magnitude of the transformed sharpening filter, slide 44
    % (the filter has a spatial support of 7x7 pixels, copy it in the middle of a zeros image of 101x101 pixels)
    fft3 = fft_sharp_custom(a,7);
end




    
    
    



