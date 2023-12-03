function  harrisCornerDetector(tmp)
    
    I=double(tmp); % convert image to double
    figure,imagesc(I),colormap gray % show the images
    
    % compute x and y derivative of the image
    dx=[1 0 -1; 2 0 -2; 1 0 -1]; 
    dy=[1 2 1; 0  0  0; -1 -2 -1];
    Ix=conv2(I,dx,'same');
    Iy=conv2(I,dy,'same');
    figure,imagesc(Ix),colormap gray,title('Ix')
    figure,imagesc(Iy),colormap gray,title('Iy')


    % compute products of derivatives at every pixel
    Ix2=Ix.*Ix; Iy2=Iy.*Iy; Ixy=Ix.*Iy;
    
    % compute the sum of products of  derivatives at each pixel
    g = fspecial('gaussian', 9, 1.2);
    figure,imagesc(g),colormap gray,title('Gaussian')
    Sx2=conv2(Ix2,g,'same'); Sy2=conv2(Iy2,g,'same'); Sxy=conv2(Ixy,g,'same');
    
    % features detection
    [rr,cc]=size(Sx2);
    corner_reg=zeros(rr,cc);
    R_map=zeros(rr,cc);
    k=0.05;
    
    % create R map
    for ii=1:rr
        for jj=1:cc
            % define at each pixel x,y the matrix
            M=[Sx2(ii,jj),Sxy(ii,jj);Sxy(ii,jj),Sy2(ii,jj)];
            % compute the response of the detector at each pixel
            R=det(M) - k*(trace(M).^2);
            R_map(ii,jj)=R;
        end
    end

    % set threshold like 0.3*M where M is the max of the R map
    threshold=0.3*max(max(R_map));
    figure,imagesc(R_map),colormap jet,title('R map')

    for ii=1:rr
        for jj=1:cc
            % define at each pixel x,y the matrix
            M=[Sx2(ii,jj),Sxy(ii,jj);Sxy(ii,jj),Sy2(ii,jj)];
            % compute the response of the detector at each pixel
            R=det(M) - k*(trace(M).^2);
            R_map(ii,jj)=R;
            % threshold on value of R
            if R>threshold
                corner_reg(ii,jj)=1;
            end
        end
    end

    
    figure,imagesc(corner_reg),colormap gray,title('corner object') % show the corner region in white
    
    figure1=figure,imagesc(tmp),colormap gray,title('corner'); % show the image 
    
    prop=regionprops(corner_reg>0,'Centroid'); % create a vector with all the white region props
    hold on;
    for n=1:numel(prop)
        plot(prop(n).Centroid(1),prop(n).Centroid(2),'r*'); hold on % add the corner on the image
    end

    %saveas(figure1,"corners.png") % save the figure


end

