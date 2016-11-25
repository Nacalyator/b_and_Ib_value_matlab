%   Забиваем путь до корневой папки с данными
root_dir = 'F:\АЭ_статистика';
%   Получаем список файлов с учётом расширения файлов и игнорирование
%   файлов с данными по локации сигналов
files = searcher(root_dir, 'xlsx', 'loc');
%   Когда получили файлы, начинаем рассчёт
%   Определяем количество файлов
files_counts = length(files);
%   Перебираем циклов
for i = 1:files_counts
%   Рассчитываем b и Ib значения в каждом файле
    calculate_b_Ib_combined_in_xlsx(files{i, 1}, 100, 5);
%   Создаём графики
    create_b_Ib_combined_plots_from_xlsx(files{i, 1});
end

disp('Well done!');