M = 5;

for i=1:10
    C(1).O005(i).obs = sort(randperm(M^2,floor(0.05*M^2)));
    C(1).O010(i).obs = sort(randperm(M^2,floor(0.1*M^2)));
    C(1).O020(i).obs = sort(randperm(M^2,floor(0.2*M^2)));
end

M = 10;

for i=1:10
    C(2).O005(i).obs = sort(randperm(M^2,floor(0.05*M^2)));
    C(2).O010(i).obs = sort(randperm(M^2,floor(0.1*M^2)));
    C(2).O020(i).obs = sort(randperm(M^2,floor(0.2*M^2)));
end

M = 15;
for i=1:10
    C(3).O005(i).obs = sort(randperm(M^2,floor(0.05*M^2)));
    C(3).O010(i).obs = sort(randperm(M^2,floor(0.1*M^2)));
    C(3).O020(i).obs = sort(randperm(M^2,floor(0.2*M^2)));
end

M = 20;
for i=1:10
    C(4).O005(i).obs = randperm(M^2,floor(0.05*M^2));
    C(4).O010(i).obs = randperm(M^2,floor(0.1*M^2));
    C(4).O020(i).obs = randperm(M^2,floor(0.2*M^2));
end


