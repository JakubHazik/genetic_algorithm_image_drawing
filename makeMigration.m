function [pop, fit] = makeMigration(pop, fit, islandsNum)
    global popSize
    
    % hviezda
    % od 2 pretoze vsetky migrujeme do 1. ostrova
    for island = 2: islandsNum
        bestStringIndex = (island - 1) * popSize +1;
        bestString = pop(bestStringIndex, :);
        bestStringFit = fit(bestStringIndex);
        
        pop(popSize - island + 2, :) = bestString;
        fit(popSize - island + 2) = bestStringFit;    
    end
        
    %uzavrety kruh bez 1
    for island = 2: (islandsNum -1)
        bestStringIndex = (island - 1) * popSize +1;
        bestString = pop(bestStringIndex, :);
        bestStringFit = fit(bestStringIndex);
        pop(popSize * (island + 1), :) = bestString;
        fit(popSize * (island + 1)) = bestStringFit;    
    end
    % este prvy s poslednym
    bestStringIndex = (islandsNum - 1) * popSize + 1;
    bestString = pop(bestStringIndex, :);
    bestStringFit = fit(bestStringIndex);
    pop(popSize * 2, :) = bestString;
    fit(popSize * 2) = bestStringFit;
end
