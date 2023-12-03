%Moltiply the input image by an Impulse Filter

function new_in = no_change(IN,spatial_support)
    %Create the zero matrix with only one in the center
    matrix = zeros(spatial_support);
    center_x = floor(size(matrix, 2) / 2) + 1;
    center_y = floor(size(matrix, 1) / 2) + 1;
    matrix(center_y, center_x) = 1;
    
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

    sgtitle('Image moltiplied for an Impulse')
end
   
