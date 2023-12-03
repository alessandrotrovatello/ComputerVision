%Get Blurred Image by applying a Box Filter

function new_in = blur_box(IN,spatial_support)
    matrix = ones(spatial_support)/(spatial_support^2);
    new_in = conv2(IN,matrix,'same');

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
    imagesc(matrix)
    title('Filter Imagesc')
    colormap gray

    subplot(2,2,4)
    surf(matrix)
    title('Filter Surface')

    sgtitle('Blurred with a box filter')
end