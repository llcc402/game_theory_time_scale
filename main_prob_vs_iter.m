N = 40;
r = 0.5;
T = 1 + r; R = 1; P = 0; S = 0;
K = 0.9; % the param in Femi
K1 = 0.9; % the weight for contribution
neigRadius = 1;
iter_num = 300;
time_scale = 0.3; % the probability of changing strategy for the slower players
slow_proportion = [0.1 0.3 0.5 0.7 0.9]; % the proportion of the slow players

% init payoff matrix
PayoffMatr = [R, S; T, P];

for kk = 1:5
    % init 
    StrasMatrix = initStrasMatrix( N );

    % init slow players
    slow_players = rand(N);
    slow_players(slow_players > slow_proportion(kk)) = 1;
    slow_players(slow_players <= slow_proportion(kk)) = 0;

    % play the game for the first time
    PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

    fq_coop = zeros(1, iter_num);

    for i = 1:iter_num
        [StrasMatrix, ~] = Evolution( StrasMatrix, PaysMatrix, ...
            neigRadius, slow_players, time_scale, K, K1);  % 

        PaysMatrix = Play( StrasMatrix, PayoffMatr, neigRadius );

        fq_coop(i) = sum(sum(StrasMatrix));
    end
    
    hold on
    fq_coop = fq_coop / (N * N);
    plot(fq_coop, 'LineWidth', 2)
end