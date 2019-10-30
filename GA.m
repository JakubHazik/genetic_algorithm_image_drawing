% clear;

global popSize
global space
global amps
global bestPopSelection
global imageSizeX imageSizeY circlesNum

% image params
circlesNum = 100;
imageSizeX = 200;
imageSizeY = 200;
maxCircleRadius = 50;
maxColorVal = 100;
% read img
originalImg = imread('fotoCustom.jpg');
originalImg = imresize(originalImg, [imageSizeY imageSizeX]);

% GA params
iterationsNum = 1;
generationsNum=5;        %pocet generacii/ pokusov
popSize = 50;              %velkost populacie
stringLength = 3;
bestPopSelection=[1 1 1 1 1 1 1 1 1 1]; %vektor definujuci vyber najlepsich retazcov
space = [
    zeros(1, circlesNum),               zeros(1, circlesNum),               zeros(1, circlesNum),                   zeros(1, circlesNum);
    ones(1, circlesNum) * imageSizeX,   ones(1, circlesNum) * imageSizeY,   ones(1, circlesNum) * maxCircleRadius   ones(1, circlesNum) * maxColorVal
];
amps=space(2,:) * 0.02;       %aditivna mutacia;
course=zeros(1, generationsNum);    %inicializacia pola pre uchovanie priebehu, aby sa nemusela v kazdom kroku menit velkost vektora

for j=1:iterationsNum
    %vygenerovanie novej generacie
%     pop=genrpop(popSize,space);
    
    %vytvorenie vektora s fitnesom(funkcnej hodnoty)d pre kazdy retazec
    fit = computeFitness(originalImg, pop, imageSizeX, imageSizeY, circlesNum);
    
    for i=1:generationsNum  %kym nenajde minimum funkcie
        [pop, fit, bestGenFit] = processGeneration(originalImg, pop, fit);
        course(i) = bestGenFit;
        
        fprintf('\nProgress %.1f percent\n', 100 * i * j / (generationsNum * iterationsNum))
        fprintf('Best %i', bestGenFit);
        
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

% figure(1);
% hold on;
% plot(average, '--', 'LineWidth', 1, 'Color', 'r', 'DisplayName', 'Priemer');
% xlabel('Pocet vyhodnoteni.');
% ylabel('Funkcna hodnota.');
% legend('Genetický algoritmus SGA');
% title('Graf zobrazujuci priemer funkčných hodnôt');
% legend

%funkcna hodnota v bode
% function z = kvad(gen)
%   for i=1:popSize
%       z(i)=gen(1)^2+gen(2)^2;
%   end
% end