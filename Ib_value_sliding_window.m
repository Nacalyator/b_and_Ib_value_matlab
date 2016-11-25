function [ Ib_value_window ] = Ib_value_sliding_window( windows, magnitudes )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   �������� ������� ������ ������� �������. ��� ����� ���������� ��� �����
Ib_length = length(windows);
%   ������ ������ �����
Ib_value_window = zeros(Ib_length, 1);
%   ����� ��������� ������ � ������� ������ ���������
%   �������� ������ �������������, ������ ������� ��������
alfa1 = 1;
alfa2 = 1;
%   ������������ �������� Ib-value �� �������� ����
for i = 1:Ib_length
%   ������������ ������� �������� ��������� i-�� ����
    a = windows(i, 1);
    b = windows(i, 2);
    mean_magnitude_i = mean(magnitudes(a:b, 1));
%   ������������ ������������ ���������� ��������� i-�� ����
    sigma = std(magnitudes(a:b, 1));
%   ������������ ������� � ������� ��������� �������� �������� i-�� ����
    w1 = mean_magnitude_i - (alfa1 * sigma);
    w2 = mean_magnitude_i + (alfa2 * sigma);
%   ������������ ���������� �������� � ���������� ����� ������ ������� i-�� ����
    N_w1 = counts_greater_than(magnitudes(a:b, 1), w1);
    N_w2 = counts_greater_than(magnitudes(a:b, 1), w2);
%   ������������ �������� Ib-value i-�� ����
    Ib = (log10(N_w1) - log10(N_w2)) / ((alfa1 + alfa2) * sigma);
    if isnan(Ib) || ~isfinite(Ib)
        Ib_value_window(i, 1) = 0;
    else
        Ib_value_window(i, 1) = Ib;
    end
end

