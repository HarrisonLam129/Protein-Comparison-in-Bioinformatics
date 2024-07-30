function [estimate] = estimate(n,u,k)
    total = zeros(1,n);
    estimate = zeros(1,n);
    for i = 1:k
        Un = char(randi([97 98],1,n));
        Vn = char(randi([97 98],1,n));
        [~, ~, V] = gapweighted(Un,Vn,[1 -1; -1 1],['a' 'b'],u);
        scores = diag(V);
        total = total + scores(2:end);
    end
    for j = 1:n
        estimate(j) = total(j)/(j*k);
    end
end

