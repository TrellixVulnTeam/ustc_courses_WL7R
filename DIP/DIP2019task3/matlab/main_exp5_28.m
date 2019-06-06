%% �������:
% ȫ���˲�/�뾶�������˲����� my_inverse.m
% ά���˲����� wiener.m 
%% ���� main_exp5_28.m ����˲����Ч��

clc;
clear;
close all;

%% �α�ͼ 5.28
% ��ȡͼƬ
im = imread('demo-1.jpg');   % ԭʼͼ�� 480x480 uint8

%% ͼ���˻�����������ģ�ͣ�
% Output��H���˻�ģ�ͣ� im_f���˻���ͼƬ��
[H, im_f] = atmosph(im);        

%% ȫ���˲����뾶�������˲�
D0 = 60;
% Input��im_f���˻�ͼƬ��H���˻�ģ�ͣ�D0���뾶��
% Output��im_inverse��ȫ���˲������im_inverse_b���뾶�������˲���
[im_inverse, im_inverse_b] = my_inverse(im_f, H, D0);  

%% ά���˲�
K = 0.0001;
% Input��im_f���˻�ͼƬ��H���˻�ģ�ͣ�K��ά���˲�������
im_wiener = my_wiener(im_f, H, K);

%% ��ʾ���
figure(1); 
subplot(231); imshow(im); title('ԭͼ'); axis on
subplot(232); imshow(im_f); title('��������(k=0.0025)'); axis on
subplot(233); imshow(im_inverse); title('ȫ���˲�'); axis on
subplot(234); imshow(im_inverse_b); title('�뾶���޵����˲�'); axis on
subplot(235); imshow(im_wiener); title('ά���˲�'); axis on
