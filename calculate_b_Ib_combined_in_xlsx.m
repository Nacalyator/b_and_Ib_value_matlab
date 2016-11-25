function calculate_b_Ib_combined_in_xlsx( file, window_size, lag )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%   Нужные нам столбцы:
%   1 - время суммарное; 2 - время шага (если есть шаг);
%   3 - суммарное количество сигналов; 4 - кол-во сигналов на шаге;
%   6 - Амплитуда
%   Получаем данные с интересующих нас таблиц
from_sensor1 = xlsread(file, 'Фильтр. Сигналы1');
from_sensor2 = xlsread(file, 'Фильтр. Сигналы2');
%   Получаем количество сигналов на каждом шаге испытания
steps = get_steps_counts(from_sensor1(:, 4));
%   Получаем значения амплитуд из эксперимента
amplitudes1 = from_sensor1(:, 6);
amplitudes2 = from_sensor2(:, 6);
%   Получаем значения магнитуд
magnitudes1 = log10(amplitudes1);
magnitudes2 = log10(amplitudes2);
%   Получаем времена прихода сигналов и времена прихода по шагам
times = from_sensor1(:, 1);

%   Создаём заголовок
headers_list = {'Left time', 'Right time', 'Left index', 'Right index', 'b-value comb1', 'b-value comb2', 'Ib-value comb1', 'Ib-value comb2'};
%   Рассчитываем окна
windows_combined = get_windows_for_combined_method(steps, window_size, lag);
%   Рассчитываем коэффициенты
b_comb1 = b_value_combined(windows_combined, magnitudes1);
b_comb2 = b_value_combined(windows_combined, magnitudes2);
Ib_comb1 = Ib_value_combined(windows_combined, magnitudes1);
Ib_comb2 = Ib_value_combined(windows_combined, magnitudes2);
%   Определяем времена сигналов, являющихся границами окон
windows_number = length(windows_combined);
times_left = zeros(length(windows_number), 1);
times_right = times_left;
for w = 1:windows_number
    times_left(w, 1) = times(windows_combined(w, 1), 1);
    times_right(w, 1) = times(windows_combined(w, 2), 1);
end
table = [times_left, times_right, windows_combined(:, 1), windows_combined(:, 2), b_comb1, b_comb2, Ib_comb1, Ib_comb2];

%   Сохраняем полученные листы в исходный файл Excell в конец
xlswrite(file, headers_list, 'Ib and b comb', 'A1');
xlswrite(file, table, 'Ib and b comb', 'A2');

%   Выводим радостное сообщение в консоль
good_news = ['Process for file ' file ' has been finished succesful'];
disp(good_news);

end