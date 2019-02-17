function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        for i=2:h
             height_map(i,1) = height_map(i-1,1)+q(i,1); 
        end          
        
       
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        for i=1:h
            for j =2:w                
                height_map(i,j) = height_map(i,j-1)+p(i,j); 
            end
        end
        

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        for j=2:w
             height_map(1,j) = height_map(1,j-1)+p(1,j); 
        end          
        
        for j=1:w
            for i =2:h                
                height_map(i,j) = height_map(i-1,j)+q(i,j); 
            end
        end
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map_column = zeros(h, w);
        height_map_row = zeros(h, w);        
        % COLUMN
        for i=2:h
             height_map_column(i,1) = height_map_column(i-1,1)+q(i,1); 
        end      
        for i=1:h
            for j =2:w                
                height_map_column(i,j) = height_map_column(i,j-1)+p(i,j); 
            end
        end
        % ROW
        for j=2:w
             height_map_row(1,j) = height_map_row(1,j-1)+p(1,j); 
        end       
        for j=1:w
            for i =2:h                
                height_map_row(i,j) = height_map_row(i-1,j)+q(i,j); 
            end
        end
        % AVERAGE
        height_map = (height_map_column + height_map_row) ./ 2;        
        
        % =================================================================
end


end

