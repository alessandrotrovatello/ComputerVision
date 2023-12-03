%Remove noise by smoothing by averaging

function out = rm_byaveraging(IN,spatial_support,noisy_name)
    K=ones(spatial_support)/(spatial_support^2);
    out=conv2(IN,K,'same');

    figure()
    sgtitle({['Remove ',noisy_name,' noise with Smoothing by averaging Filter'],['Spatial support: ',num2str(spatial_support),'x',num2str(spatial_support)]});
    subplot(2,2,1)
    imagesc(IN),colormap gray,title([noisy_name,' noisy Image'])

    subplot(2,2,2)
    imagesc(out),colormap gray,title(['Smoothing by averaging ',noisy_name,' noise'])
    %imagefilename="Report_Images/gauss_rm_byavg"; % To save images
    %print(imagefilename,'-dpng');

    subplot(2,2,3)
    imagesc(K),colormap gray,title('Smoothing by averaging filter imagesc')

    subplot(2,2,4)
    surf(K),colormap gray,title('Smoothing by averaging filter surface')
end