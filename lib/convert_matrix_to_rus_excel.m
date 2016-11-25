function [ output ] = convert_matrix_to_rus_excel( matrix )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%   ���������� ������ ������� � ������ ���������, ���������� ����������
%   ����� � ��������
matrix_size = size(matrix);
rows = matrix_size(1, 1);
cols = matrix_size(1, 2);
%   ������ ������ ����� ������� ������� ��� ������������ ����������
output = cell(matrix_size);
for i = 1:rows
    for j = 1:cols
        buff = num2str(matrix(i, j));
        if strfind(buff, '.')
            output(i, j) = cellstr(strrep(buff, '.', ','));
        else
            output(i, j) = cellstr(buff);
        end
    end
end


end

