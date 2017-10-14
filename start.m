N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.1; % the param in Femi
K1 = 0.5; % the weight for contribution
neigRadius = 1;
iter_num = 300;
time_scale = 0.1; % the probability of changing strategy for the slower players
slow_proportion = 0.3; % the proportion of the slow players

% 初始化策略矩�?
StrasMatrix = initStrasMatrix( N );

% init slow players
slow_players = rand(N);
slow_players(slow_players > slow_proportion) = 1;
slow_players(slow_players <= slow_proportion) = 0;

% init payoff matrix
PayoffMatr = [R, S; T, P];

% play the game for the first time
PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

% accept
accept_rate = zeros(1, iter_num);

fq_coop = zeros(1, iter_num);

for i = 1:iter_num
    tic
    
    [StrasMatrix, accept_rate(i)] = Evolution( StrasMatrix, PaysMatrix, ...
        neigRadius, slow_players, time_scale, K, K1);  % 
    
    PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );
    
    fq_coop(i) = sum(sum(StrasMatrix));
    
    toc
    fprintf(['iter ', num2str(i), ' done\n'])
end


fq_coop = fq_coop / (N * N);
figure(2)
plot(fq_coop, 'LineWidth', 2)
title('Proportion of cooperators in each iteration')

figure(3)
DrawStraMatrix(StrasMatrix)
title(['StrasMatrix after ', num2str(iter_num), ' iterations'])


