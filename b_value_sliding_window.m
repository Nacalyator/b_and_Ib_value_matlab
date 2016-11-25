function [ b_value_window ] = b_value_sliding_window( windows, magnitudes )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%   ������ ������ �������� b-value ������������ �� �������, ������������
%   ��� � ���� (������� ���-���� ��� Aki-Utsu):
%   b = log10(e) / (M_mean - M_treshold)

%   �������� ������� MLE (Maximum likelihood estimation),
%   ��� ������� ����� ���:
%   b = 1 / (ln(10)*(M_mean - M_treshold))

%   ������ ��� ������� �������� � ���������� ����:
%   b = 0.43 / (M_mean - M_treshold)

%   �������� ������� ������ ������� �������. ��� ����� ���������� ��� �����
b_length = length(windows);
%   ������ ������ �����
b_value_window = zeros(b_length, 1);
%   ����� ������� ������ ��� 0,023 �. ��� ����� ����������� ���������?
treshold_amplitude = 0.023;
treshold_magnitude = log10(treshold_amplitude);
%   ���������� �����, ������� � ��������� (log10(e))
e = exp(1);
logarithm_e = log10(e);

%   ���������� ������ � ������������ �������� b-value
for i = 1:b_length
%   ������������ ������� �������� ��������� i-�� ����
    a = windows(i, 1);
    b = windows(i, 2);
    mean_magnitude_i = mean(magnitudes(a:b, 1));
%   � ��������� ������� ������ �������� 0,43 ������ 8,686
    b = logarithm_e / (mean_magnitude_i - treshold_magnitude);
    if isnan(b) || ~isfinite(b)
        b_value_window(i, 1) = 0;
    else
        b_value_window(i, 1) = b;
    end
end
end

