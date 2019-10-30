function [fit] = computeFitness(originalImg, pop, imageSizeX, imageSizeY, circlesNum)

    % read original image
%     original = imread('fotoCustom.jpg');
%     original = imresize(original, [imageSizeY imageSizeX]);
%     original = rgb2gray(original);
    % figure
    % imshow(original);
    
    n = length(pop(:,1));
    fit = zeros(1, n);

    parfor i = 1:n
        img = drawGAImage(pop(i, :), imageSizeX, imageSizeY, circlesNum);
        result = imabsdiff(originalImg, img);
        fit(i) = sum(sum(result));
    end
end

