function [list] = findMatches(img1, img2, type)


% extract SIFTs from both images
% f1_all and f2_all contain the keypoints positions 
% d1_all and d2_all contain the sift descriptors 

points1 = detectSIFTFeatures(img1);
f1_all = points1.Location; %find points' location
d1_all = extractFeatures(img1,points1,Method="SIFT"); %find interesting points

points2 = detectSIFTFeatures(img2);
f2_all = points2.Location;
d2_all = extractFeatures(img2,points2,Method="SIFT");


f1_all = f1_all';
f2_all = f2_all';
d1_all = d1_all';
d2_all = d2_all';

% Eliminating features too close to borders (where the patch would partially fall outside the image)
delta = 10;
idx = f1_all(1,:) > delta & f1_all(1,:) < size(img1,2)-delta & f1_all(2,:) > delta & ...
    f1_all(2,:) < size(img1,1)-delta;
F1 = f1_all(:,idx);
D1 = d1_all(:,idx);

idx = f2_all(1,:) > delta & f2_all(1,:) < size(img2,2)-delta & f2_all(2,:) > delta & ...
    f2_all(2,:) < size(img2,1)-delta;
F2 = f2_all(:,idx);
D2 = d2_all(:,idx);


figure(1);
imshow(img1),hold on;
plot(F1(1,:), F1(2,:), '*');

figure(2);
imshow(img2),hold on;
plot(F2(1,:), F2(2,:), '*');

% From now on, we use F1, D1 and F2, D2

if(strcmp(type, 'NCC'))
    
    %% MATCHING CONSIDERING EUCLIDEAN DISTANCE BETWEEN POSITIONS AND PATCHES SIMILARITY

    % SET SIGMA (for the euclidean distance contribution) TO AN APPROPRIATE
    % VALUE
    sigma = 5;                                                                 %PLAY WITH SIGMA AND DELTA
    % SET THE PATCH SIZE (for the NCC contribution) TO AN APPROPRIATE VALUE 
    % (delta is half the size of the patch, i.e. if delta=2 the patch is 5x5)
    delta = 5; 

    % Initialize the affinity matrix
    A = zeros(size(F1,2), size(F2, 2));

    % Build the affinity matrix
    for i = 1 : size(F1,2)

        % select the patch around the keypoint
        Qi = img1(round(F1(2,i))-delta:round(F1(2,i))+delta, round(F1(1,i))-delta:round(F1(1,i))+delta);

        for j = 1 : size(F2,2)

            % select the patch around the keypoint
            Qj = img2(round(F2(2,j))-delta:round(F2(2,j))+delta, round(F2(1,j))-delta:round(F2(1,j))+delta);  

            A(i,j) = similarity('NCC', F1(:, i)', F2(:, j)', Qi, Qj, sigma);

        end
    end

    % Enhancing good matches with SVD
    [U, D, V] = svd(A);
    I = eye(size(D));
    A1 = U*I*V';

    % Detecting good matches
    list = [];

    for i = 1 : size(A1, 1)

        [maxvali, j] = max(A1(i,:));
        [maxvalj, k] = max(A1(:,j));

        if(k==i && maxvali >= 0.85) % IF YOU WANT TO CONSIDER A THRESHOLD ADD A CONDITION: && maxvali >= THRESH
            list = [list; F1(2:-1:1,i)' F2(2:-1:1,j)'];
        end
    end

elseif(strcmp(type,'SIFT'))


    %% MATCHING USING SIFT DESCRIPTORS

    % SET THE SIGMA TO AN APPROPRIATE VALUE (notice this time it refers to the
    % comparison of vectors, thus it can not be interpreted in pixels)
    sigma = 0.1;                                                            %PLAY WITH SIGMA AND DELTA

    A = zeros(size(D1, 2), size(D2, 2));

    for i = 1 : size(A, 1)
        for j = 1 : size(A, 2)
            A(i,j) = similarity('SIFT', D1(:, i), D2(:, j), 0, 0, 0);

        end
    end

    A = exp(-A/(2*(sigma^2))); %faccio qui la similarity, non in similarity.m

    % Enhancing good matches with SVD
    [U, D, V] = svd(A);
    I = eye(size(D));
    A1 = U*I*V';

    % Detecting good matches
    list = [];

    for i = 1 : size(A1, 1)

        [maxvali, j] = max(A1(i,:));
        [maxvalj, k] = max(A1(:,j));

        if(k==i && maxvali >= 0.95) % if you want to consider a threshold add a condition && maxvali >= THRESH
            list = [list; F1(2:-1:1,i)' F2(2:-1:1,j)'];
        end
    end

    
end
