function [ b_value ] = b_value_accumulative( steps, magnitudes )
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

%   �������� ������ � ���������� �����
steps_number = length(steps);
%   �������� ���������� �����
rows = length(magnitudes);
%   ������ ������� ������� ����� ������� ������� ��� �������� b-value.
%   �������� ��� �������� ������� ������. �� ������� ���� �������,
%   ��� ������ ��� �������� ����� ������� � ��������� �������� � �����.
b_value = zeros(rows, 1);
%   ����� ������� ������ ��� 0,023 �. ��� ����� ����������� ���������?
treshold_amplitude = 0.023;
treshold_magnitude = log10(treshold_amplitude);
%   ���������� �����, ������� � ��������� (log10(e))
e = exp(1);
logarithm_e = log10(e);
%   ������ �������, ��� ��������� ���������� ������
counter = 1;
%   ������ ������, ��� �������� ������ ����
buff = 1;
%   �������� ���� �������� �� �����
for i = 1:steps_number
%   ������������ �������� Ib-value �� ������� ����
    for j = 1:steps(i, 1)
        mean_magnitude_j = mean(magnitudes(buff:counter, 1));
        b = logarithm_e / (mean_magnitude_j - treshold_magnitude);
        if isnan(b) || ~isfinite(b)
            b_value(counter, 1) = 0;
        else
            b_value(counter, 1) = b;
        end
        counter = counter + 1;
    end
    buff = buff + steps(i, 1);
end
end

