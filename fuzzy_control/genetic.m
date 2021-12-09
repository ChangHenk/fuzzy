clc;clear;

% practice
% f = 15*x-x^2;

total_fit = 0;
stop = 56;
Pc = 0.7;
Pm = 0.5;
generations = 0;

N = [
 0 0 0 1;  0 1 1 0; 1 0 1 1;
 0 0 1 0;  0 1 1 1; 1 1 0 0;
 0 0 1 1;  1 0 0 0; 1 1 0 1;
 0 1 0 0;  1 0 0 1; 1 1 1 0;
 0 1 0 1;  1 0 1 0; 1 1 1 1     ];


r = randperm(15,6);

for i = 1:length(r)  
    G1(i,:) = N(r(i),:);
end

while generations <= 10000

    for i = 1:length(r)
        bin = num2str(G1(i,:));
        dec(i) = bin2dec(bin);
        fit(i) = 15*dec(i) - dec(i)^2;
    end

    % 終止條件判斷
    max_fit = max(fit)
    if max_fit >= stop
        max_fit
        return;
    end

    % 計算fitness
    for i = 1:6
        total_fit = total_fit + fit(i);
    end

    Pr = fit / total_fit;

    [pair1, pair2] = roulette(G1, Pr)
    new_pair = crossover(pair1, pair2, Pc)
    G2 = mutation(new_pair, Pm)
    G1 = G2;
    total_fit = 0;
    generations = generations + 1;
end

% reproduction
% 輪盤式: roulette
% 按照fit機率進行選擇
% 輸出三組配對
function [pair1, pair2] = roulette(G1, Pr)
    i = 0;    
    while i < 3
        cr = randsrc(2,1,[1 2 3 4 5 6; Pr(1) Pr(2) Pr(3) Pr(4) Pr(5) Pr(6)]);
        if(cr(1) ~= cr(2))
            i = i+1;
            offspring(i,1) = cr(1);
            offspring(i,2) = cr(2);
        end
    end
    
    for i = 1:3
        pair1(i,:) = G1(offspring(i,1),:);
        pair2(i,:) = G1(offspring(i,2),:);
    end
end

% 競爭式: tournament
function offspring = tournament(fit)
    i = 0;    
    while i < 5
        cr = randsrc(2,1,[1 2 3 4 5 6;fit(1) fit(2) fit(3) fit(4) fit(5) fit(6)]);
        if(cr(1) ~= cr(2))
            i = i+1;
            offspring(i,1) = cr(1);
            offspring(i,2) = cr(2);
        end
    end
end


% mate
function pair = crossover(pair1, pair2, Pc)
    c = randsrc(3,1,[0 1;(1-Pc) Pc])
    for i = 1:3
        if c(i) == 1
            temp(i,:) = pair2(i,:);
            pair2(i,2:4) = pair1(i,2:4);
            pair1(i,2:4) = temp(i,2:4);
        end
    end
    pair = [pair1; pair2];
end

% mutation
% 按照機率Pm進行突變
% 若有突變發生會隨機輸出突變位置
% 否則輸出為 0
function new_pair = mutation(new_pair, Pm)
    p = randsrc(6,4,[0 1; 1-Pm Pm])
    [m,n] = find(p == 1);
    if isempty(m) == 0
        for i = 1:length(m)
            if new_pair(m(i),n(i)) == 0
                new_pair(m(i),n(i)) = 1;
            else
                new_pair(m(i),n(i)) = 0;
            end
        end
    end
end