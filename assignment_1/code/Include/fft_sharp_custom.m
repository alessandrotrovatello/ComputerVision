%Get the Magnitude of the transformed (FFT) Sharpening Filter

function new_in = fft_sharp_custom(IN,spatial_support)
    matrix1 = zeros(spatial_support);
    matrix2 = zeros(spatial_support);
    center = floor(size(matrix1) / 2) + 1;
    matrix1(center, center) = 1;
    matrix2(center, center) = 1;

    matrix_ones = ones(spatial_support)/(spatial_support^2);
    
    filter = (matrix1+matrix2)-matrix_ones;

    zero = zeros(101);
    center = floor(size(zero) / 2) + 1;
    zero(center-3:center+3,center-3:center+3) = filter;

    new_in = conv2(IN,zero,'same');

    img = fft2(zero);
    mod = abs(img);

    figure()
    subplot(2,2,1)
    imagesc(IN), colormap gray,title('Original image'),axis square
    
    subplot(2,2,2)
    imagesc(new_in), colormap gray,title('Sharpened filtered image'),axis square

    subplot(2,2,4)
    imagesc(log(fftshift(mod))), colormap gray,title('Magnitude (log) of FFT of Sharpened filtered image'),xlabel('wx'),ylabel('wy'),axis square
    %imagefilename="Report_Images/magnitude_sharpened_filter"; % To save images
    %print(imagefilename,'-dpng');
    sgtitle('Display the magnitude of the transformed sharpening filter, slide 44')
end