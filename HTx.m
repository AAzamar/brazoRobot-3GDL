% ROBOTICA
% Matriz de transformacion de Tx(d)

function Tx=HTx(d)
     Tx= [1, 0, 0, d; 
          0, 1, 0, 0;
          0, 0, 1, 0;
          0, 0, 0, 1];
end
