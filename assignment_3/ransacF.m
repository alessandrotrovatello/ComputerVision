function [bestF, consensus, outliers] = ransacF(P1, P2, th)
    
    % note: P1 and P2 must be in homogeneous coordinates, one point in each
    % column
    ii = 0;
    iter = 100;
    N = size(P1, 2);

    bestF = zeros(3, 3);
    bestNInlier = 0;
    p = 0.999;

    consensus = [];
    outliers = [];

    while ii < iter 
        perm = randperm(N);
        P1iter = P1(:, perm(1:8)); % select 8 random pairs
        P2iter = P2(:, perm(1:8)); % select 8 random pairs

        F = EightPointsAlgorithmN(P1iter, P2iter);

        residuals = testF(F, P1, P2); % <--  THIS IS A FUNCTION YOU NEED TO IMPLEMENT, SEE BELOW!

        nInlier = sum(residuals < th) / N; % current estimated inliers
        
        if(nInlier > bestNInlier) % if number of inliers grows
           bestNInlier = nInlier; % update of the fly the probability of having inliers
           bestF = F; % update the best homography
           consensus = [P1(:, residuals < th); P2(:, residuals < th)]; % inliers
           outliers = [P1(:, residuals >= th); P2(:, residuals >= th)]; % outliers
           iter = log(1 - p) / log(1 - bestNInlier.^4); % update the number of iterations needed
        end

        ii = ii + 1;
    end  
end


function [residual] = testF(F, P1, P2)
   residual=zeros(max(size(P1)),1);
   for i=1:(max(size(P1)))
       residual(i)=abs(P2(:,i)'*F*P1(:,i));
   end
end