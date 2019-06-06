function [H, im_blured] = motionblur(img, sigma)
[M,N] = size(img);
% �˶�ģ���˻�����

%% ��������
H_moved = zeros(M, N);
H_gaussian = zeros(M, N);
H = zeros(M, N);
a = 0.1;
b = 0.1;
T = 1;
K = 0.01 * sigma;
alpha = 0.0001;
%% �����˻�����
for u = 1: M
    for v = 1: N
        tmp = pi .* ((u  - M ./ 2) .* a + (v - N ./ 2) .* b);
        % �����ֹ��Ƶ������֮���H���˻��������в�����������
        if abs(tmp) < 0.1
            tmp = 0.1;
        end
        tmp2 = (u - M ./ 2).^2 + (v - N ./ 2).^2;
        % �����ֹ��Ƶ������֮���H���˻��������в�����������
        if abs(tmp2) < 0.1
            tmp2 = 0.1;
        end
        H_moved(u, v) = (T ./ tmp) .* sin(tmp) .* exp(-i .* tmp);
        H_gaussian(u, v) = K .* exp(-alpha .* tmp2);
    end
end

%% ʹ���˻�������ͼ�����ģ�������� 
im_double = mat2gray(img,[0 255]);
im_F = fftshift(fft2(im_double));      % ���� > Ƶ�� 
im_blured_F = im_F .* H_moved .* H_gaussian;    % �˻�
im_blured_double = real(ifft2(ifftshift(im_blured_F)));    % Ƶ�� > ����
im_blured = im2uint8(mat2gray(im_blured_double));
H = H_moved .* H_gaussian;


