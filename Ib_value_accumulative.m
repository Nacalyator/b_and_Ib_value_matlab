function [ Ib_value ] = Ib_value_accumulative( steps, magnitudes )
%UNTITLED9 Summary of this function goes here
%   ��������� ���������� �����
%   �������� ������ � ���������� �����
steps_number = length(steps);
%   �������� ���������� �����
rows = length(magnitudes);
%   ������ ������� ������� ����� ������� ������� ��� �������� b-value.
Ib_value = zeros(rows, 1);
%   ����� ��������� ������ � ������� ������ ���������
%   �������� ������ �������������, ������ ������� ��������
alfa1 = 1;
alfa2 = 1;
%   ������ �������, ��� ��������� ���������� ������
counter = 1;
%   ������ ������, ��� �������� ������ ����
buff = 1;
%   �������� ���� �������� �� �����
for i = 1:steps_number
%   ������������ �������� Ib-value �� ������� ����
    for j = 1:steps(i, 1)
        %   ���������� ������ �������
        %   ������������ ������� �������� ��������� �� i-�� �������
        mean_magnitude_j = mean(magnitudes(buff:counter, 1));
        %   ������������ ������������ ���������� ��������� � i-�� ����
        sigma = std(magnitudes(buff:counter, 1));
        %   ������������ ������� � ������� ��������� �������� ��������
        w1 = mean_magnitude_j - (alfa1 * sigma);
        w2 = mean_magnitude_j + (alfa2 * sigma);
        %   ������������ ���������� �������� � ���������� ����� ������ �������
        N_w1 = counts_greater_than(magnitudes(buff:counter, 1), w1);
        N_w2 = counts_greater_than(magnitudes(buff:counter, 1), w2);
        %   ������������ �������� Ib-value � i-�� �������
        Ib = (log10(N_w1) - log10(N_w2)) / ((alfa1 + alfa2) * sigma);
        if isnan(Ib) || ~isfinite(Ib)
            Ib_value(counter, 1) = 0;
        else
            Ib_value(counter, 1) = Ib;
        end
        counter = counter + 1;
    end
    buff = buff + steps(i, 1);
end
end

