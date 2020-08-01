% Instituto Tecnol�gico de Costa Rica
% Centro Acad�mico Alajuela
% Esuela de Ingenier�a en Computaci�n
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
% Andres L�pez S�nchez | 2019160378
% Fabian L�pez S�nchez | 2019064821
%

function [theta, octant] = ac_atan2(real_part, imag_part)
  
<<<<<<< HEAD
  REAL_MULT_IMAG = real_part * imag_part;
  PI_ROUND = 102944;
  PI_N_ROUND = -PI_ROUND;
  PI_HALF = 51472;
  PI_N_HALF = -PI_HALF;
  PI_QUARTS = 25736;
  PI_N_QUARTS = -PI_QUARTS;
  THREE_PI_QUARTS = (3 * PI_ROUND) / 4;
  THREE_N_PI_QUARTS = -THREE_PI_QUARTS;
=======
  real_mult_imag = real_part * imag_part;
  num_pot_15 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2; % DK: Esto es 2^15
  pi_round = round(3.141592654 * num_pot_15);                             % DK: Poner valor entero exacto, no calculado
  pi_n_round = -pi_round;
  pi_half = pi_round / (2);
  pi_n_half = -pi_half;
  pi_quarts = pi_round / 4;                                               % DK: Poner valor entero exacto, no calculado
  pi_n_quarts = -pi_quarts;
  three_pi_quarts = (3 * pi_round) / 4;
  three_n_pi_quarts = -three_pi_quarts;
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
  
  ABSO_REAL_PART = abs(real_part);
  ABSO_IMAG_PART = abs(imag_part);
  X_POT_2 = real_part * real_part;
  Y_POT_2 = imag_part * imag_part;
  X_MOV_2_RIGHT = bitshift(X_POT_2, -2);
  X_MOV_5_RIGHT = bitshift(X_POT_2, -5);
  Y_MOV_2_RIGHT = bitshift(Y_POT_2,-2);
  Y_MOV_5_RIGHT = bitshift(Y_POT_2,-5);
  SUM_X_Y = X_POT_2 + Y_MOV_2_RIGHT + Y_MOV_5_RIGHT;
  SUM_Y_X = Y_POT_2 + X_MOV_2_RIGHT + X_MOV_5_RIGHT;
  
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
  
  %The angle 45�
  if real_part == imag_part && real_part > 0
      
      octant = 0;
      theta = PI_QUARTS;
      return;
    
   endif
   
   %The angle 90�
  if real_part == 0 && imag_part > 0
      
      octant = 0;
      theta = PI_HALF;
      return;
    
   endif
   
   %The angle 135�
  if ABSO_REAL_PART == imag_part > 0
      
      octant = 0;
      theta = THREE_PI_QUARTS;
      return;
    
   endif
   
    %The angle 180�
  if real_part < 0 && imag_part == 0
      
      octant = 0;
      theta = PI_ROUND;
      return;
    
   endif
   
   %The angle 225�
  if ABSO_REAL_PART == ABSO_IMAG_PART && real_part < 0
      
      octant = 0;
      theta = THREE_N_PI_QUARTS;
      return;
    
   endif
   
   %The angle 270�
  if real_part == 0 && imag_part < 0
      
      octant = 0;
      theta = PI_N_HALF;
      return;
    
   endif
   
   %The angle 315�
  if real_part == ABSO_IMAG_PART
      
      octant = 0;
      theta = PI_N_QUARTS;
      return;
    
   endif
  
   %The quadrant 1
   if real_part >= 0 && imag_part >= 0
     
     %The octan 1
     if real_part > imag_part 
      
          octant = 1;
<<<<<<< HEAD
          theta1 = bitshift(SUM_X_Y, -15);
          theta1 = REAL_MULT_IMAG / (theta1);
=======
          theta1 = x_pot_2 + y_mov_2_right + y_mov_5_right;  % DK: Hacer esto s�lo una vez arriba y poner en una variable
          theta1 = bitshift(theta1, -15);
          theta1 = real_mult_imag / (theta1);
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
          theta = round(theta1);
          return;
          
     endif
     
     %The octan 2
     if real_part <= imag_part
       
       octant = 2;
<<<<<<< HEAD
       theta1 = bitshift(SUM_Y_X, -15);
       theta1 = REAL_MULT_IMAG / (theta1);
       theta = round(PI_HALF - theta1);
=======
       thet1 = y_pot_2 + x_mov_2_right + x_mov_5_right;       % DK: Hacer esto s�lo una vez arriba y poner en una variable
       theta1 = bitshift(thet1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_half - theta1); %DK: Usar mayusculas para constantes
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
       return;
        
     endif
    
   endif
   
   %The quadrant 2
   if real_part < 0 && imag_part >= 0
     
     %The octan 3
     if ABSO_REAL_PART <= imag_part 
       
       octant = 3;
<<<<<<< HEAD
       theta1 = bitshift(SUM_Y_X, -15);
       theta1 = REAL_MULT_IMAG / (theta1);
       theta = round(PI_HALF - theta1);
=======
       thet1 = y_pot_2 + x_mov_2_right + x_mov_5_right;
       theta1 = bitshift(thet1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_half - theta1);
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
          return;
          
     endif
     
     %The octan 4
<<<<<<< HEAD
     if ABSO_REAL_PART > imag_part 
=======
     if abs(real_part) > imag_part % DK: asignar abs(real_part) a una variable arriba
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
       
       octant = 4;  
       theta1 = bitshift(SUM_X_Y, -15);
       theta1 = REAL_MULT_IMAG / (theta1);
       theta = round(PI_ROUND + theta1);
       return;
        
     endif
    
   endif
   
   %The quadrant 3
   if real_part < 0 && imag_part < 0
     
     %The octan 5
     if ABSO_REAL_PART > ABSO_IMAG_PART
      
      octant = 5;
      theta1 = bitshift(SUM_X_Y, -15);
      theta1 = REAL_MULT_IMAG / (theta1);
      theta = round(PI_N_ROUND + theta1);
      return;
        
     endif
     
     %The octan 6
     if ABSO_REAL_PART <= ABSO_IMAG_PART 
      
      octant = 6;
<<<<<<< HEAD
      theta1 = bitshift(SUM_Y_X, -15);
      theta1 = REAL_MULT_IMAG / (theta1);
      theta = round(PI_N_HALF - theta1);
=======
      theta1 = y_pot_2 + x_mov_2_right + x_mov_5_right;  
      theta1 = bitshift(theta1, -15);
      theta1 = real_mult_imag / (theta1);
      theta = round(pi_n_half - theta1);
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
      return;   
          
     endif
    
   endif
   
   %The quadrant 4
   if real_part >= 0 && imag_part < 0
     
     %The octan 7
     if real_part <= ABSO_IMAG_PART
       
       octant = 7;
<<<<<<< HEAD
       theta1 = bitshift(SUM_Y_X, -15);
       theta1 = REAL_MULT_IMAG / (theta1);
       theta = round(PI_N_HALF - theta1);
=======
       theta1 = y_pot_2 + x_mov_2_right + x_mov_5_right;  
       theta1 = bitshift(theta1, -15);
       theta1 = real_mult_imag / (theta1);
       theta = round(pi_n_half - theta1);
>>>>>>> 5571a20876f6520c4daa1c281a14d2724322fac7
       return;
        
     endif
     
     %The octan 8
     if real_part > ABSO_IMAG_PART 
       
       octant = 8;
       theta1 = bitshift(SUM_X_Y, -15);
       theta1 = REAL_MULT_IMAG / (theta1);
       theta = round(theta1);
       return;
          
     endif
    
   endif
    
end