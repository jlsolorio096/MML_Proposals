function [PosC2, PosC3, a, C2_Errors, C3_Errors] = DecisionLine(ryC2, ryC3, dataset, minimo_Error)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % Generación de la frontera de decisión comenzando desde el valor
    % mínimo, hasta el máximo con pasos de 0.1
    minimum = min([ryC2;ryC3]);
%     y_value = minimum;
    maximum = max([ryC2;ryC3]);

    % Generador de pasos entre el valor mínimo y máximo
    steps = minimum:0.1:maximum;
    
    for j =  1:length(steps)
%         yline(steps(j), '--m', LineWidth = 1.5);
        separator = steps(j);
        U_C2 = sum(ryC2 < separator);
        O_C2 = sum(ryC2 > separator);

        U_C3 = sum(ryC3 < separator);
        O_C3 = sum(ryC3 > separator);

        % Calcular los errores
       minE2 = min(size(dataset,1) - U_C2 - O_C3);   % Si la clase 2 queda debajo, y la clase 3 arriba
       minE3 = min(size(dataset,1) - U_C3 - O_C2);   % Si la clase 3 queda debajo, y la clase 2 arriba
       
       if (minE2 < minE3) && (minE2 < minimo_Error)
           minimo_Error = minE2;
           PosC2 = 'Under';
           PosC3 = 'Over';
           C2_Errors = 50 - U_C2;
           C3_Errors = 50 - O_C3;
           position = j;
       elseif (minE2 >= minE3) && (minE3 < minimo_Error)
           minimo_Error = minE3;
           PosC2 = 'Over';
           PosC3 = 'Under';
           C2_Errors = 50 - O_C2;
           C3_Errors = 50 - U_C3;
           position = j;
       end
    end
    a = steps(position);
    yline(steps(position), '--m', LineWidth = 1.5);
    legend('Clase 2', 'Clase 3', 'Línea de decisión')

    RE = (C2_Errors + C3_Errors)/size(dataset,1)
end