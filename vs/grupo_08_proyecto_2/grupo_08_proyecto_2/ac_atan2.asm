; Descripcion del Programa:
; Autor:
; Dia:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; declarar variables aqui
REAL_MULT_IMAG  DWORD 0
PI_ROUND DWORD 102944
PI_N_ROUND DWORD 0 ; negativo (tal vez ocupe conversion)
PI_HALF DWORD 51472
PI_N_HALF DWORD 0 ; negativo (tal vez ocupe conversion)
PI_QUARTS DWORD 25736
PI_N_QUARTS DWORD 0 ; negativo (tal vez ocupe conversion)
THREE_PI_QUARTS DWORD 0
THREE_N_PI_QUARTS DWORD 0 ; negativo (tal vez ocupe conversion)
  
ABSO_REAL_PART DWORD 0
ABSO_IMAG_PART DWORD 0
X_POT_2 DWORD 0
Y_POT_2 DWORD 0
X_MOV_2_RIGHT DWORD 0
X_MOV_5_RIGHT DWORD 0
Y_MOV_2_RIGHT DWORD 0
Y_MOV_5_RIGHT DWORD 0
  
SUM_X_Y DWORD 0 
MOV_X_15_RIGHT DWORD 0  
THETA_X DWORD 0 
  
SUM_Y_X DWORD 0
MOV_Y_15_RIGHT DWORD 0
THETA_Y DWORD 0

.code

main PROC
 ; Escribir codigo aqui 
 (3 * PI_ROUND) / 4

 INVOKE ExitProcess,0

main ENDP

; (insertar procesos adicionales aqui)

END main