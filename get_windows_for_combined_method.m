function [ windows ] = get_windows_for_combined_method( steps, window_size, lag )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Корректируем размер окна
win_size = window_size - 1;
%   Определяем количество шагов
steps_counts = length(steps);
%   Создаём пустой массив
windows = zeros(0, 2);
%   Создаём константы 
left = 1;
right = 1;

for i = 1:steps_counts
    if steps(i, 1) < win_size
        for j = 1:steps(i, 1)
            if left ~= right
                windows(end + 1, 1) = left;
                windows(end, 2) = right;
            end
            right = right + 1;
        end
    else
        acc_limit = win_size;
        for j = 1:acc_limit
            if left ~= right
                windows(end + 1, 1) = left;
                windows(end, 2) = right;
            end
            right = right + 1;
        end
        right = right + 1;
        win_limit = fix((steps(i, 1) - win_size) / lag) + 2;
        win_left = left;
        win_right = right;
        for j = 1:win_limit
            windows(end + 1, 1) = win_left;
            windows(end , 2) = win_right - 1;
            
            win_left = win_left + lag;
            if (win_right + lag) <= left + steps(i, 1)
                win_right = win_right + lag;
            else
                win_right = left + steps(i, 1);
            end
        end
    end
    left = left + steps(i, 1);
    right = left;
end
end

