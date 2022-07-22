%ģ��PID�����E�����EC��Ϊ���룬���kp��ki��kd��������
%���ʻ���һ��pid��������ֻ�ǲ������Զ�����

clear;clc;
%�����������������������Ⱥ���
a=newfis('simple');
%addvar:��FIS��������Ա���
a=addvar(a,'input','e',[-3 3]);
%addmf:�������Ⱥ�����ӵ�FIS
%Ҫ��������Ⱥ�����
%2���������� 3��������� 4�������� 5���������Ⱥ��������� 6��ָ�������Ⱥ����Ĳ�������
a=addmf(a,'input',1,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'input',1,'NM','trimf',[-3,-2,-1]);  %���󡢸�С��0����С������
a=addmf(a,'input',1,'NB','trimf',[-2,-1,0]);
a=addmf(a,'input',1,'ZR','trimf',[-1,0,1]);
a=addmf(a,'input',1,'PS','trimf',[0,1,2]);
a=addmf(a,'input',1,'PM','trimf',[1,2,3]);
a=addmf(a,'input',1,'PB','trimf',[2,3,3]); %trapmf
%trimf:�����������Ⱥ�����3��������    trapmf�����������Ⱥ�����4��������

%���E��΢��
a=addvar(a,'input','de',[-3 3]);
a=addmf(a,'input',2,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'input',2,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'input',2,'NB','trimf',[-2,-1,0]);
a=addmf(a,'input',2,'ZR','trimf',[-1,0,1]);
a=addmf(a,'input',2,'PS','trimf',[0,1,2]);
a=addmf(a,'input',2,'PM','trimf',[1,2,3]);
a=addmf(a,'input',2,'PB','trimf',[2,3,3]);

%������kp
a=addvar(a,'output','kp',[-3 3]);
a=addmf(a,'output',1,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'output',1,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'output',1,'NB','trimf',[-2,-1,0]);
a=addmf(a,'output',1,'ZR','trimf',[-1,0,1]);
a=addmf(a,'output',1,'PS','trimf',[0,1,2]);
a=addmf(a,'output',1,'PM','trimf',[1,2,3]);
a=addmf(a,'output',1,'PB','trimf',[2,3,3]);
figure();%plotmf(a,'input',1);  %���������Ⱥ���
%������ki
a=addvar(a,'output','ki',[-3 3]);
a=addmf(a,'output',2,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'output',2,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'output',2,'NB','trimf',[-2,-1,0]);
a=addmf(a,'output',2,'ZR','trimf',[-1,0,1]);
a=addmf(a,'output',2,'PS','trimf',[0,1,2]);
a=addmf(a,'output',2,'PM','trimf',[1,2,3]);
a=addmf(a,'output',2,'PB','trimf',[2,3,3]);
%������kd
a=addvar(a,'output','kd',[-3 3]);
a=addmf(a,'output',3,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'output',3,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'output',3,'NB','trimf',[-2,-1,0]);
a=addmf(a,'output',3,'ZR','trimf',[-1,0,1]);
a=addmf(a,'output',3,'PS','trimf',[0,1,2]);
a=addmf(a,'output',3,'PM','trimf',[1,2,3]);
a=addmf(a,'output',3,'PB','trimf',[2,3,3]);
%���������1��input1(PB/PS/ZO/NS/NB���ζ�Ӧ1-5)  ����2��input2  ����3��output
%����4��ANDģ������(1��ӦAND��2��ӦOR)
rulelist = [1 1 7 1 5 1 1;
1 2 7 1 5 1 1;
1 3 6 1 4 1 1;
1 4 6 2 4 1 1;
1 5 5 2 4 1 1;
1 6 5 4 7 1 1;
1 7 4 4 7 1 1;
2 1 7 1 3 1 1;
2 2 7 1 3 1 1;
2 3 6 2 3 1 1;
2 4 6 2 3 1 1;
2 5 5 3 4 1 1;
2 6 4 4 3 1 1;
2 7 4 4 6 1 1;
3 1 6 2 1 1 1;
3 2 6 2 1 1 1;
3 3 6 3 2 1 1;
3 4 5 3 3 1 1;
3 5 4 4 4 1 1;
3 6 3 5 5 1 1;
3 7 2 5 6 1 1;
4 1 6 2 1 1 1;
4 2 5 3 2 1 1;
4 3 5 3 2 1 1;
4 4 4 4 3 1 1;
4 5 3 5 4 1 1;
4 6 2 5 5 1 1;
4 7 2 6 6 1 1;
5 1 5 3 1 1 1;
5 2 5 3 2 1 1;
5 3 4 4 3 1 1;
5 4 3 5 3 1 1;
5 5 3 5 4 1 1;
5 6 2 6 5 1 1;
5 7 2 6 5 1 1;
6 1 4 4 2 1 1;
6 2 4 4 3 1 1;
6 3 3 5 3 1 1;
6 4 2 6 3 1 1;
6 5 2 6 4 1 1;
6 6 2 7 5 1 1;
6 7 1 7 5 1 1;
7 1 4 4 5 1 1;
7 2 3 4 4 1 1;
7 3 3 5 4 1 1;
7 4 2 6 4 1 1;
7 5 2 7 4 1 1;
7 6 1 7 7 1 1;
7 7 1 7 7 1 1];
a=addrule(a,rulelist);        %�ѹ�����ӽ�ȥ

%����ģ���������Ķ���ϵͳ����
ts = 0.001;                   %����ʱ��
sys = tf(2.95,[0.174,1,0]);
dsys = c2d(sys,ts,'z');       %������ɢ��ʽ
[num,den] = tfdata(dsys,'v'); %��ɢ����ȡ���ӷ�ĸ����ʵ�Լ�Ҳ�����㣩
n = 2000;                     %ÿ1000����1��
ke = 3/1500;   %�������任ϵ��
kde = 3/1500;  %���仯�ʱ任ϵ��
%pid�����任ϵ��
kpc = 90;
kic = -3500;   %�ĳ�-10000�����Ϊ0����Ӧ�ٶ�Ҳ�ܿ졣�����������½��ķ�ΧҲ����Ӧ���
kdc = 0.28;
r = 1500;

%��ʼ����
y(1) = 0;
e(1) = r-y(1);
ec = 0;    %΢��
ecc = 0;   %����
kp = 0;
ki = 0;
kd = 0;
u(1) = 0;

%��һ������
y(2) = -den(2)*y(1)+num(2)*u(1);
e(2) = r-y(2);
em = e(2)*ke;
if em>=3
    em=3;
elseif em<=-3
    em=-3;
end
ec = e(2)-e(1);
ecm = ec*kde;
if ecm>=3
    ecm=3;
elseif ecm<=-3
    ecm=-3;
end
ecc=ecc+e(1)*ts;
%ecc=e(2)-2*e(1);
pid= kpc*evalfis([em,ecm],a);
kp = kpc*pid(1); ki = kic*pid(2); kd = kdc*pid(3);
u(2) = -(kp*e(2)+kd*ec/ts+ki*ecc);  %�����Ÿ�����r-y����y-iȷ��

for i=3:n
    y(i) = -den(2)*y(i-1)-den(3)*y(i-2)+num(2)*u(i-1)+num(3)*u(i-2);
    e(i)=r-y(i);
    em=e(i)*ke;
    ec=e(i)-e(i-1);
    ecm = ec*kde;
    if em>=3
        em=3;
    elseif em<=-3
        em=-3;
    end
    if ecm>=3
        ecm=3;
    elseif ecm<=-3
        ecm=-3;
    end
    ecc=ecc+e(i)*ts;
    %ecc=e(i)-2*e(i-1)+e(i-2);
    pid= kpc*evalfis([em,ecm],a);
    kp = kpc*pid(1); ki = kic*pid(2); kd = kdc*pid(3);
    u(i) = -(kp*e(i)+kd*ec/ts+ki*ecc);
end
target = ones(1,n)*r;
plot(y);
hold on;
plot(target);
disp("�������");
min = target(n) - y(n)