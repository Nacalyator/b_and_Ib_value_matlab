%   �������� ���� �� �������� ����� � �������
root_dir = 'F:\��_����������';
%   �������� ������ ������ � ������ ���������� ������ � �������������
%   ������ � ������� �� ������� ��������
files = searcher(root_dir, 'xlsx', 'loc');
%   ����� �������� �����, �������� �������
%   ���������� ���������� ������
files_counts = length(files);
%   ���������� ������
for i = 1:files_counts
%   ������������ b � Ib �������� � ������ �����
    calculate_b_Ib_combined_in_xlsx(files{i, 1}, 100, 5);
%   ������ �������
    create_b_Ib_combined_plots_from_xlsx(files{i, 1});
end

disp('Well done!');