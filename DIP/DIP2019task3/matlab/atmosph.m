function [H, im_blured] = atmosph(img)

[M,N] = size(img);

% ��������ģ���˻�����
k = 0.0025;
[u,v]=meshgrid(1:M,1:N);    % ���ɶ�ά����ϵ
H=exp(-k* ( (u-M/2).^2+(v-N/2).^2).^(5/6) );

im_double = mat2gray(img,[0 255]);
im_F = fftshift(fft2(im_double));      % ���� > Ƶ�� ? ������ʲô��˼�Ҳ��Ǻ�����
im_blured_F = im_F .* H;    % �˻�����
im_blured_double = real(ifft2(ifftshift(im_blured_F)));    % Ƶ�� > ����
im_blured = im2uint8(mat2gray(im_blured_double));