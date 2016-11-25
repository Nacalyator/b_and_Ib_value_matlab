function calculate_b_Ib_combined_in_xlsx( file, window_size, lag )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%   ������ ��� �������:
%   1 - ����� ���������; 2 - ����� ���� (���� ���� ���);
%   3 - ��������� ���������� ��������; 4 - ���-�� �������� �� ����;
%   6 - ���������
%   �������� ������ � ������������ ��� ������
from_sensor1 = xlsread(file, '������. �������1');
from_sensor2 = xlsread(file, '������. �������2');
%   �������� ���������� �������� �� ������ ���� ���������
steps = get_steps_counts(from_sensor1(:, 4));
%   �������� �������� �������� �� ������������
amplitudes1 = from_sensor1(:, 6);
amplitudes2 = from_sensor2(:, 6);
%   �������� �������� ��������
magnitudes1 = log10(amplitudes1);
magnitudes2 = log10(amplitudes2);
%   �������� ������� ������� �������� � ������� ������� �� �����
times = from_sensor1(:, 1);

%   ������ ���������
headers_list = {'Left time', 'Right time', 'Left index', 'Right index', 'b-value comb1', 'b-value comb2', 'Ib-value comb1', 'Ib-value comb2'};
%   ������������ ����
windows_combined = get_windows_for_combined_method(steps, window_size, lag);
%   ������������ ������������
b_comb1 = b_value_combined(windows_combined, magnitudes1);
b_comb2 = b_value_combined(windows_combined, magnitudes2);
Ib_comb1 = Ib_value_combined(windows_combined, magnitudes1);
Ib_comb2 = Ib_value_combined(windows_combined, magnitudes2);
%   ���������� ������� ��������, ���������� ��������� ����
windows_number = length(windows_combined);
times_left = zeros(length(windows_number), 1);
times_right = times_left;
for w = 1:windows_number
    times_left(w, 1) = times(windows_combined(w, 1), 1);
    times_right(w, 1) = times(windows_combined(w, 2), 1);
end
table = [times_left, times_right, windows_combined(:, 1), windows_combined(:, 2), b_comb1, b_comb2, Ib_comb1, Ib_comb2];

%   ��������� ���������� ����� � �������� ���� Excell � �����
xlswrite(file, headers_list, 'Ib and b comb', 'A1');
xlswrite(file, table, 'Ib and b comb', 'A2');

%   ������� ��������� ��������� � �������
good_news = ['Process for file ' file ' has been finished succesful'];
disp(good_news);

end