function indices = Bootstrap_Sample(W,n)

    random_number = rand(1,n);
    for i=1:n
        location = max(find(random_number(i)>cumsum(W))) + 1;
        if isempty(location)
            indices(i) = 1;
        else
            indices(i) = location;
        end
    end
    indices = indices';

end