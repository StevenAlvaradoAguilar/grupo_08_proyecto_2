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
PI_N_ROUND DWORD 0 ; negativo 
PI_HALF DWORD 51472
PI_N_HALF DWORD 0 ; negativo 
PI_QUARTS DWORD 25736
PI_N_QUARTS DWORD 0 ; negativo 
THREE_PI_QUARTS DWORD 77208
THREE_N_PI_QUARTS DWORD 0 ; negativo 
  
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
 ac_atan2 PROC real_part:DWORD, imag_part:DWORD
	
	;Function real_mult_imag
	MOV EAX, real_part
	MOV EBX, imag_part
	MUL EAX, EBX
	MOV REAL_MULT_IMAG, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_round
	mov  EAX, PI_ROUND
	NEG EAX
	MOV PI_N_ROUND, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_half
	mov  EAX, PI_HALF
	NEG EAX
	MOV PI_N_HALF, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_quarts
	mov  EAX, PI_QUARTS
	NEG EAX
	MOV PI_N_QUARTS, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg tree_pi_quarts
	mov  EAX, THREE_PI_QUARTS
	NEG EAX
	MOV THREE_N_PI_QUARTS, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function absolute real_part
	; abs(eax), with no branches.
	; intel syntax (dest, src)
	MOV EAX, real_part
	mov EBX, EAX ;store eax in ebx
	neg EAX
	cmovl EAX, real_part ;if eax is now negative, restore its saved value
	MOV ABSO_REAL_PART, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function absolute imag_part
	; abs(eax), with no branches.
	; intel syntax (dest, src)
	MOV EAX, imag_part
	mov EBX, EAX ;store eax in ebx
	neg EAX
	cmovl EAX, imag_part ;if eax is now negative, restore its saved value
	MOV ABSO_IMAG_PART, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mult real_part
	MOV EAX, real_part
	MOV EBX, real_part
	MUL EAX, EBX
	MOV X_POT_2, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mult real_part
	MOV EAX, imag_part
	MOV EBX, imag_part
	MUL EAX, EBX
	MOV Y_POT_2, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mov 2 right
	MOV ECX, X_POT_2
	SHR ECX, 2
	MOV X_MOV_2_RIGHT, ECX

	XOR ECX, ECX

	;Function real_part mov 5 right
	MOV ECX, X_POT_2
	SHR ECX, 5
	MOV X_MOV_5_RIGHT, ECX

	XOR ECX, ECX

	;Function imag_part mov 2 right
	MOV ECX, Y_POT_2
	SHR ECX, 2
	MOV Y_MOV_2_RIGHT, ECX

	;Function imag_part mov 5 right
	MOV ECX, Y_POT_2
	SHR ECX, 5
	MOV Y_MOV_5_RIGHT, ECX

	XOR ECX, ECX

	;Function sum x_pot_2 + y_mov_2_right + y_mov_5_right
	MOV EAX, X_POT_2
	MOV EBX, Y_MOV_2_RIGHT
	ADD EAX, EBX
	XOR EBX, EBX
	MOV EBX, Y_MOV_5_RIGHT
	ADD EAX, EBX
	MOV SUM_X_Y, EAX


	;Function sum_x_y mov 15 right
	MOV ECX, SUM_X_Y
	SHR ECX, 15
	MOV MOV_X_15_RIGHT, ECX

	XOR ECX, ECX

	;Function real_mult_imag div mov_x_rigth
	MOV EAX, REAL_MULT_IMAG
	MOV EBX, MOV_X_15_RIGHT
	DIV EAX, EBX
	MOV THETA_X, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function sum y_pot_2 + x_mov_2_right + x_mov_5_right
	MOV EAX, Y_POT_2
	MOV EBX, X_MOV_2_RIGHT
	ADD EAX, EBX
	XOR EBX, EBX
	MOV EBX, X_MOV_5_RIGHT
	ADD EAX, EBX
	MOV SUM_Y_X, EAX


	;Function sum_x_y mov 15 right
	MOV ECX, SUM_Y_X
	SHR ECX, 15
	MOV MOV_Y_15_RIGHT, ECX

	XOR ECX, ECX

	;Function real_mult_imag div mov_x_rigth
	MOV EAX, REAL_MULT_IMAG
	MOV EBX, MOV_Y_15_RIGHT
	DIV EAX, EBX
	MOV THETA_Y, EAX

	XOR EAX, EAX
	XOR EBX, EBX

 INVOKE ExitProcess, 0

main ENDP

; (insertar procesos adicionales aqui)

END main