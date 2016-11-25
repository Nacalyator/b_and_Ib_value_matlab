function out = my_decoder(in)
rus = [1040:1103 1025 1105]; % ���� ������� ����
if numel(find(rus==max(abs(in))))>0 % ���� ���� ������� �����, �� �� ���� ��������������
    out = in;
else % ������������� �� dos (���������� ����� ��� ���� �� ��������)
    a = unicode2native(in,'windows-1251');
    out = native2unicode(abs(a),'cp-866');
end
