function G = gauss2D( sigma , kernel_size )
    %% solution
    x = kernel_size(1)
    y = kernel_size(2)
    G = gauss1D(sigma,x).'*gauss1D(sigma,y);
end
