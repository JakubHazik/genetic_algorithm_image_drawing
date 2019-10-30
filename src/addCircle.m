function [image] = addCircle(image, imageSizeX, imageSizeY, x_pos, y_pos, radius, color)
    w = 5;
    [columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
    circlePixels = ((rowsInImage - y_pos).^2 + (columnsInImage - x_pos).^2 <= radius^2) .* color;
    % imshow(circlePixels, [0 256]);
    circlePixels = conv2(double(circlePixels(:,:)), ones(2*w+1)/(2*w+1)^2, 'same');
    image = image + uint8(circlePixels);
end

