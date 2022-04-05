l = 0;

if l == 1
    a = 1;
    b = 2;
    c = a + b;
    save('savetest.mat');
else
    load('savetest.mat');
end