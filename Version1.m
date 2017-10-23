Market = readtable('DB/Market_Data.csv');
Compound = readtable('DB/Market_Data_CR.csv');
Return = readtable('DB/Market_Data_NR.csv');

%https://uk.mathworks.com/help/matlab/matlab_prog/access-data-in-a-table.html
%to learn how to access data 

Companies = Market.Properties.VariableNames;
[temp, size] = size(Companies);
test = cell2mat(Companies(3));
for i = 3:1:size
    company = cell2mat(Companies(i));
end
    