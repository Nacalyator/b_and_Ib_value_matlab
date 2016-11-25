function [ windows ] = get_calculation_windows( steps, window_size, lag )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   ќптимальный размер окна колеблетс€ в диапазоне 50...100 сигналов
%   Ћаг или смещение желательно выбирать в диапазоне 5...20 сигналов
%   —оздаЄм пустой массив дл€ последующего заполнени€

windows = zeros(0, 2);
%   ѕолучаем данные о количестве шагов
steps_number = length(steps);
%    оличество сигналов на предыдушем шаге, инициализируем равным 0
previous_steps_counts = 0;
%   ѕеребираем циклом в цикле
for i = 1:steps_number
%   ќпредел€ем, умещаетс€ ли окно в шаг, если нет - шаг будет €вл€тьс€
%   окном полностью. ¬ противном случае рассчитываем, сколько окон
%   помещаетс€ в шаг испытани€
    if steps(i, 1) <= window_size
        windows_length = 1;
    else
        windows_length = fix((steps(i, 1) - window_size) / lag) + 2;
    end
%   ќпредел€ем границы окон
    for j = 1:windows_length
%   ќпредел€емс€ с левой границей окна
        if j == 1 && i == 1
            a = 1 + previous_steps_counts;
        elseif j == 1 && i ~= 1
            a = previous_steps_counts;
        else
            a = a + lag;
        end
%   ќпредел€емс€ с правой границей окна
        if (a + window_size - previous_steps_counts) > steps(i, 1)
            b = steps(i, 1) + previous_steps_counts;
        else
            b = a + window_size;
        end
%   —охран€ем значени€ границ окна
        windows(end + 1, 1) = a;
        windows(end, 2) = b;
    end
    previous_steps_counts = previous_steps_counts + steps(i, 1);
end
end

