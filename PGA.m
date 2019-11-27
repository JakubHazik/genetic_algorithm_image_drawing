%  clear;
%  close all;
addpath('genetic_toolbox');

global popSize
global space
global amps
global bestPopSelection
global imageSizeX imageSizeY circlesNum
% 
% % image params
% circlesNum = 100;
% imageSizeX = 200;
% imageSizeY = 200;
% maxCircleRadius = 40;
% maxColorVal = 50;
% % read img
% originalImg = imread('fotoCustom.jpg');
% originalImg = imresize(originalImg, [imageSizeY imageSizeX]);
% % figure;
% % imshow(originalImg);
% % title('Original image')
% 
% % GA params
% saveRate = 100;
% islandsNum = 9;
% migrationRate = 200;
% iterationsNum = 1;
generationsNum=10000;        %pocet generacii/ pokusov
% popSize = 80;              %velkost populacie
% bestPopSelection=ones(1, 12); %vektor definujuci vyber najlepsich retazcov
% space = [
%     zeros(1, circlesNum),               zeros(1, circlesNum),               zeros(1, circlesNum),                   zeros(1, circlesNum);
%     ones(1, circlesNum) * imageSizeX,   ones(1, circlesNum) * imageSizeY,   ones(1, circlesNum) * maxCircleRadius   ones(1, circlesNum) * maxColorVal
% ];
% amps = space(2,:) * 0.05;       %aditivna mutacia;
% course=zeros(islandsNum, generationsNum);    %inicializacia pola pre uchovanie priebehu, aby sa nemusela v kazdom kroku menit velkost vektora
% average = zeros(1, generationsNum);
% % %%
% 
% % set output dir
% output_dir = "savings/" + sprintf("%s", datetime('now'));
% mkdir(output_dir);

start = 2505;

for j=1:iterationsNum
    %vygenerovanie novej generacie
%     pop=genrpop(popSize * islandsNum,space);
%     pop = generatePop(originalImg, popSize * islandsNum, circlesNum, space);
    pop = change(pop, 2, space);
    
    %vytvorenie vektora s fitnesom(funkcnej hodnoty)d pre kazdy retazec
    fit = computeFitness(originalImg, pop, imageSizeX, imageSizeY, circlesNum);
    
    for i=start:generationsNum  %kym nenajde minimum funkcie
        for island=1:islandsNum
            islandRange = (island - 1)* popSize +1: (island )* popSize;
            [islandPop, islandFit, islandBestGenFit] = processGeneration(originalImg, pop(islandRange, :), fit(islandRange));

            pop(islandRange, :) = islandPop;
            fit(islandRange) = islandFit;   

            %ukladanie najlepsieho jedinca pre vykreslovanie
            course(island, i) = islandBestGenFit;  
            
            if island == 1
                bestFitCourse(j, i) = islandBestGenFit;
            end
        end

        fprintf('Best %i. Progress %.1f percent. Generation %i\n', course(1, i), 100 * i * j / (generationsNum * iterationsNum), i);
        
        if(0 == mod(i, migrationRate))
            [pop, fit] = makeMigration(pop, fit, islandsNum);
        end

        % ukladanie priemernej hodnoty
        average(i) = mean(course(:,i));
        
        % ukladanie priebehu
        if(0 == mod(i, saveRate))
            save(output_dir + "/" + sprintf('%07d', i));
            img = drawGAImage(pop(1, :), imageSizeX, imageSizeY, circlesNum);
            imwrite(img, output_dir + "/" + sprintf('%07d', i) + ".png");
            plotResult;
        end
        
    end
   
end

gen = pop(1, :);
save(output_dir + "/" + sprintf('%07d', i + 1));
plotResult;

