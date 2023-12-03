%Remove noise by median filter

function out = rm_median(original,IN,spatial_support,noisy_name)
    out=medfilt2(IN,[spatial_support,spatial_support]);

    figure()
    sgtitle({['Remove ',noisy_name,' noise with Median Filter'],['Spatial support: ',num2str(spatial_support)]});
    subplot(2,2,1)
    imagesc(original),colormap gray,title('Original image')

    subplot(2,2,2)
    imagesc(IN),colormap gray,title([noisy_name,' noisy image'])

    subplot(2,2,3)
    imagesc(out),colormap gray,title('Image filtered imagesc')
    %imagefilename="Report_Images/gauss_rm_median"; % To save images
    %print(imagefilename,'-dpng');
end
  
