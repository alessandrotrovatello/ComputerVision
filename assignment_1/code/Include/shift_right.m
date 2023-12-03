%Compute Shift Right

function new_in = shift_right(IN,spatial_support)
    matrix = zeros(spatial_support);
    board_x = size(matrix,2);
    center_y =  floor(size(matrix, 1) / 2) + 1;
    matrix(center_y, board_x) = 1;
    
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

    sgtitle('Shift right')
end