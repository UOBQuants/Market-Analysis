list = dir('DB');
len = length(list);
Tables = [];
for i = 3:len 
    name = list(i).name;
    str = ['DB/',name];
    T = readtable(str);
    size(T)
end
    
    