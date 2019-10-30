function [img] = drawGAImage(chromozon, imageSizeX, imageSizeY, circlesNum)
    % init blank image
    
    img = uint8(zeros(imageSizeX, imageSizeY));
    
    % add circles
    for i = 1: circlesNum
        img = addCircle(img, imageSizeX, imageSizeY, ...
                             chromozon(i), ...
                             chromozon(i + circlesNum), ...
                             chromozon(i + 2*circlesNum), ...
                             chromozon(i + 3*circlesNum));
    end
end

