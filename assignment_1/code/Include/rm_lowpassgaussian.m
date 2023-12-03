%Remove noise by low-pass Gaussian filter

function out = rm_lowpassgaussian(IN,fsize,noisy_name)
    sigma = (fsize/2)/3;
    h = fspecial('gaussian', fsize, sigma);
	out = imfilter(IN, h);

    figure()
    sgtitle({['Remove ',noisy_name,' noise with Low-Pass Gaussian Filter'],['Spatial support: ',num2str(fsize),'x',num2str(fsize),' sigma: ',num2str(sigma)]});
    subplot(2,2,1)
    imagesc(IN),colormap gray,title([noisy_name,' noisy image'])

    subplot(2,2,2)
    imagesc(out),colormap gray,title('Low-pass Gaussian filter')
    %imagefilename="Report_Images/gauss_rm_lowpass"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,3)
    imagesc(h),colormap gray,title('Low-pass Gaussian Filter imagesc')

    subplot(2,2,4)
    surf(h),colormap gray,title('Low-pass Gaussian Filter surface')
end