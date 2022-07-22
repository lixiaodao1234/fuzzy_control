clear;clc;
%定义输入和输出变量及隶属度函数
a=newfis('simple');
%addvar:在FIS里添加语言变量
a=addvar(a,'input','e',[-3 3]);
%addmf:将隶属度函数添加到FIS
%要添加隶属度函数的
%2：变量类型 3：变量编号 4：变量名 5：新隶属度函数的类型 6：指定隶属度函数的参数向量
a=addmf(a,'input',1,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'input',1,'NM','trimf',[-3,-2,-1]);  %负大、负小、0、正小、正大
a=addmf(a,'input',1,'NB','trimf',[-2,-1,0]);
a=addmf(a,'input',1,'ZR','trimf',[-1,0,1]);
a=addmf(a,'input',1,'PS','trimf',[0,1,2]);
a=addmf(a,'input',1,'PM','trimf',[1,2,3]);
a=addmf(a,'input',1,'PB','trimf',[2,3,3]); %trapmf
%trimf:三角形隶属度函数（3个参数）    trapmf：梯形隶属度函数（4个参数）

%误差E的微分
a=addvar(a,'input','de',[-3 3]);
a=addmf(a,'input',2,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'input',2,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'input',2,'NB','trimf',[-2,-1,0]);
a=addmf(a,'input',2,'ZR','trimf',[-1,0,1]);
a=addmf(a,'input',2,'PS','trimf',[0,1,2]);
a=addmf(a,'input',2,'PM','trimf',[1,2,3]);
a=addmf(a,'input',2,'PB','trimf',[2,3,3]);

%控制量
a=addvar(a,'output','u',[-3 3]);
a=addmf(a,'output',1,'NS','trimf',[-3,-3,-2]);
a=addmf(a,'output',1,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'output',1,'NB','trimf',[-2,-1,0]);
a=addmf(a,'output',1,'ZR','trimf',[-1,0,1]);
a=addmf(a,'output',1,'PS','trimf',[0,1,2]);
a=addmf(a,'output',1,'PM','trimf',[1,2,3]);
a=addmf(a,'output',1,'PB','trimf',[2,3,3]);
figure();%plotmf(a,'input',1);  %绘制隶属度函数

%规则表：参数1：input1(PB/PS/ZO/NS/NB依次对应1-5)  参数2：input2  参数3：output
%参数4：该条规则的权重  参数5：AND模糊运算(1对应AND，2对应OR)
rulelist = [1 7 3 1 1;
    1 6 3 1 1;
    1 5 2 1 1;
    1 4 1 1 1;
    1 3 1 1 1;
    1 2 1 1 1;
    1 1 1 1 1;
    2 7 3 1 1;
    2 6 3 1 1;
    2 5 3 1 1;
    2 4 2 1 1;
    2 3 1 1 1;
    2 2 1 1 1;
    2 1 1 1 1;
    3 7 3 1 1;
    3 6 3 1 1;
    3 5 3 1 1;
    3 4 3 1 1;
    3 3 2 1 1;
    3 2 1 1 1;
    3 1 1 1 1;
    4 7 5 1 1;
    4 6 5 1 1;
    4 5 5 1 1;
    4 4 4 1 1;
    4 3 3 1 1;
    4 2 3 1 1;
    4 1 3 1 1;
    5 7 7 1 1;
    5 6 7 1 1;
    5 5 6 1 1;
    5 4 5 1 1;
    5 3 5 1 1;
    5 2 5 1 1;
    5 1 5 1 1;
    6 7 7 1 1;
    6 6 7 1 1;
    6 5 7 1 1;
    6 4 6 1 1;
    6 3 5 1 1;
    6 2 5 1 1;
    6 1 5 1 1;
    7 7 7 1 1;
    7 6 7 1 1;
    7 5 7 1 1;
    7 4 7 1 1;
    7 3 6 1 1;
    7 2 5 1 1;
    7 1 5 1 1];
a=addrule(a,rulelist);        %把规则添加进去

%采用模糊控制器的二阶系统仿真
%被控系统建模
ts = 0.001;                   %采样时间
sys = tf(2.95,[0.174,1,0]);
dsys = c2d(sys,ts,'z');       %传函离散形式
[num,den] = tfdata(dsys,'v'); %离散后提取分子分母（其实自己也可以算）
n = 5000;                     %每1000代表1秒
ke = 3/1500;
kde = 3/1500;
ku = 500;                  %350为最大控制量
r = 1500;

%初始参数
y(1) = 0;
e(1) = r-y(1);
ec = 0;
u(1) = 0;

%第一次运行
y(2) = -den(2)*y(1)+num(2)*u(1);  %系统前二时刻输出
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
u(2) = ku*evalfis([em,ecm],a);


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
    u(i) = ku*evalfis([em,ecm],a);
end
target = ones(1,n)*r;
plot(y);
hold on;
plot(target);
disp("最后的误差");
min = target(n) - y(n)