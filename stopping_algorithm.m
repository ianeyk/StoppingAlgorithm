% largest candidate pool to simulate
most_candidates = 100;
n_candidates = 1:most_candidates;

% initialize arrays for storing algorithm results for different total and trial date combinations
probs = zeros(most_candidates);
max_probs = zeros(most_candidates, 1);
max_prob_locs = zeros(most_candidates, 1);

% run simulations
% first, choose total number of dates expected over lifetime
% then, choose number of trial dates less than or equal to total dates
for total = n_candidates
    for trial = 1:total
        prob = prob_of_best_match(total, trial);
        probs(total, trial) = prob;
    end

    % find and store the number of trial dates with maximum probability of success
    % for the given total number of dates
    [max_prob, max_prob_loc] = max(probs(total, :));
    max_probs(total) = max_prob; 
    max_prob_locs(total) = max_prob_loc;
end

% calculate line of best fit
% optimal number of trial dates = slope * n_candidates + offset
b = max_prob_locs;
A = [ones(most_candidates, 1), (n_candidates).'];
params = A \ b;
slope = params(2)
offset = params(1)

log(1 ./ slope)

% prepare to plot results
[X,Y] = meshgrid(n_candidates);

figure(1);
clf;
hold on;
surf(Y, X, probs);
zlim([0.001, 1]); % ignore zero values, which obstruct the graph
xlabel("Candidate Pool Size");
ylabel("Trial Size");
zlabel("Probability of Success");
colorbar();

figure(2);
clf;
hold on;
plot(n_candidates, max_prob_locs, 'ro-');
plot(n_candidates, (n_candidates) .* slope + offset, 'k-');
xlabel("Candidate Pool Size");
ylabel("Optimal Trial Size");
xlim([-5, most_candidates + 5]);
% ylim([0, most_candidates ./ 2]);
axis equal;
% gtext("Slope = " + slope);