% ROBOTICA
% Matriz de transformacion homogenea de Rz(theta)
% funcion HRz(angulo)

function RHz=HRz(angulo)
    dato= whos('angulo');
    if strcmp(dato.class,'sym')    % para variables simbolicas
        RHz= simplify([cos(angulo),   -sin(angulo),      0,     0;
                       sin(angulo),    cos(angulo),      0,     0;
                                 0,              0,      1,     0;
                                 0,              0,      0,     1]);
    else                           % cálculos numéricos 
        RHz= [cos(angulo),   -sin(angulo),      0,     0;
              sin(angulo),    cos(angulo),      0,     0;
                        0,              0,      1,     0;
                        0,              0,      0,     1];
    end
end