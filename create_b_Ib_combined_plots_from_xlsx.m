function create_b_Ib_combined_plots_from_xlsx( file )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   Извлекаем нужную таблицу
b_Ib_comb = xlsread(file, 'Ib and b comb');

%   Определяем количество шагов
full_data = xlsread(file, 'Фильтр. Сигналы1');
steps = get_steps_counts(full_data(:, 4));
steps_counts = length(steps);
%   Определяем границы шагов в континуальном представлении
steps_limits = zeros(steps_counts, 2);
buff = 1;
for i = 1:steps_counts
    steps_limits(i, 1) = buff;
    steps_limits(i, 2) = buff + steps(i, 1) - 1;
    buff = buff + steps(i, 1);
end
%   Получаем путь до папки с файлом и имя файла
[path, ~, ~] = fileparts(file);
%   Получаем путь до папки с данными нагружения образца
flex_raw_data_folder = strcat(path, '\flex_RawData');
%   Получаем пути до файлом с данными нагружения образца, где количество
%   шагов = количество выбираемых файлов
flex_raw_data_files = cell(0, 1);
for i = 1:steps_counts
%   Получаем имя файла csv
    csv_file_name = strcat(flex_raw_data_folder, '\Specimen_RawData_', num2str(i), '.csv');
%   Оборачиваем строку в ячейку
    csv_file_name_in_cell = cellstr(csv_file_name);
%   Добавляем путь до файла в конец массива ячеек
    flex_raw_data_files(end + 1, 1) = csv_file_name_in_cell;
end
%   Импортируем данные из файлов csv циклом и "синхронизируем" их с
%   временем эксперимента
TS_exp = zeros(0, 2);
previous_last_time = 0;
for i = 1:steps_counts
%   Считываем данные из файла, где:
%   1-й столбец - время
%   2-й столбец - перемещение
%   3-й столбец - нагрузка
%   4-й столбец - напряжение
    csv_data = xlsread(flex_raw_data_files{i, 1});

% Тут что-то работает не так    
    
    
%   Получаем массива времени и напряжений испытания
    TS = [csv_data(:, 1), csv_data(:, 4)];
    TS_exp = [TS_exp; TS(:, 1) + previous_last_time, TS(:, 2)];
    previous_last_time = full_data(steps_limits(i, 2), 1);
end
%   Получаем полный путь до папки с графиками
plots_directory = strcat(path, '\Ib_b_value_plots');
%   Создаём папку для графиков в директории исходного файла xlsx
mkdir(plots_directory);
%   Создаём нужные графики



b_comb_figure = figure('doublebuffer','off','Visible','Off');
plot(b_Ib_comb(:, 2), b_Ib_comb(:, 5), '-r');
hold on;
plot(b_Ib_comb(:, 2), b_Ib_comb(:, 6), '-b');
legend('Sensor 1', 'Sensor 2');
hold on;
grid on;
[hAx, ~, ~] = plotyy( 0, 0, TS_exp(:, 1), TS_exp(:, 2));
title('b-value by combined method');
ylabel(hAx(1),'b-value');
ylabel(hAx(2),'Stress, MPa');
xlabel('Time, s');
b_acc_path = strcat(plots_directory, '/', 'b_comb');
print(b_acc_path, '-dpng');


Ib_comb_figure = figure('doublebuffer','off','Visible','Off');
plot(b_Ib_comb(:, 2), b_Ib_comb(:, 7), '-r');
hold on;
plot(b_Ib_comb(:, 2), b_Ib_comb(:, 8), '-b');
legend('Sensor 1', 'Sensor 2');
hold on;
grid on;
[hAx, ~, ~] = plotyy( 0, 0, TS_exp(:, 1), TS_exp(:, 2));
title('Ib-value by combined method');
ylabel(hAx(1),'Ib-value');
ylabel(hAx(2),'Stress, MPa');
xlabel('Time, s');
Ib_acc_path = strcat(plots_directory, '/', 'Ib_comb');
print(Ib_acc_path, '-dpng');

%   Радуемся
good_news = ['Plots creating for file ' file ' has been finished succesful'];
disp(good_news);
end

