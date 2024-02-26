% ROBOTICA
% Matriz de transformacion homogenea de Rx(theta)
% funcion HRx(angulo)

function RHx=HRx(angulo)
    dato= whos('angulo');
    if strcmp(dato.class,'sym')    % para variables simbolicas
        RHx= simplify([1, 0, 0, 0;
                       0, cos(angulo),-sin(angulo), 0;
                       0, sin(angulo), cos(angulo), 0;
                       0, 0, 0, 1]);
    else                           % cálculos numéricos 
        RHx= [1, 0, 0, 0;
              0, cos(angulo),-sin(angulo), 0;
              0, sin(angulo), cos(angulo), 0;
              0, 0, 0, 1];
    end
end