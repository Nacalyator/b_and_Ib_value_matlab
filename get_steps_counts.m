function [ steps ] = get_steps_counts( table )
%UNTITLED7 Summary of this function goes here
%   ������ ������� ��������� ������� ��������, ���������������
%   �� ����� Excel, � ���������� ������-������� ��������.
%   ��� ����������� ������� = ���������� ����� ���������,
%   �������� ����� ������� = ���������� �������� �� ������ ����.
steps = [];
signal_counter = 0;
buff = 0;
rows = length(table);
for i = 1:rows
    if buff >= table(i, 1)
        steps(end + 1, 1) = signal_counter;
        signal_counter = 1;
    else
        signal_counter = signal_counter + 1;
    end
    buff = table(i, 1);
end
steps(end + 1, 1) = signal_counter;
end