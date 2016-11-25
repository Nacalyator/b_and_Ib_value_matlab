function [ b_value_comb ] = b_value_combined( combined_windows, magnitudes )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Получаем данные о количестве шагов
%   Данный расчёт значений b-value производится по формуле, предложенной
%   Аки и Утсу (формула Аки-Утсу или Aki-Utsu):
%   b = log10(e) / (M_mean - M_treshold)

%   Возможен вариант MLE (Maximum likelihood estimation),
%   где формула имеет вид:
%   b = 1 / (ln(10)*(M_mean - M_treshold))

%   Однако обе формулы сводятся к следующему виду:
%   b = 0.43 / (M_mean - M_treshold)

%   Получаем заранее массив нужного размера. Для этого определяем его длину
b_length = length(combined_windows);
%   Создаём массив нулей
b_value_comb = zeros(b_length, 1);
%   Порог сигнала указан как 0,023 В. Что тогда минимальная амплитуда?
treshold_amplitude = 0.023;
treshold_magnitude = log10(treshold_amplitude);
%   Определяем число, стоящее в числителе (log10(e))
e = exp(1);
logarithm_e = log10(e);

%   Перебираем циклом и рассчитываем значения b-value
for i = 1:b_length
%   Рассчитываем среднее значение магнитуды i-го окна
    a = combined_windows(i, 1);
    b = combined_windows(i, 2);
    mean_magnitude_i = mean(magnitudes(a:b, 1));
%   В некоторых работах берётся значение 0,43 вместо 8,686
    b = logarithm_e / (mean_magnitude_i - treshold_magnitude);
    if isnan(b) || ~isfinite(b)
        b_value_comb(i, 1) = 0;
    else
        b_value_comb(i, 1) = b;
    end
end
end







