% Lab6 of Computer Vision, Robotics Engineering cohort 2023/2024
% Curated by Ierardi Ambra, Scorrano Andrea, Trovatello Alessandro

clear
clc

addpath("Rubik\")
addpath("Mire\")

% load the points:

%P1=load("Rubik1.points");
%P2=load("Rubik2.points");

P1=load("Mire1.points");
P2=load("Mire2.points");
[size1, size2]=size(P1);
r=max([size1, size2]);

%image1=imread("Rubik1.pgm");
%image2=imread("Rubik2.pgm");

image1=imread("Mire1.pgm");
image2=imread("Mire2.pgm");

% transform P1 and P2 in a matrix with each point transformed with the
% homogeneous coordinates

P1_new=[P1,ones(r,1)];
P1=P1_new';
P2_new=[P2,ones(r,1)];
P2=P2_new';
% i punti (già trasposti) sono nella forma 3*N
[bestF, consensus, outliers] = ransacF(P1, P2, 0.001);
visualizeEpipolarLines(image1, image2, bestF, P1(1:2,:)', P2(1:2,:)');
%input di visual solo punti n*2!!!!!
%% Part 1:
%first point:

F_old=EightPointsAlgorithm(P1,P2);

%second point:

F_new=EightPointsAlgorithmN(P1,P2);

%third point:

% EVALUATION OF THE RESULTS, DA FARE

%% Part 2:

% load a pair of stereo images:

addpath("Rubik\")
%image1=imread("Rubik1.pgm");
%image2=imread("Rubik2.pgm");

addpath("Mire\")
image1=imread("Mire1.pgm");
image2=imread("Mire2.pgm");
% find matches:

image1_gray = im2gray(image1);
image2_gray = im2gray(image2);

%% Find Matches Function

M_NCC=findMatches(image1_gray,image2_gray,'NCC');
figure, showMatchedFeatures(image1,image2,M_NCC(:,1:2),M_NCC(:,3:4),"montage"), title('Matches between images computed by findMatches, NCC method')
M_SIFT=findMatches(image1_gray,image2_gray,'SIFT');
figure, showMatchedFeatures(image1,image2,M_SIFT(:,1:2),M_SIFT(:,3:4),"montage"), title('Matches between images computed by findMatches, SIFT method')

%% ransacF
l1=length(M_NCC);
M_NCC=[M_NCC,ones(l1,1)];
l2=length(M_SIFT);
M_SIFT=[M_SIFT,ones(l2,1)];
% i punti (già trasposti) sono nella forma 3*N
[bestF_NCC, consensus_NCC, outliers_NCC] = ransacF([M_NCC(:,1:2),ones(l1,1)]', M_NCC(:,3:5)', 0.9);
[bestF_SIFT, consensus_SIFT, outliers_SIFT] = ransacF([M_SIFT(:,1:2),ones(l2,1)]', M_SIFT(:,3:5)', 0.8);

%% Evaluation of the results: part 1

% EightPointsAlgorithm:

evaluation_not_norm=zeros(max(size(P1)),1);
for i=1:(max(size(P1)))
    evaluation_not_norm(i)=transpose(P2(:,i))*F_old*P1(:,i);
end

P1_new=P1';
P1_new=P1_new(:,1:2);
P2_new=P2';
P2_new=P2_new(:,1:2);
%nx2 vettori di punti

visualizeEpipolarLines(image1, image2, F_old, P1_new, P2_new), title('8-point algorithm - Not normalized points');
[U,W,V]=svd(F_old);
left_epipole_not_norm=U(:,end);
right_epipole_not_norm=V(:,end);
right_null1=right_epipole_not_norm'*F_old;
left_null1=F_old*left_epipole_not_norm;
% EightPointsAlgorithm:

evaluation_norm=zeros(max(size(P1)),1);
for i=1:(max(size(P1)))
    evaluation_norm(i)=P2(:,i)'*F_new*P1(:,i);
end


visualizeEpipolarLines(image1, image2, F_new, P1_new, P2_new), title('8-point algorithm - Normalized points');
[U,W,V]=svd(F_new);
left_epipole_norm=U(:,end);
right_epipole_norm=V(:,end);
right_null2=right_epipole_norm'*F_new;
left_null2=F_new*left_epipole_norm;

%% Evaluation of the results: part 2

% NCC:

evaluation_NCC=zeros(l1,1);
for i=1:l1
    evaluation_NCC(i)=M_NCC(i,3:5)*bestF_NCC*[M_NCC(i,1:2),1]';
end

visualizeEpipolarLines(image1, image2, bestF_NCC, M_NCC(:,1:2), M_NCC(:,3:4)), title('NCC with fmatrix computed by ransacF.m');
[U,W,V]=svd(bestF_NCC);
left_epipole_NCC=U(:,end);
right_epipole_NCC=V(:,end);
right_null3=right_epipole_NCC'*bestF_NCC;
left_null3=bestF_NCC*left_epipole_NCC;
% SIFT:

evaluation_SIFT=zeros(l2,1);
for i=1:l2
    evaluation_SIFT(i)=M_SIFT(i,3:5)*bestF_SIFT*[M_SIFT(i,1:2),1]';
end

visualizeEpipolarLines(image1, image2, bestF_SIFT, M_SIFT(:,1:2), M_SIFT(:,3:4)), title('SIFT with fmatrix computed by ransacF.m');
[U,W,V]=svd(bestF_SIFT);
left_epipole_SIFT=U(:,end);
right_epipole_SIFT=V(:,end);
right_null4=right_epipole_SIFT'*bestF_SIFT;
left_null4=bestF_SIFT*left_epipole_SIFT;

%% Alternative way to find matches and compute Ransac function: built-in MATLAB function.

%%% Match Features Function

% Detect features in both images
points1 = detectSURFFeatures(image1);
points2 = detectSURFFeatures(image2);

% Extract feature descriptors
[features1, valid_points1] = extractFeatures(image1, points1);
[features2, valid_points2] = extractFeatures(image2, points2);

% Match features using their descriptors
[indexPairs, matchmetric] = matchFeatures(features1, features2, "Unique", true);

% Retrieve locations of matched points
matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);

% Visualize the matching points
figure; showMatchedFeatures(image1, image2, matchedPoints1, matchedPoints2, 'montage');
title('Matches between images computed by built-in matlab functions');

P1 = [matchedPoints1.Location'; ones(1, size(matchedPoints1, 1))];
P2 = [matchedPoints2.Location'; ones(1, size(matchedPoints2, 1))];

P1_new=P1';
P1_new=P1_new(:,1:2);
P2_new=P2';
P2_new=P2_new(:,1:2);

%%% Ransac

% matchedPoints1 and matchedPoints2 are the matched points between two images
[fMatrix, inliersIndex] = estimateFundamentalMatrix(matchedPoints1, matchedPoints2, 'Method', 'RANSAC', 'NumTrials', 2000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);

visualizeEpipolarLines(image1, image2, fMatrix, P1_new, P2_new), title('Epipolar lines with fmatrix computed by estimateFundamentalMatrix.m');

% Now, fMatrix is the estimated fundamental matrix
% inliersIndex is a logical vector where element 'i' is set to true if point 'i' is an inlier

% You can then extract the inlier points like this:
inlierPoints1 = matchedPoints1(inliersIndex, :);
inlierPoints2 = matchedPoints2(inliersIndex, :);
