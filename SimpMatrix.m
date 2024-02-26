% Funcion para evaluar en 0.01 las variables simbólicas de una matriz y
% simplificar a 0 los valores cercanos.

function MatrixSimp = SimpMatrix(matriz_simbolica)
    [m, n] = size(matriz_simbolica);
    MatrixSimp = matriz_simbolica;

    for i = 1:m
        for j = 1:n
            variable_symbols = symvar(matriz_simbolica(i, j));
            valores_variables = ones(1, length(variable_symbols));
            valores_asignados = cell2sym(num2cell(valores_variables));
            matriz_evaluada = subs(matriz_simbolica(i, j), variable_symbols, valores_asignados);
            if abs(double(matriz_evaluada)) < 0.01
                MatrixSimp(i, j) = sym(0);
            end
        end
    end
end
