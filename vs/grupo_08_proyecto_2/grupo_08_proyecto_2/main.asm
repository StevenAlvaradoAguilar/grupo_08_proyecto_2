; Descripcion del Programa:
; Autor:
; Dia:

.386
.model flat,stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

;We include the libraries links to Irvine so we can call the Irvine procedures
include    c:\Irvine\Irvine32.inc
includelib c:\Irvine\Irvine32.lib
includelib c:\Irvine\Kernel32.lib
includelib c:\Irvine\user32.lib
include    io_functions.inc          ;We include an .inc file that declares a prototype of the function
include    ac_atan2.inc              ;We include an .inc file that declares a prototype of the function

.data
; declarar variables aqui
real_part SWORD 0
imag_part SWORD 0

.code

main PROC
	
	MOV eax, DWORD PTR 0
	MOV EBX, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV edx, DWORD PTR 0

	;Calls the class RequestIntegers and gives it the data
	INVOKE read_values

	MOV real_part, AX	;The value in x
	MOV	imag_part, BX  ;The value in y

	;Calls the class uint8_mult and gives it the data,
	INVOKE ac_atan2, real_part, imag_part

	INVOKE write_values

	

 INVOKE ExitProcess, 0

main ENDP

; (insertar procesos adicionales aqui)
;WriteString  PROTO
;Crlf         PROTO

END main