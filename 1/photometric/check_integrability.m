function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives
[h,w,n] = size(normals);
% initalization
p = zeros([h,w]);
q = zeros([h,w]);
SE = zeros([h,w]);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

p = normals(:,:,1) ./ normals(:,:,3);
q = normals(:,:,2) ./ normals(:,:,3);        



% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;




% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

      
p1 = diff(p,1,2);
q1 = diff(q,1,1);
p1(:,w) = 0;
q1(h,:) = 0;
SE = (p1 - q1) .^ 2;       



% ========================================================================




end

