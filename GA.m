% clear;
close all;

global popSize
global space
global amps
global bestPopSelection
global imageSizeX imageSizeY circlesNum

% image params
circlesNum = 70;
imageSizeX = 150;
imageSizeY = 150;
maxCircleRadius = 40;
maxColorVal = 50;
% read img
originalImg = imread('fotoCustom.jpg');
originalImg = imresize(originalImg, [imageSizeY imageSizeX]);
% figure;
% imshow(originalImg);
% title('Original image')

% GA params
iterationsNum = 1;
generationsNum=500;        %pocet generacii/ pokusov
popSize = 80;              %velkost populacie
bestPopSelection=ones(1, 12); %vektor definujuci vyber najlepsich retazcov
space = [
    zeros(1, circlesNum),               zeros(1, circlesNum),               zeros(1, circlesNum),                   zeros(1, circlesNum);
    ones(1, circlesNum) * imageSizeX,   ones(1, circlesNum) * imageSizeY,   ones(1, circlesNum) * maxCircleRadius   ones(1, circlesNum) * maxColorVal
];
amps=space(2,:) * 0.02;       %aditivna mutacia;
course=zeros(1, generationsNum);    %inicializacia pola pre uchovanie priebehu, aby sa nemusela v kazdom kroku menit velkost vektora

% pop = generatePop(originalImg, popSize, circlesNum, space);
% %%

for j=1:iterationsNum
    %vygenerovanie novej generacie
%     pop=genrpop(popSize,space);
    pop = generatePop(originalImg, popSize, circlesNum, space);
    pop = change(pop, 2, space);
    
    %vytvorenie vektora s fitnesom(funkcnej hodnoty)d pre kazdy retazec
    fit = computeFitness(originalImg, pop, imageSizeX, imageSizeY, circlesNum);
    
    for i=1:generationsNum  %kym nenajde minimum funkcie
        [pop, fit, bestGenFit] = processGeneration(originalImg, pop, fit);
        course(i) = bestGenFit;
        fprintf('Best %i. Progress %.1f percent.\n', bestGenFit, 100 * i * j / (generationsNum * iterationsNum));
        
        if(j==1)
            average(i)=course(i); % 1. naplnenie pola
        else
            if(length(average)< i)
                average(i)=0;   % ak je pole priemernych hodnot kratsie, nefunguje ratanie priemeru
            end
            average(i)=(average(i)*(j-1)+course(i))/j;
        end
    end
   
end

gen = pop(1, :);
save('resultWorkspace');
plotResult;

