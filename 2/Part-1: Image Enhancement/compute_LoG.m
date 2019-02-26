function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        imOut = imfilter(image, fspecial('gaussian',5,0.5),'conv');
        imOut = imfilter(imOut, fspecial('laplacian'),'conv');
    case 2
        imOut = imfilter(image, fspecial('log', 5, 0.5), 'conv');

    case 3
        imOut = imfilter(double(image), fspecial('gaussian',5, 1),'conv')...
            - imfilter(double(image), fspecial('gaussian',5, 0.8),'conv');

end
end

