% Instituto Tecnológico de Costa Rica
% Centro Académico Alajuela
% Esuela de Ingeniería en Computación
% IC-3101 Arquitectura de Computadores
% I Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% atan2 test file
% File: atan2_test.m
% Brief: Tests implementation of atan2 function
%
% Grupo 08
% Steven Alvarado Aguilar | 2019044923
% Andres López Sánchez | 2019160378
% Fabian López Sánchez | 2019064821
%

clc
clear

% Open file for output data
fid = fopen('output.txt', 'w');
    
    for idx = 1 : 1 : 73
        angle   = (idx-1) * 5 * pi / 180;
        cos_val = round(cos(angle) * 8192);
        sin_val = round(sin(angle) * 8192);
        
        % Call ac_atan2 function
        [theta, octant] = ac_atan2(cos_val, sin_val);
        
%         Write output to prompt
        fprintf("Octant = %d; X = %5d ; Y = %5d; Angle: %3d;  theta = %7d\n", ...
            octant, cos_val, sin_val, (idx-1) * 5, theta);
        
%         fprintf("%d;%d\n", cos_val, sin_val);
        
        % Write output to file
        fprintf(fid, "Octant = %d; X = %5d ; Y = %5d; Angle: %3d;  theta = %7d\n", ...
            octant, cos_val, sin_val, (idx-1) * 5, theta);
    end
    
fclose(fid);

% EVALUACIÓN
%
% Implementación de Solución    4/5 de 60%
%
% Resultados Correctos          5/5 de 30%
%
% Orden y Estilo de Código      5/5 de 10%
%
% Nota en Prototipado:                 88