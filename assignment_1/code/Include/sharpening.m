%Compute Sharpening Filter

function new_in = sharpening(IN,spatial_support)
    %Create the zero matrix with only one in the center
    matrix1 = zeros(spatial_support);
    matrix2 = zeros(spatial_support);
    center_x = floor(size(matrix1, 2) / 2) + 1;
    center_y = floor(size(matrix1, 1) / 2) + 1;
    matrix1(center_y, center_x) = 1;
    matrix2(center_y, center_x) = 1;

    matrix_ones = ones(spatial_support)/(spatial_support^2);
    
    filter = (matrix1+matrix2)-matrix_ones;

    new_in = conv2(IN,filter,'same');
    
    figure()
    subplot(2,2,1)
    imagesc(IN)
    title('Original image')
    colormap gray

    subplot(2,2,2)
    imagesc(new_in)
    title('Image Filtered')
    colormap gray

    subplot(2,2,3)
    imagesc(filter)
    title('Filter Imagesc')
    colormap gray

    subplot(2,2,4)
    surf(filter)
    title('Filter Surface')

    sgtitle('Sharpening filter')

end