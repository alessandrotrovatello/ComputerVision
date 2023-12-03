%Print Original image with Histogram

function void = print_original(img1,name_img1,img2,name_img2)

    figure()
    subplot(2,2,1)
    imagesc(img1),colormap gray
    title([name_img1,' image'])
    %imagefilename="Report_Images/i235"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,3)
    imhist(uint8(img1),256)
    title(['Histogram of ',name_img1,' image'])
    %imagefilename="Report_Images/i235_histogram"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,2)
    imagesc(img2),colormap gray
    title([name_img2,' image'])

    subplot(2,2,4)
    imhist(uint8(img2),256)
    title(['Histogram of ',name_img2,' image'])

    sgtitle('Display lab images with their histograms')
end