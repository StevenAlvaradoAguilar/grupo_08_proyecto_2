; Descripcion del Programa:
; Autor:
; Dia:

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; declarar variables aqui

.code

main PROC
 ; Escribir codigo aqui 
io_functions PROC 


 INVOKE ExitProcess, 0

main ENDP

; (insertar procesos adicionales aqui)

END main