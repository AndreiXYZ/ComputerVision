function G = gauss2D( sigma , kernel_size )
    %% solution
    x = kernel_size(1)
    y = kernel_size(2)
    G = gauss1D(sigma,x).'*gauss1D(sigma,y);
    figure;
    subplot(111);
    imshow(G);
end
