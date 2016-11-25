function calculate_b_Ib_in_xlsx( file, window_size, lag )
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
times_by_steps = from_sensor1(:, 2);


%   b-value и Ib-value накопительное
headers_list1 = {'Times', 'Times by steps', 'Counts', 'Counts by steps', 'b-value acc1', 'b-value acc2', 'Ib-value acc1', 'Ib-value acc2'};
counts = from_sensor1(:, 3);
counts_by_steps = from_sensor1(:, 4);
b_acc1 = b_value_accumulative(steps, magnitudes1);
b_acc2 = b_value_accumulative(steps, magnitudes2);
Ib_acc1 = Ib_value_accumulative(steps, magnitudes1);
Ib_acc2 = Ib_value_accumulative(steps, magnitudes2);
table1 = [times, times_by_steps, counts, counts_by_steps, b_acc1, b_acc2, Ib_acc1, Ib_acc2];
%   b-value и Ib-value методом скользящего окна
headers_list2 = {'Left time', 'Right time', 'Left_windows_limit', 'Right_windows_limit', 'b-value win1', 'b-value win2', 'Ib-value win1', 'Ib-value win2'};
%   Получаем окна правильного размера с учётом того, что окна для каждого
%   шага задаются отдельно




windows = get_calculation_windows(steps, window_size, lag);
b_win1 = b_value_sliding_window(windows, magnitudes1);
b_win2 = b_value_sliding_window(windows, magnitudes2);
Ib_win1 = Ib_value_sliding_window(windows, magnitudes1);
Ib_win2 = Ib_value_sliding_window(windows, magnitudes2);
%   Определяем времена сигналов, являющихся границами окон
windows_number = length(windows);
times_left = zeros(length(windows_number), 1);
times_right = times_left;
for w = 1:windows_number
    times_left(w, 1) = times(windows(w, 1), 1);
    times_right(w, 1) = times(windows(w, 2), 1);
end
table2 = [times_left, times_right, windows(:, 1), windows(:, 2), b_win1(:, 1), b_win2(:, 1), Ib_win1(:, 1), Ib_win2(:, 1)];

%   Сохраняем полученные листы в исходный файл Excell в конец
xlswrite(file, headers_list1, 'Ib and b acc', 'A1');
xlswrite(file, table1, 'Ib and b acc', 'A2');
xlswrite(file, headers_list2, 'Ib and b win', 'A1');
xlswrite(file, table2, 'Ib and b win', 'A2');

%   Выводим радостное сообщение в консоль
good_news = ['Process for file ' file ' has been finished succesful'];
disp(good_news);

end