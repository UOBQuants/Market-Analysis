Market = readtable('DB/Market_Data.csv');
Compound = readtable('DB/Market_Data_CR.csv');
Return = readtable('DB/Market_Data_NR.csv');
R = height(Market);
Compound(R,:) = []; %Last day does not have any return value 
Return(R,:)   = []; %and therefore deleted
Dcolumns = find( sum(ismissing(Compound)) > 0 );
Compound(:,Dcolumns) = [];
Market(:,Dcolumns) = [];
Return(:,Dcolumns) = [];

%https://uk.mathworks.com/help/matlab/matlab_prog/access-data-in-a-table.html
%to learn how to access data 

Companies = Market.Properties.VariableNames;
size = length(Companies);

V = [];

for i = 3:1:size
    Company = Compound{:,i};
    char(Companies(i))
    pd = fitdist(Company,'tLocationScale');
    h = chi2gof(Company,'CDF',pd);
    if h == 1
        v = ksdensity(Company,Company,'function','cdf');
    else
        v = cdf(pd,Company);
    end
    
    V = [V,v];
    
end

[Rho,nu] = copulafit('t',V,'Method','ApproximateML');