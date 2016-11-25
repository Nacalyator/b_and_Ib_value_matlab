function [ windows ] = get_calculation_windows( steps, window_size, lag )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   ����������� ������ ���� ���������� � ��������� 50...100 ��������
%   ��� ��� �������� ���������� �������� � ��������� 5...20 ��������
%   ������ ������ ������ ��� ������������ ����������

windows = zeros(0, 2);
%   �������� ������ � ���������� �����
steps_number = length(steps);
%   ���������� �������� �� ���������� ����, �������������� ������ 0
previous_steps_counts = 0;
%   ���������� ������ � �����
for i = 1:steps_number
%   ����������, ��������� �� ���� � ���, ���� ��� - ��� ����� ��������
%   ����� ���������. � ��������� ������ ������������, ������� ����
%   ���������� � ��� ���������
    if steps(i, 1) <= window_size
        windows_length = 1;
    else
        windows_length = fix((steps(i, 1) - window_size) / lag) + 2;
    end
%   ���������� ������� ����
    for j = 1:windows_length
%   ������������ � ����� �������� ����
        if j == 1 && i == 1
            a = 1 + previous_steps_counts;
        elseif j == 1 && i ~= 1
            a = previous_steps_counts;
        else
            a = a + lag;
        end
%   ������������ � ������ �������� ����
        if (a + window_size - previous_steps_counts) > steps(i, 1)
            b = steps(i, 1) + previous_steps_counts;
        else
            b = a + window_size;
        end
%   ��������� �������� ������ ����
        windows(end + 1, 1) = a;
        windows(end, 2) = b;
    end
    previous_steps_counts = previous_steps_counts + steps(i, 1);
end
end

