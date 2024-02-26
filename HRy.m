% ROBOTICA
% Matriz de transformacion homogenea de Ry(theta)
% funcion HRy(angulo)
% 
% function RHy=HRy(angulo)
%     dato= whos('angulo');
%     if strcmp(dato.class,'sym')    % para variables simbolicas
%         RHy= simplify([cos(angulo),    0,      sin(angulo),        0;
%                                  0,    1,                0,        0;
%                       -sin(angulo),    0,      cos(angulo),        0;
%                                  0,    0,                0,        1]);
%     else                           % cálculos numéricos 
%         RHy= [cos(angulo),    0,      sin(angulo),        0;
%                         0,    1,                0,        0;
%              -sin(angulo),    0,      cos(angulo),        0;
%                         0,    0,                0,        1];
%     end
% end