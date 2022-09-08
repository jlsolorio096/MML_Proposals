function [rC23] = Vec_Rotation(xC2, yC2, xC3, yC3)
%UNTITLED2 Summary of this function goes here
 % Determinar el ángulo de rotación, mediante la matriz de rotación de
    % vectores
    CA = max(max(xC2,xC3)) - min(min(xC2,xC3));
    CO = max(max(yC2,yC3)) - min(min(yC2,yC3));
    Angle = 180/pi*atan(CO/CA)

    % Nuevos patrones rotados según Angle
    RotMat = [cos(Angle), sin(Angle) ; -sin(Angle), cos(Angle)];
    AxisMat = [xC2 , xC3 ; yC2 , yC3]'
    rC23 = RotMat*AxisMat;
end