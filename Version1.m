Market = readtable('DB/Market_Data.csv');
Compound = readtable('DB/Market_Data_CR.csv');
Return = readtable('DB/Market_Data_NR.csv');

%https://uk.mathworks.com/help/matlab/matlab_prog/access-data-in-a-table.html
%to learn how to access data 

Companies = Market.Properties.VariableNames;
size = length(Companies);


Company1 = Compound{:,3};
Company2 = Compound{:,4};

figure
scatterhist(Company1,Company2)

u = ksdensity(Company1,Company1,'function','cdf');
v = ksdensity(Company2,Company2,'function','cdf');

figure;
scatterhist(u,v)
xlabel('u')
ylabel('v')

rng default  % For reproducibility
U = [u , v];
U(U(:,1) >= 1, :) = [];
U(U(:,2) >= 1, :) = [];


[Rho,nu] = copulafit('t',U,'Method','ApproximateML');

r = copularnd('t',Rho,nu,1000);
u1 = r(:,1);
v1 = r(:,2);

figure;
scatterhist(u1,v1)
xlabel('u')
ylabel('v')
set(get(gca,'children'),'marker','.')

x1 = ksdensity(Company1,u1,'function','icdf');
y1 = ksdensity(Company2,v1,'function','icdf');

figure;
scatterhist(x1,y1)
set(get(gca,'children'),'marker','.')