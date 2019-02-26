function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        kernel_size = varargin{1};
        imOut = imboxfilt(image,kernel_size);
    case 'median'
        m = varargin{1};
        n = varargin{2};
        imOut = medfilt2(image,[m,n]);
    case 'gaussian'
        sigma = varargin{1};
        kernel_size = varargin{2};
        kernel = gauss2D(sigma,kernel_size);
        imOut = imfilter(image,kernel,'conv');
end
end
