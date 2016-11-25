function [ Ib_value_combined ] = Ib_value_combined( windows_combined, magnitudes )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   ѕолучаем заранее массив нужного размера. ƒл€ этого определ€ем его длину
Ib_length = length(windows_combined);
%   —оздаЄм массив нулей
Ib_value_combined = zeros(Ib_length, 1);
%   «адаЄм константы нижней и верхней границ диапазона
%   —огласно другим исследовани€м, примем равными единицам
alfa1 = 1;
alfa2 = 1;
%   –ассчитываем значени€ Ib-value по границам окон
for i = 1:Ib_length
%   –ассчитываем среднее значение магнитуды i-го окна
    a = windows_combined(i, 1);
    b = windows_combined(i, 2);
    test = magnitudes(a:b, 1);
    mean_magnitude_i = mean(magnitudes(a:b, 1));
%   –ассчитываем стандартного отклонение магнитуды i-го окна
    sigma = std(magnitudes(a:b, 1));
%   –ассчитываем нижниее и верхнее граничные значени€ магнитуд i-го окна
    w1 = mean_magnitude_i - (alfa1 * sigma);
    w2 = mean_magnitude_i + (alfa2 * sigma);
%   –ассчитываем количество сигналов с магнитудой свыше каждой границы i-го окна
    N_w1 = counts_greater_than(magnitudes(a:b, 1), w1);
    N_w2 = counts_greater_than(magnitudes(a:b, 1), w2);
%   –ассчитываем значение Ib-value i-го окна
    Ib = (log10(N_w1) - log10(N_w2)) / ((alfa1 + alfa2) * sigma);
    if isnan(Ib) || ~isfinite(Ib)
        Ib = log10(N_w1) / ((alfa1 + alfa2) * sigma);
        Ib_value_combined(i, 1) = Ib;
    else
        Ib_value_combined(i, 1) = Ib;
    end
end

