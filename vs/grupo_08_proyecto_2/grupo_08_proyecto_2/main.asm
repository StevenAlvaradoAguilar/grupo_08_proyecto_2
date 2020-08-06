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
include io_functions.inc ;We include an .inc file that declares a prototype of the function
include ac_atan2.inc ;We include an .inc file that declares a prototype of the function

.data
; declarar variables aqui
real_part DWORD 0
imag_part DWORD 0

.code

main PROC

	;Calls the class RequestIntegers and gives it the data
	INVOKE io_functions

	MOV real_part, ebx	;
	MOV	imag_part, eax		;
	popad
	;Calls the class uint8_mult and gives it the data,
	INVOKE ac_atan2, real_part, imag_part 

 INVOKE ExitProcess,0

main ENDP

; (insertar procesos adicionales aqui)

END main