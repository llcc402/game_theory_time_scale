function [ newStrasMatrix , accept_rate] = Evolution( StrasMatrix, PaysMatrix, ...
        neigRadius, slow_players, time_scale, K, K1)

N = length(StrasMatrix);

newStrasMatrix = StrasMatrix;

accept_rate = 0;

for i = 1:N
    for j = 1:N
        myPayoff = PaysMatrix(i,j);
        myStra = StrasMatrix(i,j);
        neighSet = FindAllNeighs(i, j, N, neigRadius);
        if (slow_players(i,j) == 1 && rand(1) < time_scale) || slow_players(i,j) == 1
            newStra_ij = UpdateStra( myPayoff, myStra, neighSet, neigRadius,... 
                   StrasMatrix, PaysMatrix, N, K, K1);
        else
            newStra_ij = myStra;
        end
        if myStra ~= newStra_ij
            accept_rate = accept_rate + 1;
        end
        newStrasMatrix(i,j) = newStra_ij;

    end
end

accept_rate = accept_rate / size(StrasMatrix, 1) / size(StrasMatrix, 1);


