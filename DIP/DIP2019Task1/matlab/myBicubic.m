function [img_2] = bicubic(img_1, n)
%% ���ｫͼ��ĻҶ�ֵ��С��255 ��int �����0��1 ��double
img_1 = im2double(img_1);
%% ��ȡ�µ�ͼ��ĳߴ�
size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);
D = zeros(4, 4);
%% ���µ�ͼ���ÿ�����ص�ĻҶ�ֵ���и�ֵ
for x = 1: w_2
    for y = 1: h_2
        %% ��ȡ������ص���ԭͼ�����꣬ �Լ�������������ֺ�С������
        i = floor(x / n);
        j = floor(y / n);
        u = x / n - i;
        v = y / n - j;
        %% ������16���������ص��ϵ��������bicubic������ getWeight������ʵ��������
        W = getWeight(u, v);
        %% ��������Χ��16�����ص��λ�ã� ����ʹ��min��max����ֹ��Ե����Խ�����
        for a = 1:4
            for b = 1:4
                D(a, b) = img_1(min(max(i - 2 + a, 1), h_1), min(max(j - 2 + b, 1), w_1));
            end
        end
        %% ����ϵ����16����Χ���ص�������� Ȼ�����
        img_2(x, y) = sum(sum(W.* D)); %% ע������ʹ�õ��ǵ��
    end
end
%% ���ｫ�Ҷ�ֵ��0��1��double �䵽��0��255 ��int��
img_2 = im2uint8(img_2);
end

function weight = getWeight(u, v)
weight = zeros(4, 4);
x_weight = zeros(4, 1);
y_weight = zeros(1, 4);
%% ��x�� ��y ����ֱ����ϵ���� ��������һ�� ���õ�Bic�����������ж���
for i = 1: 4
    d = abs(u + 2 - i);
    x_weight(i, 1) = Bic(d);
end
for j = 1: 4
    d = abs(v + 2 - j);
    y_weight(1, j) = Bic(d);
end
weight = x_weight* y_weight;
end

function w = Bic(d)
%% bicubic��������ѧ���壬 �������a ���� -1
a = - 1;
if d <= 1
    w = 1 - (a + 3) * d ^ 2 + (a + 2) * d ^ 3;
elseif d > 1 && d < 2
    w = -4 * a + 8 * a * d - 5 * a * d ^ 2 + a * d ^ 3; 
else
    w = 0;
end
end
