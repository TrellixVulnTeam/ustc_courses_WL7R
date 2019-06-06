%% �������:
% ���˶�ģ���ͼ���������Ⱦ���˻����� motionblur.m 
% ȫ���˲�/�뾶�������˲����� my_inverse.m
% ά���˲����� wiener.m 
%% ���� main_exp5_29.m ����˲����Ч��

clc;
clear;
close all;

%% �α�ͼ 5.29
% ��ȡͼƬ
im = imread('demo-2.jpg');   % ԭʼͼ�� 688x688 uint8

%% ͼ���˻����˶�ģ��+��˹������
sigma = 0.01
[H, im1_f] = motionblur(im, sigma);        % ��������=0.01
[~, im2_f] = motionblur(im, sigma*0.1);        
[~, im3_f] = motionblur(im, sigma*0.00001);        % H���˻�ģ��

%% ȫ���˲����뾶�������˲�
D0 = 33;    % �뾶
[~, im1_inverse] = my_inverse(im1_f, H, D0);
[~, im2_inverse] = my_inverse(im2_f, H, D0);
[~, im3_inverse] = my_inverse(im3_f, H, D0);
% [im1_inverse, ~] = my_inverse(im1_f, H, D0);
% [im2_inverse, ~] = my_inverse(im2_f, H, D0);
% [im3_inverse, ~] = my_inverse(im3_f, H, D0);

%% ά���˲�
K = 0.0001;
im1_wiener = my_wiener(im1_f, H, K);
im2_wiener = my_wiener(im2_f, H, K);
im3_wiener = my_wiener(im3_f, H, K);

%% ��ʾ���
figure(1); 
subplot(331); imshow(im1_f); title('�˶�ģ��+��������(sigma)'); axis on
subplot(332); imshow(im1_inverse); title('���˲����'); axis on
subplot(333); imshow(im1_wiener); title('ά���˲����'); axis on
subplot(334); imshow(im2_f); title('�˶�ģ��+��������(sigma*0.1)'); axis on
subplot(335); imshow(im2_inverse); title('���˲����'); axis on
subplot(336); imshow(im2_wiener); title('ά���˲����'); axis on
subplot(337); imshow(im3_f); title('�˶�ģ��+��������(sigma*0.00001)'); axis on
subplot(338); imshow(im3_inverse); title('���˲����'); axis on
subplot(339); imshow(im3_wiener); title('ά���˲����'); axis on
