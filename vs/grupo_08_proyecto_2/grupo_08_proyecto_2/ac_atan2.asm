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
REAL_MULT_IMAG    DD   0
PI_ROUND          DD  0
PI_N_ROUND        SDWORD  0          ; negativo 
PI_HALF           DD   0
PI_N_HALF         SDWORD   0          ; negativo 
PI_QUARTS         DD   0
PI_N_QUARTS       SDWORD   0          ; negativo 
THREE_PI_QUARTS   DD  0
THREE_N_PI_QUARTS SDWORD  0          ; negativo 

; declarar variantes aqui  
abso_real_part    DD 0
abso_imag_part    DD 0
x_pot_2           DD 0
y_pot_2           DD 0
x_mov_2_right     DD 0
x_mov_5_right     DD 0
y_mov_2_right     DD 0
y_mov_5_right     DD 0
  
sum_x_y           DD 0 
mov_x_15_right    DD 0  
theta_x           DD 0 
  
sum_y_x           DD 0
mov_y_15_right    DD 0
theta_y           DD 0

.code

 ; Escribir codigo aqui 
 ac_atan2 PROC real_part:SWORD, imag_part:SWORD

	MOV eax, DWORD PTR 0
	MOV eBx, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV edx, DWORD PTR 0

	;Function real_mult_imag
	MOV AX, real_part
	MOV BX, imag_part
	MUL EBX
	MOV REAL_MULT_IMAG, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Constant PI_ROUND
	MOV EAX, 102944
	MOV PI_ROUND, EAX

	XOR EAX, EAX

	;Constant PI_HALF
	MOV EAX, 51472
	MOV PI_HALF, EAX

	XOR EAX, EAX

	;Constant PI_QUARTS
	MOV EAX, 25736
	MOV PI_QUARTS, EAX

	XOR EAX, EAX

	;Constant THREE_PI_QUARTS
	MOV EAX, 77208
	MOV THREE_PI_QUARTS, EAX

	XOR EAX, EAX

	;Function neg pi_round
	mov EAX, PI_ROUND
	NEG EAX
	MOV PI_N_ROUND, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_half
	mov EAX, PI_HALF
	NEG EAX
	MOV PI_N_HALF, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg pi_quarts
	mov EAX, PI_QUARTS
	NEG EAX
	MOV PI_N_QUARTS, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function neg tree_pi_quarts
	mov EAX, THREE_PI_QUARTS
	NEG EAX
	MOV THREE_N_PI_QUARTS, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mult real_part
	MOV AX, real_part
	MOV BX, real_part
	MUL EBX
	MOV x_pot_2, EAX				

	XOR EAX, EAX
	XOR EBX, EBX

	;Function imag_part mult imag_part
	MOV AX, imag_part
	MOV BX, imag_part
	MUL EBX
	MOV y_pot_2, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_part mov 2 right
	MOV ECX, x_pot_2
	SHR ECX, 2
	MOV x_mov_2_right, ECX

	XOR ECX, ECX

	;Function real_part mov 5 right
	MOV ECX, x_pot_2
	SHR ECX, 5
	MOV x_mov_5_right, ECX

	XOR ECX, ECX

	;Function imag_part mov 2 right
	MOV ECX, y_pot_2
	SHR ECX, 2
	MOV y_mov_2_right, ECX

	XOR ECX, ECX

	;Function imag_part mov 5 right
	MOV ECX, y_pot_2
	SHR ECX, 5
	MOV y_mov_5_right, ECX

	XOR EAX, EAX
	XOR EBX, EBX
	XOR ECX, ECX

	;Function sum x_pot_2 + y_mov_2_right + y_mov_5_right
	MOV EAX, x_pot_2
	MOV EBX, y_mov_2_right
	ADD EAX, EBX
	XOR EBX, EBX
	MOV EBX, y_mov_5_right
	ADD EAX, EBX
	MOV sum_x_y, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function sum_x_y mov 15 right
	MOV ECX, sum_x_y
	SHR ECX, 15
	MOV mov_x_15_right, ECX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_mult_imag div mov_x_rigth
	MOV EAX, REAL_MULT_IMAG
	cdq
	MOV EBX, mov_x_15_right
	cmp bl,0 ; verifica el divisor
	je NotDivisionZero ; ¿cero? muestra error
	IDIV EBX

	NotDivisionZero:
		MOV theta_x, EAX



	XOR EAX, EAX
	XOR EBX, EBX

	;Function sum y_pot_2 + x_mov_2_right + x_mov_5_right
	MOV EAX, y_pot_2
	MOV EBX, x_mov_2_right
	ADD EAX, EBX
	XOR EBX, EBX
	MOV EBX, x_mov_5_right
	ADD EAX, EBX
	MOV sum_y_x, EAX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function sum_y_x mov 15 right
	MOV ECX, sum_y_x
	SHR ECX, 15
	MOV mov_y_15_right, ECX

	XOR EAX, EAX
	XOR EBX, EBX

	;Function real_mult_imag div mov_x_rigth
	MOV EAX, REAL_MULT_IMAG
	cdq
	MOV EBX, mov_y_15_right
	cmp bl,0 ; verifica el divisor
	je NotDivisionZero2 ; ¿cero? muestra error
	IDIV EBX

	NotDivisionZero2:
		MOV theta_y, EAX	
	
	XOR EAX, EAX
	XOR EBX, EBX

	;Function absolute real_part   
	; abs(eax), with no branches.
	MOV AX, real_part
	CMP AX, 0
	JB Conver_Abso_real_part
	MOV abso_real_part, EAX
	JMP Compare1

	Conver_Abso_real_part:
		MOV AX, real_part
		MOV BX, 1
		NEG BX
		MUL BX
		MOV abso_real_part, EAX


	;Function absolute imag_part  
	; abs(eax), with no branches.
	Compare1:
		XOR EAX, EAX
		XOR EBX, EBX

		MOV AX, imag_part
		JB Conver_Abso_imag_part
		MOV abso_imag_part, EAX
		JMP Undefined_angle

		Conver_Abso_imag_part:
			MOV AX, real_part
			MOV BX, 1
			NEG BX
			MUL BX
			MOV abso_imag_part, EAX

;-----------------------------------------------------------------------------------------------------------

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
		MOV AX, 0
		RET

	;Special Angle 0 and 360 
	;If real part is greater then zero continus check ,
	;If imag part is equal to zero Angle found if not check other angle.
	Angle_0_360:
		MOV AX, real_part
		CMP AX, 0
		JA Angle_0_360_2
		JNA Angle_45
		JAE Angle_45
		JNAE Angle_45

	Angle_0_360_2:
		MOV BX, imag_part
		ADD BX, 0
		JZ Resultado
		JNZ Angle_45

	Resultado:
		MOV AX, 0
		RET

	;Angle 45
	;If real part is greater then zero continue check, 
	;then if real part and image part are the same angle found, 
	;if not check other angle.
	Angle_45:
		MOV AX, real_part
		CMP AX, 0
		JA Angle_45_2
		JNA Angle_90
		JAE Angle_90
		JNAE Angle_90

	Angle_45_2:
		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JE Resultado_45
		JNE Angle_90


	Resultado_45:
		MOV EAX, PI_QUARTS
		RET

	; Angle 90
	;If real part is zero continue check, 
	;If imag part is greater then zero angle found, 
	;if not check other angle.
	Angle_90:
		MOV AX, real_part
		ADD AX, 0
		JZ Angle_90_2
		JNZ Angle_135

	Angle_90_2:
		MOV BX, imag_part
		CMP BX, 0
		JA Resultado_90
		JNA Angle_135
		JAE Angle_135
		JNAE Angle_135

	Resultado_90:
		MOV EAX, PI_HALF
		RET

	;Angle 135
	Angle_135:
		MOV BX, imag_part
		CMP BX, 0
		JA Angle_135_2
		JNA Angle_180
		JAE Angle_180
		JNAE Angle_180

	Angle_135_2:
		MOV EAX, abso_real_part
		CMP BX, AX
		JE Resultado_135
		JNE Angle_180    

	Resultado_135:
		MOV EAX, THREE_PI_QUARTS
		RET

	;Angle 180
	Angle_180:
		MOV AX, real_part
		CMP AX, 0
		JNAE Angle_180_2
		JNA Angle_225
		JAE Angle_225
		JA Angle_225

	Angle_180_2:
		MOV BX, imag_part
		ADD BX, 0
		JZ Resultado_180
		JNZ Angle_225

	Resultado_180:
		MOV EAX, PI_ROUND
		RET

	;Angle 225
	Angle_225:
		MOV AX, real_part
		CMP AX, 0
		JNAE Angle_225_2
		JNA Angle_270
		JAE Angle_270
		JA Angle_270

	Angle_225_2:
		MOV EAX, abso_real_part 
		MOV EBX, abso_imag_part 
		CMP AX, BX 
		JE Resultado_225
		JNE Angle_270

	Resultado_225:
		MOV EAX, THREE_N_PI_QUARTS
		RET

	;Angle 270
	Angle_270:
		MOV BX, real_part
		ADD BX, 0
		JZ Angle_270_2
		JNZ Angle_315
	
	Angle_270_2:
		MOV AX, imag_part
		CMP AX, 0
		JNAE Resultado_270
		JNA Angle_315
		JAE Angle_315
		JA Angle_315

	Resultado_270:
		MOV EAX, PI_N_HALF
		RET

	;Angle 315
	Angle_315:
		MOV EAX, abso_imag_part
		MOV BX, real_part
		Cmp AX, BX
		JE Resultado_315
		JNE Octant_1

	Resultado_315:
		MOV EAX, PI_N_QUARTS
		RET

;--------------------------------------------------------------------------------------------
	
	;
	Octant_1:
		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JA Result_Octant_1
		JNA Octant_2
		JAE Octant_2
		JNAE Octant_2
		

	Result_Octant_1:
		MOV EBX, theta_x
		MOV AX, BX
		RET

	;
	Octant_2:
		MOV AX, real_part
		MOV BX, imag_part
		CMP AX, BX
		JBE Result_Octant_2
		JB Octant_3
		JNB Octant_3
		JNBE Octant_3

	Result_Octant_2:
		MOV EBX, PI_HALF
		MOV EDX, theta_y
		SUB BX, DX
		MOV AX, BX
 		RET

	;
	Octant_3:
		MOV EAX, abso_real_part
		MOV BX, imag_part
		CMP AX, BX
		JBE Result_Octant_3
		JB Octant_4
		JNB Octant_4
		JNBE Octant_4 

	Result_Octant_3:
		MOV EBX, PI_HALF
		MOV EDX, theta_y
		SUB BX, DX
		MOV AX, BX
		RET

	;
	Octant_4:
		MOV EAX, abso_real_part
		MOV BX, imag_part
		CMP AX, BX
		JA Result_Octant_4 
		JNA  Octant_5
		JAE Octant_5
		JNAE Octant_5

	Result_Octant_4:
		MOV EBX, PI_ROUND
		MOV EDX, theta_x
		ADD DX, BX
		MOV AX, DX
		RET

	;
	Octant_5:
		MOV EAX, abso_real_part
		MOV EBX, abso_imag_part
		CMP AX, BX
		JA Result_Octant_5 
		JNA Octant_6
		JAE Octant_6
		JNAE Octant_6

	Result_Octant_5:
		MOV EBX, PI_N_ROUND
		MOV EDX, theta_x
		ADD DX, BX
		MOV AX, DX
		RET

	;
	Octant_6:
		MOV EAX, abso_real_part
		MOV EBX, abso_imag_part
		CMP AX, BX
		JBE Result_Octant_6 
		JB Octant_7
		JNBE Octant_7
		JNB Octant_7

	Result_Octant_6:
		MOV EBX, PI_N_HALF
		MOV EDX, theta_y
		SUB BX, DX
		MOV AX, BX
		RET

	;
	Octant_7:
		MOV AX, real_part
		MOV EBX, abso_imag_part
		CMP AX, BX
		JAE Result_Octant_7 
		JA Octant_8
		JNA Octant_8
		JNAE Octant_8

	Result_Octant_7:
		MOV EBX, PI_N_HALF
		MOV EDX, theta_y
		SUB BX, DX
		MOV AX, BX
		RET

	;
	Octant_8:
		MOV AX, real_part
		MOV EBX, abso_imag_part
		CMP AX, BX
		JA Result_Octant_8

	Result_Octant_8:
		MOV EBX, theta_x
		MOV AX, BX
		RET

 INVOKE ExitProcess, 0

ac_atan2 ENDP

; (insertar procesos adicionales aqui)
WriteString      PROTO

END