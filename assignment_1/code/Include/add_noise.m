%Function for adding Salt e Pepper and Gaussian Noise to input image

function [gauss,sp] = add_noise(IN,noise_density,standard_deviation)
    % Salt and pepper 
    IN=double(IN);
    [rr,cc]=size(IN);
    maxv=max(max(IN));
    indices=full(sprand(rr,cc,noise_density)); 
    mask1=indices>0 & indices<0.5;  mask2=indices>=0.5;%matlab masking technique
    out= IN.*(~mask1) ;
    sp=out.*(~mask2)+maxv*mask2;
    
    figure()
    subplot(2,2,1)
    imagesc(sp),colormap gray
    title("Salt and Pepper Noise")
    %imagefilename="Report_Images/salt&pepper_noise"; % To save images
    %print(imagefilename,'-dpng');
    subplot(2,2,3)
    imhist(uint8(sp),256)
    title("Histogram of Salt and Pepper Noise")
    

    % Normal distribution
    gauss=double(IN)+standard_deviation*randn(size(IN));

    subplot(2,2,2)
    imagesc(gauss),colormap gray
    title("Gaussian Noise")
    %imagefilename="Report_Images/gaussian_noise"; % To save images
    %print(imagefilename,'-dpng');
    subplot(2,2,4)
    imhist(uint8(gauss),256)
    title("Histogram of Gaussian Noise")
   
end