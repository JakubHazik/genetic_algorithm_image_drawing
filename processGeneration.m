function [newPop, fit, bestGenFit] = processGeneration(originalImg, pop, fit)

global popSize
global space
global amps
global bestPopSelection
global imageSizeX imageSizeY circlesNum

%najdenie najlespsej generacie
[best, bestFit]=selbest(pop, fit, bestPopSelection);
%prenos starsich jedincov do novej generacie
[oldPop, oldPopFit]=selrand(pop, fit, popSize-sum(bestPopSelection));

%krizenie
work=crossov(oldPop, 2, 0);

%mutacia
work=mutx(work,0.12,space);
work=muta(work,0.1,amps,space);

%spojenie starej a novej generacie
newPop = [best; work];

%vyhodnotenie work skupiny
workFit = computeFitness(originalImg, work, imageSizeX, imageSizeY, circlesNum);
fit = [bestFit, workFit];

bestGenFit = bestFit(1);

end