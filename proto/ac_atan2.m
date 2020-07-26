% Instituto Tecnológico de Costa Rica
% Centro Académico Alajuela
% Esuela de Ingeniería en Computación
% IC-3101 Arquitectura de Computadores
% I Semestre 2020
% Prof.-Ing. Daniel Kohkemper, M.Sc.
%
% atan2 implementation file
% File:   ac_atan2.m
% Brief:  Implementation of atan2 function
% Input:  x coordinate, y coordinate of complex number
% Output: theta: angle of vector
%
% Grupo 08
% Steven Alvarado Aguilar | 2019044923
% Andres López Sánchez | 2019160378
% Fabian López Sánchez | 2019064821
%

function [theta, octant] = ac_atan2(real_part, imag_part)
  
  real_mult_imag = real_part * imag_part;
  num_pot_15 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2;
  pi_round = round(3.141592654 * num_pot_15);
  pi_half = pi_round / 2; 
  %The real variables
  x_pot_2 = real_part * real_part;
  x_mov_2_right = bitshift(x_pot_2, -2);
  x_mov_5_right = bitshift(x_pot_2, -5);
  
  %The imagenary variables
  y_pot_2 = imag_part * imag_part;
  y_mov_2_right = bitshift(y_pot_2,-2);
  y_mov_5_right = bitshift(y_pot_2,-5);
  
    %Indefined function
    if real_part == 0 && imag_part == 0
      
      octant = 0;
      theta = 0;
      return;
    
    endif
  
    %The basics functions

    if real_part == 0 && imag_part > 0
      
      octant = 0;
      theta = round(pi_round / 2);
      return;
      
    endif
   
    if real_part == 0 && imag_part < 0
      
      octant = 0;
      theta = -pi_round / 2;
      return;
      
     endif
    
    if real_part == imag_part
      
      octant = 0;
      theta = round(pi_round / 4);
      return;
      
    endif
    
    if real_part == abs(imag_part) && imag_part < 0
      
      octant = 0;
      theta = round(-pi_round / 4) ;
      return;
      
    endif
    
    if real_part == 0 && imag_part > 0
      
      octant = 0;
      theta = pi_round;
      return;
      
    endif
    
    if real_part == 0 && imag_part < 0
      
      octant = 0;
      theta = -pi_round;
      theta = theta;
      return;
      
    endif
    
    %The octan 1
    if (real_part > 0 && imag_part < real_part)
      
      octant = 1;
      theta = imag_part / real_part;
      return;
    endif
     
    %The octan 2 
    if (imag_part > 0 && real_part < imag_part)
      
      octant = 2;
      theta =  real_part / imag_part;
      return;
       
    endif
    
  %The octan 3  
    if (imag_part < 0 && real_part > 0)
      
     octant = 3;
     theta =  real_part / imag_part;
     theta = pi_half - theta;
     return;
      
    endif
     
   %The octan 4
   if (real_part > 0 && imag_part > 0)
      
     octant = 4;
     theta =  real_part / imag_part;
     theta = -pi_half - theta;
     return;
      
   endif
    
   %The octan 5 
   if (real_part < 0 && imag_part < 0 )
      
     octant = 5;
     theta = real_part / imag_part;
     theta = - pi_half - theta;
     return;
       
    endif
  
  %The octan 6
   if (imag_part < 0 && real_part < 0)
      
     octant = 6;
     theta = imag_part / real_part;
     theta = - pi_half - theta;
     return;
      
   endif
   
   %The octan 7
   if (imag_part > 0 && real_part < 0)
      
     octant = 7;
     theta = imag_part / real_part;
     theta = theta + pi_round;
     return;
      
   endif
    
   %The octan 8
   if (real_part > 0 && imag_part < 0)
      
     octant = 8;
     theta = imag_part / real_part;
     theta = theta - pi_round;
     return;
      
   endif 
    
end
