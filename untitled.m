clear;
clc;
close all;

% ==================================================
% シミュレーション条件
% ==================================================
mass = 1.0;       % 質量 [kg]
spring_constant = 4.0;       % ばね定数 [N/m]
external_force = 1.0;       % ステップ外力 [N]

time_step = 0.001;    % 時間刻み [s]
time_end = 10.0;  % シミュレーション終了時間 [s]
time = 0:time_step:time_end;

% 動粘性係数 C [Ns/m]
C_list = [0.1 0.5 1.0 4.0 6.0 8.0 9.0];

% ==================================================
% 2. 実験条件をコマンドウィンドウに表示
% ==================================================
disp('==========================================');
disp('質量－ばね－ダンパ系 2次遅れ系シミュレーション');
disp('==========================================');
fprintf('質量 M          = %.2f [kg]\n', mass);
fprintf('ばね定数 K      = %.2f [N/m]\n', spring_constant);
fprintf('外力 F          = %.2f [N]\n', external_force);
fprintf('時間刻み dt     = %.4f [s]\n', time_step);
fprintf('計算時間        = %.2f [s]\n', time_end);
disp('動粘性係数 C [Ns/m]');
disp(C_list);
disp(' ');

% ==================================================
% 3. Cを変化させてシミュレーション
% ==================================================
for n = 1:length(C_list)

    C = C_list(n);

    % -----------------------------
    % 初期値
    % -----------------------------
    x = zeros(size(time));   % 変位 [m]
    v = zeros(size(time));   % 速度 [m/s]
    a = zeros(size(time));   % 加速度 [m/s^2]

    x(1) = 0.0;           % 初期変位 [m]
    v(1) = 0.0;           % 初期速度 [m/s]
    a(1) = 0.0;           % 初期加速度 [m/s^2]

    % -----------------------------
    % 数値計算
    % 運動方程式：
    % F = M*a + C*v + K*x
    %
    % よって、
    % a = (F - C*v - K*x) / M
    % -----------------------------
    for i = 1:length(time)-1

        a(i) = (external_force - C*v(i) - spring_constant*x(i)) / mass;

        % オイラー法による更新
        v(i+1) = v(i) + a(i)*time_step;
        x(i+1) = x(i) + v(i)*time_step;

    end

    % 最後の加速度
    a(end) = (external_force - C*v(end) - spring_constant*x(end)) / mass;
    % -----------------------------
    % figureをCごとに分けて表示
    % -----------------------------
    figure(n);
    plot(time, x, 'LineWidth', 1.5);
    grid on;

    xlabel('時間 [s]');
    ylabel('変位 x(t) [m]');

    title(['質量－ばね－ダンパ系の応答  C = ' num2str(C) ' [Ns/m]']);

    % グラフ中に条件を表示
    text(6.0, 0.05, ...
        {['M = ' num2str(mass) ' kg'], ...
         ['K = ' num2str(spring_constant) ' N/m'], ...
         ['F = ' num2str(external_force) ' N'], ...
         ['C = ' num2str(C) ' Ns/m'], ...
         }, ...
         'FontSize', 10);
    filename = ['response_C_' num2str(C) '.png'];
    saveas(gcf, filename);
end