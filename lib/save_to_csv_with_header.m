function [ status ] = save_to_csv_with_header( path, filename, header, data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   ������ ���� � ��������� ��� � ������� �� ������
file = strcat(path, filename, '.csv');
fid = fopen(file , 'w');
%   ���������� ��������� ��� ���������� ������
fixed_header = strjoin(header, ';');
%   ���������� ��������� � ����
%fprintf(fid, '%s,', header{1,1:end-1});
%fprintf(fid, '%s\n', header{1,end});
fprintf(fid, '%s\n', fixed_header);
%   ��������� �������, ��������� ����
fclose(fid);
%   ���������� ������� � ����
dlmwrite(file, data,';');
dlmwrite(file, data,'-append');
status = 1;
end