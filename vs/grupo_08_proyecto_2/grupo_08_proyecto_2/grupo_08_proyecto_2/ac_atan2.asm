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

Octant DWORD 0
Theta DWORD 0
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

	; Special Angle (Indefined Function)
	Undefined_angle:
		MOV EAX, real_part
		MOV EBX, imag_part
		ADD EBX, EAX
		JZ Undefined_angle2
		JNZ Angle_0_360

	Undefined_angle2:
		MOV Octant, 0
		MOV Theta, 0

	; Special Angle 0 and 360 
	; If real part is greater then zero continus check , If imag part is equal to zero Angle found if not check other angle.
	Angle_0_360:
		MOV EAX, real_part
		CMP EAX, 0
		JA Angle_0_360_2
		JNA Angle_45
		JAE Angle_45
		JNAE Angle_45

	Angle_0_360_2:
		MOV EBX, imag_part
		ADD EBX, 0
		JZ Resultado
		JNZ Angle_45

	Resultado:
		MOV Octant, 0
		MOV Theta, 0

	; Angle 45
	; If real part is greater then zero continue check, then if real part and image part are the same angle found, if not check other angle.
	Angle_45:
		MOV EAX, real_part
		CMP EAX, 0
		JA Angle_45_2
		JNA Angle_90
		JAE Angle_90
		JNAE Angle_90

	Angle_45_2:
		MOV EAX, real_part
		MOV EBX, imag_part
		CMP EAX,EBX
		JE Resultado_45
		JNE Angle_90


	Resultado_45:
		MOV Octant, 0
		MOV Theta, PI_QUARTS

	; Angle 90
	;If real part is zero continue check, If imag part is greater then zero angle found, if not check other angle.
	Angle_90:
		MOV EBX, real_part
		ADD EBX, 0
		JZ Angle_90_2
		JNZ Angle_135

	Angle_90_2:
		MOV EAX, imag_part
		CMP EAX, 0
		JA Resultado_90
		JNA Angle_135
		JAE Angle_135
		JNAE Angle_135

	Resultado_90:
		MOV Octant, 0
		MOV Theta, PI_HALF

	; Angle 135
	Angle_135:
		MOV EAX, imag_part
		CMP EAX, 0
		JA Angle_135_2
		JNA Angle_180
		JAE Angle_180
		JNAE Angle_180

	Angle_135_2:
		MOV EBX, ABSO_REAL_PART
		CMP EBX; EAX
		JE Resultado_135
		JNE Angle_180

	Resultado_135:
		MOV Octant, 0
		MOV Theta, THREE_PI_QUARTS

	;Angle 180
	Angle_180:
		MOV EAX, real_part
		CMP EAX, 0
		JNAE Angle_180_2
		JNA Angle_225
		JAE Angle_225
		JA Angle_225

	Angle_180_2:
		MOV EBX, imag_part
		ADD EBX, 0
		JZ Resultado_180
		JNZ Angle_225

	Resultado_180:
		MOV Octant, 0
		MOV Theta, PI_ROUND

	;Angle 225
	Angle_225:
		MOV EAX, real_part
		CMP EAX, 0
		JNAE Angle_225_2
		JNA Angle_270
		JAE Angle_270
		JA Angle_270

	Angle_225_2:
		MOV EAX, ABSO_REAL_PART 
		MOV EBX, ABSO_IMAG_PART 
		CMP EAX,EBX
		JE Resultado_225
		JNE Angle_270

	Resultado_225:
		MOV Octant, 0
		MOV Theta, THREE_N_PI_QUARTS

	; Angle 270
	Angle_270:
		MOV EBX, real_part
		ADD EBX, 0
		JZ Angle_270_2
		JNZ Angle_315
	
	Angle_270_2:
		MOV EAX, imag_part
		CMP EAX, 0
		JNAE Resultado_270
		JNA Angle_315
		JAE Angle_315
		JA Angle_315

	Resultado_270:
		MOV Octant, 0
		MOV Theta, PI_N_HALF

	;Angle 315
	Angle_315:
		MOV EAX, ABSO_IMAG_PART
		MOV EBX, real_part
		Cmp EAX, EBX
		JE Reultado_315
		JNE

	Reultado_315:
		MOV Octant, 0
		MOV Theta, PI_N_QUARTS







 INVOKE ExitProcess, 0

main ENDP

; (insertar procesos adicionales aqui)

END main