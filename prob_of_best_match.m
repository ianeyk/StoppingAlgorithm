% Calculates probability of finding true love among a total number of candidates, using a number of candidates as trials
function prob = prob_of_best_match(total, trial)

    % probability of success
    prob = 0;
    for k = 1:(total - trial)
        this_k = k; % uncomment for printout
        this_prob = factorial(total - trial) ./ factorial(total) .*  factorial(total - k - 1) ./ factorial(total - trial - k) .* trial ./ k; 
        prob = prob + this_prob;
    end
end