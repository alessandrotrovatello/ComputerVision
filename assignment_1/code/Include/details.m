%Get the details of an image by subtracting the original image for its smooth image

function new_in = details(IN,smoothed)
    new_in = double(IN) - smoothed;

    figure()
    subplot(2,2,1)
    imagesc(IN)
    title('Original')
    colormap gray

    subplot(2,2,2)
    imagesc(smoothed),title('Image Filtered with Blur')
    colormap gray
    %imagefilename="Report_Images/smoothed"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,3)
    imagesc(new_in),title('Image Details')
    colormap gray
    %imagefilename="Report_Images/details"; % To save images
    %print(imagefilename,'-dpng');

    sgtitle('Original - Smoothed = Details')
end