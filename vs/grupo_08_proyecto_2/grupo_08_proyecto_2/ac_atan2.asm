; Descripcion del Programa:
; Autor:
; Dia:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

;We include the libraries links to Irvine so we can call the Irvine procedures
include c:\Irvine\Irvine32.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
include ac_atan2.inc            ;We include an .inc file that declares a prototype of the function

.data
; declarar constantes aqui
REAL_MULT_IMAG    WORD 0
PI_ROUND          DWORD 0
PI_N_ROUND        DWORD 0          ; negativo 
PI_HALF           WORD 0
PI_N_HALF         WORD 0          ; negativo 
PI_QUARTS         WORD 0
PI_N_QUARTS       WORD 0          ; negativo 
THREE_PI_QUARTS   DWORD 0
THREE_N_PI_QUARTS DWORD 0          ; negativo 

; declarar variantes aqui  
abso_real_part    WORD 0
abso_imag_part    WORD 0
x_pot_2           WORD 0
y_pot_2           WORD 0
x_mov_2_right     WORD 0
x_mov_5_right     WORD 0
y_mov_2_right     WORD 0
y_mov_5_right     WORD 0
  
sum_x_y           WORD 0 
mov_x_15_right    WORD 0  
theta_x           WORD 0 
  
sum_y_x           WORD 0
mov_y_15_right    WORD 0
theta_y           WORD 0

.code

 ; Escribir codigo aqui 
 ac_atan2 PROC real_part:WORD, imag_part:WORD, Octant:BYTE, Theta:DWORD

	MOV eax, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV edx, DWORD PTR 0

	;Constant PI_ROUND
	MOV EAX, 102944
	MOV PI_ROUND, EAX

	XOR EAX, EAX

	;Constant PI_HALF
	MOV AX, 51472
	MOV PI_HALF, AX

	XOR EAX, EAX

	;Constant PI_QUARTS
	MOV AX, 51472
	MOV PI_QUARTS, AX

	XOR EAX, EAX

	;Constant THREE_PI_QUARTS
	MOV EAX, 77208
	MOV THREE_PI_QUARTS, EAX

	XOR EAX, EAX
	
	;Function real_mult_imag
	MOV AX, real_part
	MOV BX, imag_part
	MUL BX
	MOV REAL_MULT_IMAG, BX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_round
	mov EAX, PI_ROUND
	NEG EAX
	MOV PI_N_ROUND, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_half
	mov AX, PI_HALF
	NEG AX
	MOV PI_N_HALF, AX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_quarts
	mov AX, PI_QUARTS
	NEG AX
	MOV PI_N_QUARTS, AX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg tree_pi_quarts
	mov EAX, THREE_PI_QUARTS
	NEG EAX
	MOV THREE_N_PI_QUARTS, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	; Special Angle (Indefined Function)
	Undefined_angle:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, imag_part
		ADD BX, AX
		JZ Undefined_angle2
		JNZ Angle_0_360

	Undefined_angle2:
		XOR EAX, EAX
		XOR EBX, EBX
		MOV AL, 0
		MOV Octant, AL
		MOV EBX, 0
		MOV Theta, EBX
		RET

	;Special Angle 0 and 360 
	;If real part is greater then zero continus check ,
	;If imag part is equal to zero Angle found if not check other angle.
	Angle_0_360:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		CMP AX, 0
		JA Angle_0_360_2
		JNA Angle_45
		JAE Angle_45
		JNAE Angle_45

	Angle_0_360_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, imag_part
		ADD BX, 0
		JZ Resultado
		JNZ Angle_45

	Resultado:
		MOV AL, 0
		MOV Octant, AL
		MOV EBX, 0
		MOV Theta, EBX
		RET

	;Angle 45
	;If real part is greater then zero continue check, 
	;then if real part and image part are the same angle found, 
	;if not check other angle.
	Angle_45:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		CMP AX, 0
		JA Angle_45_2
		JNA Angle_90
		JAE Angle_90
		JNAE Angle_90

	Angle_45_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JE Resultado_45
		JNE Angle_90


	Resultado_45:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV BX, PI_QUARTS
		MOV Theta, EBX
		RET

	; Angle 90
	;If real part is zero continue check, 
	;If imag part is greater then zero angle found, 
	;if not check other angle.
	Angle_90:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		ADD AX, 0
		JZ Angle_90_2
		JNZ Angle_135

	Angle_90_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, imag_part
		CMP BX, 0
		JA Resultado_90
		JNA Angle_135
		JAE Angle_135
		JNAE Angle_135

	Resultado_90:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV BX, PI_HALF
		MOV Theta, EBX
		RET

	;Angle 135
	Angle_135:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, imag_part
		CMP BX, 0
		JA Angle_135_2
		JNA Angle_180
		JAE Angle_180
		JNAE Angle_180

	Angle_135_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, abso_real_part
		CMP BX, AX
		JE Resultado_135
		JNE Angle_180    

	Resultado_135:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV EBX, THREE_PI_QUARTS
		MOV Theta, EBX
		RET

	;Angle 180
	Angle_180:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		CMP AX, 0
		JNAE Angle_180_2
		JNA Angle_225
		JAE Angle_225
		JA Angle_225

	Angle_180_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, imag_part
		ADD BX, 0
		JZ Resultado_180
		JNZ Angle_225

	Resultado_180:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV EBX, PI_ROUND
		MOV Theta, EBX
		RET

	;Angle 225
	Angle_225:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		CMP AX, 0
		JNAE Angle_225_2
		JNA Angle_270
		JAE Angle_270
		JA Angle_270

	Angle_225_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_real_part 
		MOV BX, abso_imag_part 
		CMP AX, BX 
		JE Resultado_225
		JNE Angle_270

	Resultado_225:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV EBX, THREE_N_PI_QUARTS
		MOV Theta, EBX
		RET

	;Angle 270
	Angle_270:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV BX, real_part
		ADD BX, 0
		JZ Angle_270_2
		JNZ Angle_315
	
	Angle_270_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, imag_part
		CMP AX, 0
		JNAE Resultado_270
		JNA Angle_315
		JAE Angle_315
		JA Angle_315

	Resultado_270:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV BX, PI_N_HALF
		MOV Theta, EBX

	;Angle 315
	Angle_315:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_imag_part
		MOV BX, real_part
		Cmp AX, BX
		JE Reultado_315
		;JNE 

	Reultado_315:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 0
		MOV Octant, AL
		MOV BX, PI_N_QUARTS
		MOV Theta, EBX

;--------------------------------------------------------------------------------------------

	;Function absolute real_part   
	; abs(eax), with no branches.
	MOV AX, real_part
	CMP AX, 0
	JB Conver_Abso_real_part
	MOV abso_real_part, AX

	Conver_Abso_real_part:
		MOV AX, real_part
		MOV BX, 1
		NEG BX
		MUL BX
		MOV abso_real_part, AX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function absolute imag_part  
	; abs(eax), with no branches.
	MOV AX, imag_part
	JB Conver_Abso_imag_part
	MOV abso_imag_part, AX

	Conver_Abso_imag_part:
		MOV AX, real_part
		MOV BX, 1
		NEG BX
		MUL BX
		MOV abso_imag_part, AX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mult real_part
	MOV AX, real_part
	MOV BX, real_part
	MUL BX
	MOV x_pot_2, BX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mult real_part
	MOV AX, imag_part
	MOV BX, imag_part
	MUL BX
	MOV y_pot_2, BX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mov 2 right
	MOV CX, x_pot_2
	SHR CX, 2
	MOV x_mov_2_right, CX

	XOR ECX, ECX

	;Function real_part mov 5 right
	MOV CX, x_pot_2
	SHR CX, 5
	MOV x_mov_5_right, CX

	XOR ECX, ECX

	;Function imag_part mov 2 right
	MOV CX, y_pot_2
	SHR CX, 2
	MOV y_mov_2_right, CX

	;Function imag_part mov 5 right
	MOV CX, y_pot_2
	SHR CX, 5
	MOV y_mov_5_right, CX

	XOR CX, CX

	;Function sum x_pot_2 + y_mov_2_right + y_mov_5_right
	MOV AX, x_pot_2
	MOV BX, y_mov_2_right
	ADD AX, BX
	XOR BX, BX
	MOV BX, y_mov_5_right
	ADD AX, BX
	MOV sum_x_y, AX


	;Function sum_x_y mov 15 right
	MOV CX, sum_x_y
	SHR CX, 15
	MOV mov_x_15_right, CX

	XOR ECX, ECX

	;Function real_mult_imag div mov_x_rigth
	MOV AX, REAL_MULT_IMAG
	MOV BX, mov_x_15_right
	DIV AX
	MOV theta_x, BX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function sum y_pot_2 + x_mov_2_right + x_mov_5_right
	MOV AX, y_pot_2
	MOV BX, x_mov_2_right
	ADD AX, BX
	XOR EBX, EBX
	MOV BX, x_mov_5_right
	ADD AX, BX
	MOV sum_y_x, AX


	;Function sum_x_y mov 15 right
	MOV CX, sum_y_x
	SHR CX, 15
	MOV mov_y_15_right, CX

	XOR ECX, ECX

	;Function real_mult_imag div mov_x_rigth
	MOV AX, REAL_MULT_IMAG
	MOV BX, mov_y_15_right
	DIV AX
	MOV theta_y, BX

	XOR EAX, EAX
	XOR EBX, EBX

;-----------------------------------------------------------------------------------------------------------
	
	;
	Octant_1:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JA Result_Octant_1
		JNA Octant_2
		JAE Octant_2
		JNAE Octant_2
		

	Result_Octant_1:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 1
		MOV Octant, AL
		MOV BX, theta_x
		MOV Theta, EBX
		RET

	;
	Octant_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JBE Result_Octant_2
		JB Octant_3
		JNB Octant_3
		JNBE Octant_3

	Result_Octant_2:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 2
		MOV Octant, AL
		MOV BX, PI_HALF
		MOV DX, theta_y
		SUB BX, DX
		MOV Theta, EBX
 		RET

	;
	Octant_3:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_real_part
		MOV BX, imag_part
		CMP AX, BX
		JBE Result_Octant_3
		JB Octant_4
		JNB Octant_4
		JNBE Octant_4 

	Result_Octant_3:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 3
		MOV Octant, AL
		MOV BX, PI_HALF
		MOV DX, theta_y
		SUB BX, DX
		MOV Theta, EBX
		RET

	;
	Octant_4:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_real_part
		MOV BX, imag_part
		CMP AX, BX
		JA Result_Octant_4 
		JNA  Octant_5
		JAE Octant_5
		JNAE Octant_5

	Result_Octant_4:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 4
		MOV Octant, AL
		MOV EBX, PI_ROUND
		MOV DX, theta_x
		ADD DX, BX
		MOV Theta, EDX
		RET

	;
	Octant_5:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_real_part
		MOV BX, abso_imag_part
		CMP AX, BX
		JA Result_Octant_5 
		JNA Octant_6
		JAE Octant_6
		JNAE Octant_6

	Result_Octant_5:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 5
		MOV Octant, AL
		MOV EBX, PI_N_ROUND
		MOV DX, theta_x
		ADD DX, BX
		MOV Theta, EDX
		RET

	;
	Octant_6:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, abso_real_part
		MOV BX, abso_imag_part
		CMP AX, BX
		JBE Result_Octant_6 
		JB Octant_7
		JNBE Octant_7
		JNB Octant_7

	Result_Octant_6:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 6
		MOV Octant, AL
		MOV BX, PI_N_HALF
		MOV DX, theta_y
		SUB BX, DX
		MOV Theta, EBX
		RET

	;
	Octant_7:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, abso_imag_part
		CMP AX, BX
		JAE Result_Octant_7 
		JA Octant_8
		JNA Octant_8
		JNAE Octant_8

	Result_Octant_7:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 7
		MOV Octant, AL
		MOV BX, PI_N_HALF
		MOV DX, theta_y
		SUB BX, DX
		MOV Theta, EBX
		RET

	;
	Octant_8:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, real_part
		MOV BX, abso_imag_part
		CMP AX, BX
		JA Result_Octant_8

	Result_Octant_8:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AL, 8
		MOV Octant, AL
		MOV BX, theta_x
		MOV Theta, EBX
		RET

 INVOKE ExitProcess, 0

ac_atan2 ENDP

; (insertar procesos adicionales aqui)

END