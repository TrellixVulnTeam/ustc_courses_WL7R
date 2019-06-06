function [img_2] = myHisteq(img_1, n)
%% �����������ʹ�õĶ��� uint8�͵�����
size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w, 'uint8');

% ��������������ֱ��ͼ���⻯���ܴ���
%% ͳ��ͼ���ֱ��ͼ
stat = zeros(256, 1);
for i = 1: h
    for j = 1: w
        value = img_1(i, j);
        stat(value + 1, 1) = stat(value + 1, 1) + 1;
    end
end
assert(sum(stat(:)) == h * w);
%% ʹ��ͳ�Ƶ�����ֱ��ͼ�� ����ͳ��ֱ��ͼ����ͼ��
for i = 1: h
    for j = 1: w
        % ���õĺ����������ж���
        img_2(i, j) = myDecimalIntegral(stat, img_1(i, j), h * w, n);
    end
end
%% img_2 = im2uint8(img_2); ����ͳ�������� double ת int ���Զ����� im2uint8
end


function result = myDecimalIntegral(stat, lastValue, sumOfNumber, n)
%% ����lastValue ֮ǰ�ۻ��ĻҶȵ����
sum = 0;
for x = 1: lastValue + 1
    sum = sum + stat(x, 1);
end
%% ����֮ǰ���ֵĻҶȵ���� �������µĻҶ�ֵ
if n == 2
    % ���ﵥ��д, ��Ϊ����2���Ҷ�ͼ�� �ķֱ��������, 0 ��255 ������0 ��127
    result = round(sum / sumOfNumber) * 255;
else
    result = floor(sum / sumOfNumber * n) * (256 / n);
end
result = max(0, min(255, result));
end
