function [ counts ] = counts_greater_than( data, lower_limit )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   �������� ���������� �����, �� ���� �����
rows = length(data);
%   ��������� ������� � ������������ � ����
counts = 0; 
%   ��������� ����. � ����� ���������� �� �������� ��������
%   �������-������� � � ������ ���������� i-�� ��������� ������ �������
%   ������������� �������� ��������.
for i = 1:rows
    if data(i, 1) >= lower_limit
        counts = counts + 1;
    end
end
end

