function [ status ] = save_to_csv_with_header( path, filename, header, data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   Создаём файл и открываем его с правами на запись
file = strcat(path, filename, '.csv');
fid = fopen(file , 'w');
%   Исправляем заголовок для нормальной записи
fixed_header = strjoin(header, ';');
%   Записываем заголовок в файл
%fprintf(fid, '%s,', header{1,1:end-1});
%fprintf(fid, '%s\n', header{1,end});
fprintf(fid, '%s\n', fixed_header);
%   Заголовок записан, закрываем файл
fclose(fid);
%   Записываем матрицу в фалй
dlmwrite(file, data,';');
dlmwrite(file, data,'-append');
status = 1;
end