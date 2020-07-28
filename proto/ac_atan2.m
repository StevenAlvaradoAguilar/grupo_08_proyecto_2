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
  pi_n_round = -pi_round;
  pi_half = pi_round / (2);
  pi_n_half = -pi_half;
  pi_quarts = pi_round / 4;
  pi_n_quarts = -pi_quarts;
  three_pi_quarts = (3 * pi_round) / 4;
  three_n_pi_quarts = -three_pi_quarts;
  
  x_pot_2 = real_part * real_part;
  x_mov_2_right = bitshift(x_pot_2, -2);
  x_mov_5_right = bitshift(x_pot_2, -5);
  y_pot_2 = imag_part * imag_part;
  y_mov_2_right = bitshift(y_pot_2,-2);
  y_mov_5_right = bitshift(y_pot_2,-5);
  
    %Indefined function
    if real_part == 0 && imag_part == 0
      
      octant = 0;
      theta = 0;
      return;
    
    endif
  %The angle 0 and 360
  if real_part > 0 && imag_part == 0
    octant = 0;
    theta = 0;
    return;
    
  endif
  
  %The angle 45°
  if real_part == imag_part && real_part > 0
      
      octant = 0;
      theta = round(pi_quarts);
      return;
    
   endif
   
   %The angle 90°
  if real_part == 0 && imag_part > 0
      
      octant = 0;
      theta = round(pi_half);
      return;
    
   endif
   
   %The angle 135°
  if abs(real_part) == imag_part > 0
      
      octant = 0;
      theta = round(three_pi_quarts);
      return;
    
   endif
   
    %The angle 180°
  if real_part < 0 && imag_part == 0
      
      octant = 0;
      theta = round(pi_round);
      return;
    
   endif
   
   %The angle 225°
  if abs(real_part) == abs(imag_part) && real_part < 0
      
      octant = 0;
      theta = round(three_n_pi_quarts);
      return;
    
   endif
   
   %The angle 270°
  if real_part == 0 && imag_part < 0
      
      octant = 0;
      theta = round(pi_n_half);
      return;
    
   endif
   
   %The angle 315°
  if real_part == abs(imag_part)
      
      octant = 0;
      theta = round(pi_n_quarts);
      return;
    
   endif
  
   %The quadrant 1
   if real_part >= 0 && imag_part >= 0
     
     %The octan 1
     if real_part > imag_part 
      
          octant = 1;
          theta1 = x_pot_2 + y_mov_2_right + y_mov_5_right;  
          theta1 = bitshift(theta1, -15);
          theta1 = real_mult_imag / (theta1);
          theta = round(theta1);
          return;
          
     endif
     
     %The octan 2
     if real_part <= imag_part
       
       octant = 2;
       thet1 = y_pot_2 + y_mov_2_right + y_mov_5_right;
       theta1 = bitshift(thet1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_half - theta1);
       return;
        
     endif
    
   endif
   
   %The quadrant 2
   if real_part < 0 && imag_part >= 0
     
     %The octan 3
     if abs(real_part) <= imag_part 
       
       octant = 3;
       thet1 = y_pot_2 + y_mov_2_right + y_mov_5_right;
       theta1 = bitshift(thet1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_half - theta1);
          return;
          
     endif
     
     %The octan 4
     if abs(real_part) > imag_part 
       
       octant = 4;
       theta1 = x_pot_2 + y_mov_2_right + y_mov_5_right;  
       theta1 = bitshift(theta1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_round + theta1);
       return;
        
     endif
    
   endif
   
   %The quadrant 3
   if real_part < 0 && imag_part < 0
     
     %The octan 5
     if abs(real_part) > abs(imag_part)
      
      octant = 5;
      theta1 = x_pot_2 + y_mov_2_right + y_mov_5_right;  
      theta1 = bitshift(theta1, -15);
      theta1 = real_mult_imag / (theta1);
      theta = round(pi_n_round + theta1);
      return;
        
     endif
     
     %The octan 6
     if abs(real_part) <= abs(imag_part) 
      
      octant = 6;
      theta1 = y_pot_2 + y_mov_2_right + y_mov_5_right;  
      theta1 = bitshift(theta1, -15);
      theta1 = real_mult_imag / (theta1);
      theta = round(pi_n_half - theta1);
      return;   
          
     endif
    
   endif
   
   %The quadrant 4
   if real_part >= 0 && imag_part < 0
     
     %The octan 7
     if real_part <= abs(imag_part)
       
       octant = 7;
       theta1 = y_pot_2 + y_mov_2_right + y_mov_5_right;  
       theta1 = bitshift(theta1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_n_half - theta1);
       return;
        
     endif
     
     %The octan 8
     if real_part > abs(imag_part) 
       
       octant = 8;
       theta1 = x_pot_2 + y_mov_2_right + y_mov_5_right;  
       theta1 = bitshift(theta1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(theta1);
       return;
          
     endif
    
   endif
    
end