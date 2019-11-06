function [pop, fit] = makeMigration(pop, fit, islandsNum)
    global popSize
    
    % od 2 pretoze vsetky migrujeme do 1. ostrova
    for island = 2: islandsNum
        bestStringIndex = (island - 1) * popSize +1;
        bestString = pop(bestStringIndex);
        bestStringFit = fit(bestStringIndex);
        
        pop(popSize - island + 2, :) = bestString;
        fit(popSize - island + 2) = bestStringFit;    
    end
end

