% Codigo para visualizar los ultimos 100 datos seriales en 6 graficas [q1,q2,q3,x,y,z]
clearvars; clc;
arduinoObj = serialport("COM3", 9600);
configureTerminator(arduinoObj,"CR/LF");

t1=0;   b1=14;      l1=1;      a1=pi/2;
t2=0;   b2=2.15;    l2=19.2;   a2=pi;
t3=0;   b3=1.55;    l3=12.7;   a3=0;

tr = 100;
data1 = zeros(1, tr);
data2 = zeros(1, tr);
data3 = zeros(1, tr);
t = [0:tr-1];
X = zeros(1, tr);
Y = zeros(1, tr);
Z = zeros(1, tr);

figure;
subplot(3, 2, 1);
hPlot1 = plot(t, data1, 'LineWidth', 2);
title('q1'); ylabel('Grados');
ylim([0, 360]); yticks(0:90:360); grid on; 
subplot(3, 2, 2);
hPlot2 = plot(t, X, 'LineWidth', 2);
title('X'); ylabel('X');
grid on; ylim([-35, 35]); 
subplot(3, 2, 3);
hPlot3 = plot(t, data2, 'LineWidth', 2);
title('q2'); ylabel('Grados');
ylim([0, 180]); yticks(0:45:180); grid on;
subplot(3, 2, 4);
hPlot4 = plot(t, Y, 'LineWidth', 2);
title('Y'); ylabel('Y');
grid on; ylim([-35, 35]);
subplot(3, 2, 5);
hPlot5 = plot(t, data3, 'LineWidth', 2);
title('q3'); ylabel('Grados');
ylim([0, 180]); yticks(0:45:180); grid on;
subplot(3, 2, 6);
hPlot6 = plot(t, Z, 'LineWidth', 2);
title('Z'); ylabel('Z');
grid on; ylim([0, 50]);
drawnow;

r1 = 360/668;
r2 = 180/2640;
while 1
    %flush(arduinoObj);
    data = str2double(strsplit(readline(arduinoObj), ','));
    data1 = [data1(2:end), r1*data(1)];
    data2 = [data2(2:end), r2*data(2)];
    data3 = [data3(2:end), data(3)];
    set(hPlot1, 'XData', t, 'YData', data1);
    set(hPlot3, 'XData', t, 'YData', data2);
    set(hPlot5, 'XData', t, 'YData', data3);
    t1=deg2rad(data(1)*r1);
    t2=deg2rad(data(2)*r2);
    t3=deg2rad(data(3));
    H0_1 = H_DH(t1,b1,l1,a1) ;
    H1_2 = H_DH(t2,b2,l2,a2) ;
    H2_3 = H_DH(t3,b3,l3,a3) ;
    H0_2 = H0_1*H1_2 ;
    H0_3 = H0_1*H1_2*H2_3 ;
    Ef = [H0_3(1,4);H0_3(2,4);H0_3(3,4)];
    X = [X(2:end), Ef(1)];
    Y = [Y(2:end), Ef(2)];
    Z = [Z(2:end), Ef(3)];
    set(hPlot2, 'XData', t, 'YData', X);
    set(hPlot4, 'XData', t, 'YData', Y);
    set(hPlot6, 'XData', t, 'YData', Z);
end

