global imageSizeX imageSizeY circlesNum

imageSizeX = 400;
imageSizeY = 400;
circlesNum = 10;
maxCircleRadius = 100;
maxColorVal = 256;


%% read original image
original = imread('foto.JPG');
original = imresize(original, [imageSizeY imageSizeX]);
original = rgb2gray(original);
figure
% imshow(original);

%% ga

popSize = 50;              %velkost populacie
stringLength = 3;
bestPopSelection=[1 1 1 1 1 1 1 1 1 1]; %vektor definujuci vyber najlepsich retazcov
space = [
    zeros(1, circlesNum),               zeros(1, circlesNum),               zeros(1, circlesNum),                   zeros(1, circlesNum);
    ones(1, circlesNum) * imageSizeX,   ones(1, circlesNum) * imageSizeY,   ones(1, circlesNum) * maxCircleRadius   ones(1, circlesNum) * maxColorVal
];

amps=space(2,:) * 0.02;       %aditivna mutacia;
pop=genrpop(popSize, space);

fit = computeFitness(pop, imageSizeX, imageSizeY, circlesNum)

% img = drawGAImage(pop(1, :));
% figure
% imshow(img, [0 256])
    
