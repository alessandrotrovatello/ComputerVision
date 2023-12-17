function [] = visualizeEpipolarLines(Im1, Im2, F, pt1, pt2)

% function [] = visualizeEpipolarLines(Im1, Im2, F, pt1, pt2)
% ** When pt1 = pt2 = [] the user can select a point from one of the two
%    image. The corresponding epipolar line is computed using F and visualized on the
%    other image. To quit, just click outside of the image boundaries.
% ** When pt1 ~= [] AND pt2 ~= [] then they are considered as
%    corresponding points on the images. The epipolar lines are computed and
%    visualized.

I = [Im1 Im2];

figure, imshow(I), hold on;

if(size(pt1,1)==0 || size(pt2,1)==0)

    cnt = true;

    while(cnt)

        [x y] = ginput(1);
        % To visualize one point at a time uncomment the following line
        %figure(1), imshow(I), hold on;

        if(x>=1 && x <= size(I, 2) && y >= 1 && y <= size(I, 1))

            color = [rand rand rand];
            plot([x], [y], 's', 'Color', color); % showing the selected point

            % infer the image from which the point has been selected
            if(x <= size(Im1, 2))
                disp(sprintf('Point (%d,%d) has been selected from left image ...', round(x), round(y)));

                % applying F
                L = F*[x y 1]';

                xv = [1:size(Im2,2)];
                yv = -L(1)/L(2)*xv -L(3)/L(2);

                plot(xv+size(Im2,2), yv, '-', 'Color', color);

            else
                disp(sprintf('Point (%d,%d) has been selected from right image ...', round(x-size(Im1,2)), round(y)));

                % applying F'
                L = F'*[x-size(Im1,2) y 1]';

                xv = [1:size(Im1,2)];
                yv = -L(1)/L(2)*xv -L(3)/L(2);

                plot(xv, yv, '-', 'Color', color);
            end

        else
            disp('Quit.');
            cnt = false;
        end

    end
else
    
    colors = zeros(size(pt1,1), 3);
    for i = 1 : size(pt1,1)
        colors(i,:) = [rand rand rand];
    end
    
    for i = 1 : size(pt1,1)
        
        % points from image 1
        plot([pt1(i,1)], [pt1(i,2)], 's', 'Color', colors(i,:));
        L = F*[pt1(i,1) pt1(i,2) 1]';
        xv = [1:size(Im2,2)];
        yv = -L(1)/L(2)*xv -L(3)/L(2);
        plot(xv+size(Im2,2), yv, '-', 'Color', colors(i,:));
        
        % points from image 2
        plot([pt2(i,1)+size(Im1,2)], [pt2(i,2)], 's', 'Color', colors(i,:));
        L = F'*[pt2(i,1) pt2(i,2) 1]';
        xv = [1:size(Im1,2)];
        yv = -L(1)/L(2)*xv -L(3)/L(2);
        plot(xv, yv, '-', 'Color', colors(i,:));
        
    end
    
end