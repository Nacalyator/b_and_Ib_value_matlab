function [ result ] = searcher(path, ext, filter)
%SEARCHER Summary of this function goes here
%   ������� ��������� ��������� ���� path ('f:\') � ����������
%   �������� ����� ext ('xlsx') � ���������� ������ ������,
%   ��������� ��� ����������� ������ �� ������.
%   
%   ���������� ������ ������ �� ���������� ����� CMD
[status, cmdout] = system(['WHERE /R ' '"' path '"' ' *.' ext]);
%   ���� ������ �������� �� ������� ���������� ��������,
%   �� ���������� ��������� � ��������� ������ �� ������
%   � ������ � ������. ����� ������� ��������� �� ������
if status == 0;
    result = strsplit(my_decoder(cmdout), '\n');
    paths = result.';
    paths(end,:) = []; % ������� ������ ������
else
    disp('Error!');
end
result = cell(0, 1);
all_paths_length = length(paths);
for i = 1:all_paths_length
    contain_filter_word = length(strfind(paths{i, 1}, filter));
    if ~contain_filter_word
        result(end + 1, 1) = paths(i, 1);
    end
end



end


