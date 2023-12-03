%Compute Fourier Transform on input image and plot its Magnitude

function img = fft_image(IN,name_filter)
    img = fft2(IN);
    mod = abs(img);

    figure()
    subplot(2,2,1)
    imagesc(IN)
    title('Input of FFT')
    axis square
    colormap gray

    subplot(2,2,2)
    imagesc(log(fftshift(mod)))
    title('Magnitude (log) of the FFT of the input')
    xlabel('wx'),ylabel('wy')
    axis square
    colormap gray
    %imagefilename="Report_Images/magnitude_original"; % To save images
    %print(imagefilename,'-dpng');

    sgtitle(['Display the magnitude of the transformed ',name_filter,' filter'])
end