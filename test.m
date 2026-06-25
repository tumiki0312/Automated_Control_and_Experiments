%
%          自動制御および実験
%          実験資料
%
%          Test（MATLABの復習）
%
%                                                            '25.06.26（木）
%                                                            '26.06.20（土）
%
%
clear
clc
%
% *** パラメータ設定 ***
      t=0:0.01:10;  % 時間　（秒）
      f=1.0;        % 周波数　（Hz）
      a=2.0;
%       
% *** sin及びcosの計算 ***
      y1=a*sin(2*pi*f*t);   % sin
      y2=a*cos(2*pi*f*t);   % cos
      y3=exp(-t).*y1;     % 振動の減衰
%
%
figure(1)
  plot(t,y1)
  title('sin波')
  xlabel('時間　（秒）')
  ylabel('y1')
%
figure(2)
  plot(t,y2)
  title('cos波')
  xlabel('時間　（秒）')
  ylabel('y2')
%
figure(3)
  plot(t,y3)
  title('振動の減衰')
  xlabel('時間　（秒）')
  ylabel('y3')
%
