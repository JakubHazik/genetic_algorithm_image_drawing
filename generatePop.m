function [pop] = generatePop(originalImg, popSize, circlesNum, space)

imageSizeX = length(originalImg(1,:));
imageSizeY = length(originalImg(:,1));
pop = zeros(popSize, circlesNum * 4);

for i=1:popSize
    gen = zeros(1, circlesNum * 4);
    generated = uint8(zeros(imageSizeY,imageSizeX));
    
    for j = 1:circlesNum        
        % find circle position
        diff = originalImg - generated;
        maxVal = max(max(diff));
        [x, y] = find(diff==maxVal);
        % find radius
        minRadisu = space(1, circlesNum * 2 + 1);
        maxRadius = space(2, circlesNum * 2 + 1);
        radius = randi([minRadisu maxRadius]) / 1.3;
        % find color
        color = double(maxVal/5);
        % add circle
        generated = addCircle(generated, imageSizeX, imageSizeY, x(1), y(1), radius, color);  
        
        % write to gen
        gen(j) = x(1);
        gen(j + circlesNum) = y(1);
        gen(j + 2*circlesNum) = radius;
        gen(j + 3*circlesNum) = color;
    end
    
%     diff = originalImg - generated;
%     figure(1);
%     imshow(diff);
%     title('diff')
%     
%     absDiff = imabsdiff(  originalImg,generated);
%     figure(2);
%     imshow(absDiff);
%     title('Absdiff')
%     
%     figure(3);
%     imshow(generated)
%     title('Generated')

    pop(i, :) = gen;
end

%  
% diff = originalImg - generated;
% figure(1);
% imshow(diff);
% title('diff')
% 
% absDiff = imabsdiff(  originalImg,generated);
% figure(2);
% imshow(absDiff);
% title('Absdiff')
% 
% figure(3);
% imshow(generated)
% title('Generated')
% 
% img = drawGAImage(gen, imageSizeX, imageSizeY, circlesNum);
% figure(4);
% imshow(img)
% title('Fitness')


end
