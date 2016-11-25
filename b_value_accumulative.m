function [ b_value ] = b_value_accumulative( steps, magnitudes )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%   Данный расчёт значений b-value производится по формуле, предложенной
%   Аки и Утсу (формула Аки-Утсу или Aki-Utsu):
%   b = log10(e) / (M_mean - M_treshold)

%   Возможен вариант MLE (Maximum likelihood estimation),
%   где формула имеет вид:
%   b = 1 / (ln(10)*(M_mean - M_treshold))

%   Однако обе формулы сводятся к следующему виду:
%   b = 0.43 / (M_mean - M_treshold)

%   Получаем данные о количестве шагов
steps_number = length(steps);
%   Получаем количество строк
rows = length(magnitudes);
%   Создаём заранее матрицу нулей нужного размера для значений b-value.
%   Возможно это немногим ускорит работу. По крайней мере быстрее,
%   чем каждый раз изменять длину массива и добавлять значения в конец.
b_value = zeros(rows, 1);
%   Порог сигнала указан как 0,023 В. Что тогда минимальная амплитуда?
treshold_amplitude = 0.023;
treshold_magnitude = log10(treshold_amplitude);
%   Определяем число, стоящее в числителе (log10(e))
e = exp(1);
logarithm_e = log10(e);
%   Создаём счётчик, для упрощения сохранения данных
counter = 1;
%   Создаём буффер, где хранится начало шага
buff = 1;
%   Начинаем цикл перебора по шагам
for i = 1:steps_number
%   Рассчитываем значения Ib-value по каждому шагу
    for j = 1:steps(i, 1)
        mean_magnitude_j = mean(magnitudes(buff:counter, 1));
        b = logarithm_e / (mean_magnitude_j - treshold_magnitude);
        if isnan(b) || ~isfinite(b)
            b_value(counter, 1) = 0;
        else
            b_value(counter, 1) = b;
        end
        counter = counter + 1;
    end
    buff = buff + steps(i, 1);
end
end

