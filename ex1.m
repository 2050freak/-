% �����Ŀ¼
clc
clear
%%
begin = 9;
time = 103-begin+1;
data = xlsread("D:\rili\20200721\try  (1).xlsx");
% ����ѭ����������
T_initial = data(1:end,2:5)';
Loss_initial = data(1:end,6:10)';

T = data(begin:end,2:5)';
Loss = data(begin:end,6:10)';


%% ������ϳ�����A��B
A = zeros(4,4);  % ��ʼ��ϵͳ����A
B = zeros(4,5);    % ��ʼ���������B
% ��1��
for j = 1:4
    a = zeros(time-1,6);
    b = zeros(time-1,1);
    for i=1:time-1
        a(i,:) = [T(1,i),T(2,i),T(3,i),T(4,i),Loss(1,i),Loss(5,i)];
        b(i,:) = [T(j,i+1)];
    end
    k = pinv(a'*a)*(a'*b);
    A(j,:) = [k(1),k(2),k(3),k(4)];
    B(j,:) = [k(5),0,0,0,k(6)];
end

% [cA,cB] = d2c(A,B,1);
%% ��֤��ϳ���A��B�Ľ��
T1 = zeros(4,103);  % ��ʼ���¶�Ԥ��ֵ

T1(:,1) = [30;30;39;39]; 

for j = 1:103-1
    Tem = [T1(1,j);T1(2,j);T1(3,j);T1(4,j)];
    U = [Loss_initial(1,j);Loss_initial(2,j);Loss_initial(3,j);Loss_initial(4,j);Loss_initial(5,j)];
    T1(1,j+1) = A(1,:)*Tem+B(1,:)*U;
    T1(2,j+1) = A(2,:)*Tem+B(2,:)*U;
    T1(3,j+1) = A(3,:)*Tem+B(3,:)*U;
    T1(4,j+1) = A(4,:)*Tem+B(4,:)*U;
end 
err = abs(T_initial-T1);
%% ��A��B������������������
% [CA,CB] = d2c(A,B,1);
% save('ABNEDC.mat','CA','CB');
%% �����������
for i=1:4
    figure(i);
    plot(T_initial(i,:));
    hold on
    plot(T1(i,:));
    xlabel('ʱ��'); ylabel('�¶�');
    title(['T(',num2str(i),')']);
    grid on;
    legend('��ֵ','Ԥ��ֵ');
end



