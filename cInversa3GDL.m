% Cinemática Inversa Robot antropomórfico de 3gdl RRR
clearvars;  clc;
% Valores simbolicos [ Rz Tz Tx Rx ]
t1=sym('q1');   b1=sym('b1');    l1=sym('l1');   a1=sym('a1');
t2=sym('q2');   b2=sym('b2');    l2=sym('l2');   a2=sym('a2');
t3=sym('q3');   b3=sym('b3');    l3=sym('l3');   a3=0;

H0_1 = H_DH(t1,b1,l1,a1) ;
H1_2 = H_DH(t2,b2,l2,a2) ;
H2_3 = H_DH(t3,b3,l3,a3) ;
H0_2 = H0_1*H1_2         ;
H0_3 = H0_1*H1_2*H2_3    ;

Ef = [H0_3(1,4);H0_3(2,4);H0_3(3,4)];
J = jacobian(Ef,[sym('q1') sym('q2') sym('q3')]);
J = simplify(J);
Det = simplify(det(J))

%% Cinematica directa Brazo Robot 3GDL RRR
% Ef = [H0_3(1,4);H0_3(2,4);H0_3(3,4)];
% J = jacobian(Ef,[sym('q1') sym('q2') sym('q3')]);
% J = simplify(J);
% Det = simplify(det(J));
% syms q1 q2 q3 b1 b2 b3 l1 l2 l3 a1 a2 a3
% 
% dr =  pi/180; rd =  180/pi;
% simbolicos = [    q1,   q2,   q3,  b1,   b2,   b3,  l1,   l2,   l3,   a1,  a2, a3];
% numericos  = [-45*dr,135*dr, pi/6,  14, 2.15, 1.55,   1, 19.2, 12.7, pi/2,  pi,  0];
% H01 = subs(H0_1,simbolicos, numericos);
% H02 = subs(H0_2,simbolicos, numericos);
% H03 = subs(H0_3,simbolicos, numericos);
% 
% S1 = simplify([H01(1,4);H01(2,4);H01(3,4)]);
% S2 = simplify([H02(1,4);H02(2,4);H02(3,4)]);
% S3 = simplify([H03(1,4);H03(2,4);H03(3,4)]);
% Ef = double( simplify([H03(1,4);H03(2,4);H03(3,4)]) )
% %% 3D
% %figure
% plot3(0, 0, 0, 'o');    hold on                         % Origen
% plot3([0,S1(1)], [0,S1(2)], [0,S1(3)],'r')              % Eslabon 1 R
% plot3(S1(1), S1(2), S1(3), 'x')                         % Sigma1
% plot3([S1(1),S2(1)], [S1(2),S2(2)], [S1(3),S2(3)],'y')  % Eslabon 2 R
% plot3(S2(1), S2(2), S2(3), 'x')                         % Sigma2
% plot3([S2(1),S3(1)], [S2(2),S3(2)], [S2(3),S3(3)],'b')  % Eslabon 3 P
% plot3(Ef(1), Ef(2), Ef(3), '*')                         % Efector final
% 
% title('cinematica directa, dados los angulos');
% xlabel('x'); ylabel('y'); zlabel('z'); axis equal
% legend("Origen","Eslabon 1","Sigma 1","Eslabon 2","Sigma 2","Eslabon 3","Efector final")
% grid on; hold off;

%% Cinematica inve); y = double(Ef(2)); q1 = atan(y/x);
% ( double(Ef(1))*sin(q1))-(double(Ef(2))*cos(q1) = 0.6;)
% x = double(Ef(1)); y = double(Ef(2)); z = double(Ef(3));
dr =  pi/180; rd =  180/pi;
x = 29; y = -0.6; z = 16;
if y < 0
    q1 =  -acos(x/sqrt(x^2+y^2))   +acos(sqrt(x^2+y^2-(0.6*0.6))/sqrt(x^2+y^2));
else
    q1 =  +acos(x/sqrt(x^2+y^2))   +acos(sqrt(x^2+y^2-(0.6*0.6))/sqrt(x^2+y^2));
end
x = x-cos(q1)-0.6*sin(q1);%-0.6*cos(3*dr);
y = y-sin(q1)+0.6*cos(q1);%+0.6*sin(3*dr); 
z = z-14;%+0.6*sin(3*dr);
l2 = 19.2; l3 = 12.7;                                                         
q3 = acos(((z^2)+x^2+y^2-((l2^2)+(l3^2)))/(2*l2*l3));

xy = sqrt((x^2)+(y^2));
B = atan(z/xy);
a = atan((l3*sin(q3))/(l2+(l3*cos(q3))));
q2 = B+a;
T = [q1*rd;q2*rd;q3*rd]
T = [q1;q2;q3];
syms q1 q2 q3 b1 b2 b3 l1 l2 l3 a1 a2 a3
simbolicos = [q1,   q2,   q3,  b1,   b2,   b3,  l1,   l2,   l3,   a1,  a2, a3];
numericos  = [T(1),T(2),T(3),  14, 2.15, 1.55,   1, 19.2, 12.7,(pi/2),  pi,  0];
H01 = subs(H0_1,simbolicos, numericos);
H02 = subs(H0_2,simbolicos, numericos);
H03 = subs(H0_3,simbolicos, numericos);
S1 = simplify([H01(1,4);H01(2,4);H01(3,4)]);
S2 = simplify([H02(1,4);H02(2,4);H02(3,4)]);
S3 = simplify([H03(1,4);H03(2,4);H03(3,4)]);
Ef1 = double( simplify([H03(1,4);H03(2,4);H03(3,4)]) )
%figure
plot3(0, 0, 0, 'o');    hold on                         % Origen
plot3([0,S1(1)], [0,S1(2)], [0,S1(3)],'r')              % Eslabon 1 R
plot3(S1(1), S1(2), S1(3), 'x')                         % Sigma1
plot3([S1(1),S2(1)], [S1(2),S2(2)], [S1(3),S2(3)],'y')  % Eslabon 2 R
plot3(S2(1), S2(2), S2(3), 'x')                         % Sigma2
plot3([S2(1),S3(1)], [S2(2),S3(2)], [S2(3),S3(3)],'b')  % Eslabon 3 P
plot3(Ef1(1), Ef1(2), Ef1(3), '*')                      % Efector final
title('cinematica inversa, dadas las posiciones');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal
legend("Origen","Eslabon 1","Sigma 1","Eslabon 2","Sigma 2","Eslabon 3","Efector final")
grid on; hold off;