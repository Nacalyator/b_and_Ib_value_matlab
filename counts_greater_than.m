function [ counts ] = counts_greater_than( data, lower_limit )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Получаем количество строк, то есть длину
rows = length(data);
%   Объявляем счётчик и приравнимаем к нулю
counts = 0; 
%   Запускаем цикл. В цикле перебираем всё значения входного
%   вектора-столбца и в случае превышения i-ым значением нижней границы
%   инкрментируем значение счётчика.
for i = 1:rows
    if data(i, 1) >= lower_limit
        counts = counts + 1;
    end
end
end

