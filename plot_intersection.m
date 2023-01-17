figure(3);
clf;
hold on;

xs = linspace(0, 20, 1000);
plot(xs, xs .* slope, 'r-');
plot(xs, sqrt(xs), 'b-');