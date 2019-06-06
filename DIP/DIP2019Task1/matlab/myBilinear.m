function [img_2] = bilinear(img_1, n)
%% ���ｫͼ��ĻҶ�ֵ��С��255 ��int �����0��1 ��double
img_1 = im2double(img_1);
%% ��ȡ�µ�ͼ��ĳߴ�
size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);
%% ���µ�ͼ���ÿ�����ص�ĻҶ�ֵ���и�ֵ
for x = 1: w_2
    for y = 1: h_2
        %% ��ȡ������ص���ԭͼ�����꣬ �Լ�������������ֺ�С������
        i = floor(x / n);
        j = floor(y / n);
        u = x / n - i;
        v = y / n - j;
        i = max(i, 1);
        i = min(i + 1, h_1) - 1;
        j = max(j, 1);
        j = min(j + 1, w_1) - 1;
        %% ʹ����Χ4���������ص���в�ֵ ����ʹ��min��max����ֹ��Ե����Խ�����
        img_2(x, y) = (1-u) * (1-v) * img_1(i, j)...
            + (1-u) * v * img_1(i, j+1)...
            + u * (1-v) * img_1(i+1, j)...
            + u * v * img_1(i+1, j+1);
    end
end
%% ���ｫ�Ҷ�ֵ��0��1��double �䵽��0��255 ��int��
img_2 = im2uint8(img_2);
end

