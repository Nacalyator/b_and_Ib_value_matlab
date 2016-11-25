function [ Ib_value ] = Ib_value_accumulative( steps, magnitudes )
%UNTITLED9 Summary of this function goes here
%   Детальное объяснение здесь
%   Получаем данные о количестве шагов
steps_number = length(steps);
%   Получаем количество строк
rows = length(magnitudes);
%   Создаём заранее матрицу нулей нужного размера для значений b-value.
Ib_value = zeros(rows, 1);
%   Задаём константы нижней и верхней границ диапазона
%   Согласно другим исследованиям, примем равными единицам
alfa1 = 1;
alfa2 = 1;
%   Создаём счётчик, для упрощения сохранения данных
counter = 1;
%   Создаём буффер, где хранится начало шага
buff = 1;
%   Начинаем цикл перебора по шагам
for i = 1:steps_number
%   Рассчитываем значения Ib-value по каждому шагу
    for j = 1:steps(i, 1)
        %   Определяем правую границу
        %   Рассчитываем среднее значение магнитуды до i-го сигналу
        mean_magnitude_j = mean(magnitudes(buff:counter, 1));
        %   Рассчитываем стандартного отклонение магнитуды к i-му шагу
        sigma = std(magnitudes(buff:counter, 1));
        %   Рассчитываем нижниее и верхнее граничные значения магнитуд
        w1 = mean_magnitude_j - (alfa1 * sigma);
        w2 = mean_magnitude_j + (alfa2 * sigma);
        %   Рассчитываем количество сигналов с магнитудой свыше каждой границы
        N_w1 = counts_greater_than(magnitudes(buff:counter, 1), w1);
        N_w2 = counts_greater_than(magnitudes(buff:counter, 1), w2);
        %   Рассчитываем значение Ib-value к i-му сигналу
        Ib = (log10(N_w1) - log10(N_w2)) / ((alfa1 + alfa2) * sigma);
        if isnan(Ib) || ~isfinite(Ib)
            Ib_value(counter, 1) = 0;
        else
            Ib_value(counter, 1) = Ib;
        end
        counter = counter + 1;
    end
    buff = buff + steps(i, 1);
end
end

