ROBOTICA
Matriz de transformacion de Ty(d)

function Ty=HTy(d)
     Ty= [1, 0, 0, 0; 
          0, 1, 0, d;
          0, 0, 1, 0;
          0, 0, 0, 1];
end
