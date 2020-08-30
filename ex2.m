% �����Ŀ¼
clc
clear
time = 103;
data = xlsread("C:\Users\Freak\Desktop\try  (1).xlsx");
% ����ѭ����������
T = data(1:end,2:5)';
Loss = data(1:end,6:10)';
time = 103-0;
%%
t = zeros(time,6);
for ki = 1:time
    t(ki,:) = [T(1,ki),T(2,ki),T(3,ki),T(4,ki),Loss(1,ki),Loss(5,ki)];
end

%%
j = 1;v = 1;trace1 = [];trace2 = [];
while j<=4
    i = 1;
    k = zeros(6,time-1);
    while i<=time-2
        p1 = eye(6,6)*100000;
        m{1}(j,:) = zeros(1,4);
        n{1}(j,:) = zeros(1,5);
        y = t(i+2,j);
        hk = t(i+1,:);
        K = (p1*hk')/(v+hk*p1*hk');
        p1 = (eye-K*hk)*p1/v;
        k(:,i+1) = k(:,i)+K*(y-hk*k(:,i)); 
        trace{i} = p1;
        trace1{i} = K;
        
        % ��ʽ4(ֻ��P,����K)
%         y2 = t(i+2,j);
%         hk2 = t(i+1,:);
%         p1 = (p1-p1*hk2'*hk2*p1/(v+hk2*p1*hk2'))/v;
%         k(:,i+1) = k(:,i)+p1*hk2'*(y2-hk2*k(:,i)); 
%         trace{i} = p1;

%         m{i+1}(j,:) = [k(1,i),k(2,i),k(3,i),k(4,i),k(5,i),k(6,i),k(7,i),k(8,i)];
%         n{i+1}(j,:) = [k(9,i),k(10,i),k(11,i),k(12,i),k(13,i),k(14,i),0,0,k(15,i)];
        m{i+1}(j,:) = [k(1,i+1),k(2,i+1),k(3,i+1),k(4,i+1)];
        n{i+1}(j,:) = [k(5,i+1),0,0,0,k(6,i+1)];

        i = i+1;
    end
    j = j+1;
end

%%
T1 = zeros(4,time);
T1(:,1) = [50;50;50;50];
% T(:,1) = [52;80;93;91;3;4;57;57]; 
% T(:,1) = ((100-10).*rand(8,1)+10);

for j = 1:time-1
    Tem = [T1(1,j);T1(2,j);T1(3,j);T1(4,j)];
    U = [Loss(1,j);Loss(2,j);Loss(3,j);Loss(4,j);Loss(5,j)];
    % ���������ʵʱ���ݣ��Ŷ�Ӧ����ȥ��
%     U = U+U.*(-0.1+(0.1--0.1)*rand(1,1));% �������˫��10%���Ŷ�
    L = j;
    A = m{1,L};B = n{1,L};
    T1(1,j+1) = A(1,:)*Tem+B(1,:)*U;
    T1(2,j+1) = A(2,:)*Tem+B(2,:)*U;
    T1(3,j+1) = A(3,:)*Tem+B(3,:)*U;
    T1(4,j+1) = A(4,:)*Tem+B(4,:)*U;
end 

err = abs(T1-T);
%% �����������
for i=1:4
    figure(i);
    plot(T1(i,:));
    hold on
    plot(T(i,:));
    xlabel('ʱ��'); ylabel('�¶�');
    title(['T(',num2str(i),')']);
    grid on;
    legend('��ֵ','Ԥ��ֵ');
end

err = T-T1;

a = zeros(1,time-1);
b = zeros(1,time-1);
% ��������aԪ�ر仯����
% p = 1;
% for k=1:4  % ��
%     for j=1:4   % ��
%         for i=1:time-1
%             a(j,i) = m{1,i}(k,j);
%         end
%         if j==1
%             figure(p+4);
%             plot(a(j,:));
%             p = p+1;
%         end
%     end
% end

% ��������bԪ�ر仯����
% for k=1:8   % ��
%     for j=1:9    % ��
%         for i=1:3534
%             b(j,i) = n{1,i}(k,j);
%         end
%         if j==9
%             figure(p+16);
%             plot(b(j,:));
%             p = p+1;
%         end
%     end
% end

% b = zeros(15,3535);
% % ����K��Ԫ�ر仯����
% for k=1:15   % ��
%     for i=1:3533
%         b(k,i) = trace1{1,i}(k,1);
%     end
%     figure(k);
%     plot(b(k,:));
% end

