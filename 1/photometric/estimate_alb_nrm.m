function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, n] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array    
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for i1 = 1:h
    for j1 = 1:w
        i = reshape(image_stack(i1,j1,:),[n,1]);
        if shadow_trick == false
            [g,~] = linsolve(scriptV,i);
            albedo(i1,j1) = norm(g);
            normal(i1,j1,:) = g / albedo(i1,j1);
        else
            I = diag(i);
            A = I*scriptV;
            B = I*i;
            [g,~] =  linsolve(A,B);
            albedo(i1,j1) = norm(g);
            normal(i1,j1,:) = g / albedo(i1,j1);        
        end         
    end      
end



% =========================================================================

end

