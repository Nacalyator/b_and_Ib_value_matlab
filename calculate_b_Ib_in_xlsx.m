function calculate_b_Ib_in_xlsx( file, window_size, lag )
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
times_by_steps = from_sensor1(:, 2);


%   b-value � Ib-value �������������
headers_list1 = {'Times', 'Times by steps', 'Counts', 'Counts by steps', 'b-value acc1', 'b-value acc2', 'Ib-value acc1', 'Ib-value acc2'};
counts = from_sensor1(:, 3);
counts_by_steps = from_sensor1(:, 4);
b_acc1 = b_value_accumulative(steps, magnitudes1);
b_acc2 = b_value_accumulative(steps, magnitudes2);
Ib_acc1 = Ib_value_accumulative(steps, magnitudes1);
Ib_acc2 = Ib_value_accumulative(steps, magnitudes2);
table1 = [times, times_by_steps, counts, counts_by_steps, b_acc1, b_acc2, Ib_acc1, Ib_acc2];
%   b-value � Ib-value ������� ����������� ����
headers_list2 = {'Left time', 'Right time', 'Left_windows_limit', 'Right_windows_limit', 'b-value win1', 'b-value win2', 'Ib-value win1', 'Ib-value win2'};
%   �������� ���� ����������� ������� � ������ ����, ��� ���� ��� �������
%   ���� �������� ��������




windows = get_calculation_windows(steps, window_size, lag);
b_win1 = b_value_sliding_window(windows, magnitudes1);
b_win2 = b_value_sliding_window(windows, magnitudes2);
Ib_win1 = Ib_value_sliding_window(windows, magnitudes1);
Ib_win2 = Ib_value_sliding_window(windows, magnitudes2);
%   ���������� ������� ��������, ���������� ��������� ����
windows_number = length(windows);
times_left = zeros(length(windows_number), 1);
times_right = times_left;
for w = 1:windows_number
    times_left(w, 1) = times(windows(w, 1), 1);
    times_right(w, 1) = times(windows(w, 2), 1);
end
table2 = [times_left, times_right, windows(:, 1), windows(:, 2), b_win1(:, 1), b_win2(:, 1), Ib_win1(:, 1), Ib_win2(:, 1)];

%   ��������� ���������� ����� � �������� ���� Excell � �����
xlswrite(file, headers_list1, 'Ib and b acc', 'A1');
xlswrite(file, table1, 'Ib and b acc', 'A2');
xlswrite(file, headers_list2, 'Ib and b win', 'A1');
xlswrite(file, table2, 'Ib and b win', 'A2');

%   ������� ��������� ��������� � �������
good_news = ['Process for file ' file ' has been finished succesful'];
disp(good_news);

end