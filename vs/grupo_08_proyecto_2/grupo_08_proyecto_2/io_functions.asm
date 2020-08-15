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
include    c:\Irvine\Macros.inc

include    io_functions.inc                 ;We include an .inc file that declares a prototype of the function

buffer_size = 5000
buffer_Msg  = 37

.data
; declarar variables aqui
buffer               BYTE   buffer_size DUP(?)
Pointer              BYTE   SIZEOF buffer DUP(0)
fileName             BYTE   "input_data.txt", 0
fileHandler          HANDLE ?
Msg                  BYTE   "Octant = ", 0
Msg1                 BYTE   "X = ", 0
Msg2                 BYTE   "Y = ", 0
Msg3                 BYTE   "Angle: ", 0
Msg4                 BYTE   "theta = ", 13,10,0
fileName2            BYTE   "output_data.txt", 0
String_real_part     BYTE    "0", 0 
String_imag_part     BYTE    "0", 0
real_part            WORD    0 
imag_part            WORD    0
Octant               BYTE    0
Theta                WORD    0

.code
 ; Escribir codigo aqui 

io_functions PROC 

    MOV eax, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV ecx, DWORD PTR 0
	MOV edx, DWORD PTR 0
    
    ; Abre el archivo en modo de entrada.
    read_values PROC
         mov edx, OFFSET fileName
         call OpenInputFile
         mov fileHandler, eax

        ; Lee el archivo y lo coloca en un búfer.
         mov edx, OFFSET buffer                       ;NO BORRRAR
         mov ecx, buffer_size                         ;NO BORRRAR
         call ReadFromFile                            ;NO BORRRAR
         ;We move through read file to get one by one each operator
         mov  esi, OFFSET buffer
         mov  edi, OFFSET Pointer
         mov  ecx, SIZEOF buffer
         L1:
            mov  al, [esi]                                ; get a character from buffer
            mov  [edi], al                                 ; store it in the Pointer
            mov al, [edi]
            CMP AL, ";"
            JE L2
            mov String_real_part, AL
            mov edx, OFFSET String_real_part
            call WriteString
            inc  esi                                      ; move to next character
            inc  edi
            loop L1
            ret

         L2:
            inc  esi                                      ; move to next character
            inc  edi
            mov  al, [esi]                                ; get a character from buffer
            mov  [edi], al                                 ; store it in the Pointer
            mov al, [edi]
            CMP AL, 13
            JE L3
            mov String_imag_part, AL
            mov edx, OFFSET String_imag_part
            call WriteString
            loop L2
            ret

         L3:
            inc  esi                                      ; move to next character
            inc  edi
            mov  al, [esi]                                ; get a character from buffer
            mov  [edi], al                                 ; store it in the Pointer
            mov al, [edi]
            CMP AL, 10
            loop L4
            ret
        L4:
            
            
            loop L1
            ret

     read_values endp
    
    write_values PROC
         ; Crea un nuevo archivo de texto.
         mov edx, OFFSET fileName2
         call CreateOutputFile
         mov fileHandler, eax

         ;Escribe el búfer en el archivo de salida.

         ;  Escribe el mensaje de Octante en el archivo  
         MOV EDX, OFFSET Msg
         mov ecx, buffer_Msg  
         CALL WriteToFile
         
         ;  Escribe el mensaje del X en el archivo  
         MOV EDX, OFFSET Msg1
         mov ecx, buffer_Msg  
         CALL WriteToFile

         ;  Escribe el mensaje del Y en el archivo  
         MOV EDX, OFFSET Msg2
         mov ecx, buffer_Msg  
         CALL WriteToFile

         ;  Escribe el mensaje del Angle en el archivo  
         MOV EDX, OFFSET Msg3
         mov ecx, buffer_Msg  
         CALL WriteToFile

         ;  Escribe el mensaje del Angle en el archivo  
         MOV EDX, OFFSET Msg4
         mov ecx, buffer_Msg  
         CALL WriteToFile

         mov eax, fileHandler                 ;NO BORRAR
         mov edx, OFFSET buffer               ;NO BORRAR
         mov ecx, buffer_size                 ;NO BORRAR
         call WriteToFile                     ;NO BORRAR

    write_values endp

    cerrar_archivo:
        mov eax, fileHandler
        call CloseFile


    exit

io_functions ENDP

; (insertar procesos adicionales aqui)
;Clrscr           PROTO                   ; clear the screen
OpenInputFile    PROTO                    ; open file in input mode
ReadFromFile     PROTO                    ; read buffer from input file
WriteToFile      PROTO                    ; write the buffer in the file
CreateOutputFile PROTO                    ; create file for writing
WriteInt         PROTO
WriteString      PROTO
;Crlf             PROTO
CloseFile        PROTO                    ; close a file handle

END