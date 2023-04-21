function [aRatio, min_row, min_col, height, width] = computeAspectRatio(image)
    %[num_rows, num_cols] = size(image);

    % Fill your code
    sum_row = sum(image,2); %array containing the sum of the values of each row of the image
    sum_col = sum(image,1); %array containing the sum of the values of each col of the image

    % Now we will find the index of the first and last nonzero element of sum_row and sum_col

    min_row = find(sum_row, 1); %index of first nonzero element of the rows
    max_row = find(sum_row, 1, 'last'); %index of last nonzero element of the rows

    min_col = find(sum_col, 1);
    max_col = find(sum_col, 1, 'last');

    height = max_row - min_row + 1;
    width = max_col - min_col + 1;

    aRatio = width/height;

end

