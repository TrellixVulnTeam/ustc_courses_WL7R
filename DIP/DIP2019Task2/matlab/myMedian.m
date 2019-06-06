function [img_2] = myMedian(img_1)
img_1 = im2double(img_1);
%% ������ֵ�˲�4��
for i = 1: 4
    img_1 = getOnce(img_1);
end
img_2 = img_1;
img_2 = im2uint8(img_2);        
end

%% ����ĺ�����һ�εľ�ֵ�˲�
function img_2 = getOnce(img_1)
size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);
data = zeros(3, 3);
for i = 1: h
    for j = 1: w
        %% ��������Χ��9�����ص��λ�ã� ����ʹ��min��max����ֹ��Ե����Խ������൱���ǽ���ֵ��padding
        for a = 1:3
            for b = 1:3
                data(a, b) = img_1(min(max(i - 2 + a, 1), h), min(max(j - 2 + b, 1), w));
            end
        end
        %% ȡ9 �����ص����ֵ
        img_2(i, j) = median(data(:));
    end
end
end


