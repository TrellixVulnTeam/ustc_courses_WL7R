function [img_2] = nearest(img_1, n)
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
for x = 1: h_2
    for y = 1: w_2
        %% ��ȡ������ص���ԭͼ�����꣬ �Լ�������������ֺ�С������
        i = floor(x / n);
        j = floor(y / n);
        u = x / n - i;
        v = y / n - j;
        %% Ѱ��ԭͼ���������������ĵ� ����ʹ��min��max����ֹ��Ե����Խ�����
        if u < 0.5 && v < 0.5
            img_2(x, y) = img_1(min(max(i, 1), h_1), min(max(j, 1), w_1));
        elseif u >= 0.5 && v < 0.5
            img_2(x, y) = img_1(min(max(i + 1, 1), h_1), min(max(j, 1), w_1));
        elseif u < 0.5 && v >= 0.5
            img_2(x, y) = img_1(min(max(i, 1), h_1), min(max(j + 1, 1), w_1));
        else
            img_2(x, y) = img_1(min(max(i + 1, 1), h_1), min(max(j + 1, 1), w_1));
        end
    end
end
%% ���ｫ�Ҷ�ֵ��0��1��double �䵽��0��255 ��int��
img_2 = im2uint8(img_2);
end


