; Descripcion del Programa: Function atan2
; Autor: Steven Alvarado Aguilar, Andres Lopéz Sánchez, Fabian Lopéz Sánchez
; Dia: 16/ 08/ 2020

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

.data
; declarar variables aqui
buffer               WORD    buffer_size DUP(?)
fileName             BYTE    "input_data.txt", 0
fileHandler          HANDLE  ?
fileName2            BYTE    "output_data.txt", 0
real_part            SDWORD  0 
imag_part            SDWORD  0
negative_real_part   SDWORD  0          ; negative
negative_imag_part   SDWORD  0          ; negative
tamanno_Number       BYTE    0
tamanno_Number1      BYTE    0
tamanno_Number_Real  BYTE    0
tamanno_Number_Imag  BYTE    0
tamanno_Total        DWORD   0
array_Real_Part      WORD    73 DUP(?)
array_Imag_Part      WORD    73 DUP(?)

.code
 ; Escribir codigo aqui 

io_functions PROC 
    
    ;Hace que los registros inicien con 0
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
         mov edx, OFFSET buffer                           ;NO BORRRAR
         mov ecx, buffer_size                             ;NO BORRRAR
         call ReadFromFile                                ;NO BORRRAR

         ;We move through read file to get one by one each operator
         mov  esi, OFFSET buffer

         Tam_Num:
             mov al, [esi]
             CMP AL, ";"
             je Mov_ESI_Number
             INC ESI
             cmp al, '-'
             JE Tam_Num
             MOV BL, tamanno_Number
             INC BL
             MOV tamanno_Number_Real, BL
             MOV BL, tamanno_Number_Real
             MOV tamanno_Number, BL
             jmp Tam_Num
        
        ;Reset esi because start the first data
        Mov_ESI_Number:
            mov  esi, OFFSET buffer
            JMP L1

        L1:
            mov al, [esi]                                 ; get a character from buffer
            cmp byte ptr [esi], '-'                       ;Compare the first bit o character with - negative
            je negative                                   ;if X ='s a - then jump to negative.
            jmp convert                                   ;if positive then jump to convert.

            negative:  
                mov ch, 1                                 ;ch =1, a flag for negative
                inc esi                                   ;esi -> the first digit char

            convert:
                mov al, [esi]                             ;al = first digit char
                CMP AL, ";"
                je L2
                ;This part the convert ascii to int
                sub al, 48                                ; subtracts al by 48 first digit
                movzx eax, al                             ;al=>eax, unsigned
                ;mov ebx, 10                              ;ebx=>10, the multiplier
                JMP Form_Number
                INC ESI
                jmp L1

             Form_Number:
                   Mov cl, tamanno_Number
                   Cmp cl, 4
                   Je X_1000

                   Cmp cl, 3
                   Je X_100

                   Cmp cl, 2
                   Je X_10

                   Cmp cl, 1
                   Je X_1

            X_1000:
                  mov ebx, 1000
                  mul ebx
                  add real_part, eax
                  dec cl 
                  mov tamanno_Number, cl
                  inc ESI
                  jmp L1

            X_100:
                  mov ebx, 100
                  mul ebx
                  add real_part, eax
                  dec cl 
                  mov tamanno_Number, cl
                  inc ESI
                  jmp L1

             X_10:
                  mov ebx, 10
                  mul ebx
                  add real_part, eax
                  dec cl 
                  mov tamanno_Number, cl
                  inc ESI
                  jmp L1

             X_1:
              mov ebx, 1
              mul ebx
              add real_part, eax
              dec cl 
              mov tamanno_Number, cl
              INC ESI
              INC ESI
              cmp ch, 1	               ; a negative number?
              je changeToNeg
              jmp Tam_Num2

            changeToNeg:
                MOV EAX, real_part
                neg EAX
                mov negative_real_part, EAX


            Tam_Num2:
                 mov al, [esi]
                 CMP AL, 13
                 je Mov_ESI_Number2
                 INC ESI
                 cmp al, '-'
                 JE Tam_Num2
                 MOV BL, tamanno_Number1
                 INC BL
                 MOV tamanno_Number_Imag, BL
                 MOV BL, tamanno_Number_Imag
                 MOV tamanno_Number1, BL
                 jmp Tam_Num2

            Mov_ESI_Number2:
                mov  esi, OFFSET buffer
                mov ch, 0                                 ;ch=0, a flag for positive
                JMP Verification_ESI_Imag

            Verification_ESI_Imag:
                mov al, [esi]
                CMP AL, ";"
                JE L2
                INC ESI
                JMP Verification_ESI_Imag

          L2:
            INC ESI
            mov al, [esi]                                 ; get a character from buffer
            cmp byte ptr [esi], '-'                       ;Compare the first bit o character with - negative
            je negative2                                  ;if X ='s a - then jump to negative.
            jmp convert2                                  ;if positive then jump to convert.

            negative2:
                mov ch, 1                                 ;ch =1, a flag for negative
                inc esi                                   ;esi -> the first digit char

            convert2:
                mov al, [esi]                             ;al = first digit char
                CMP AL, ";" 
                je L3
                ;This part the convert ascii to int
                sub al, 48                               ; subtracts al by 48 first digit
                movzx eax, al                            ;al=>eax, unsigned
                ;mov ebx, 10                              ;ebx=>10, the multiplier
                JMP Form_Number1
                INC ESI
                jmp L2

             Form_Number1:
                   Mov cl, tamanno_Number1
                   Cmp cl, 4
                   Je Y_1000

                   Cmp cl, 3
                   Je Y_100

                   Cmp cl, 2
                   Je Y_10

                   Cmp cl, 1
                   Je Y_1

            Y_1000:
                  mov ebx, 1000
                  mul ebx
                  add imag_part, eax
                  dec cl 
                  mov tamanno_Number1, cl
                  jmp L2

            Y_100:
                  mov ebx, 100
                  mul ebx
                  add imag_part, eax
                  dec cl 
                  mov tamanno_Number1, cl
                  jmp L2

             Y_10:
                  mov ebx, 10
                  mul ebx
                  add imag_part, eax
                  dec cl 
                  mov tamanno_Number1, cl
                  jmp L2

             Y_1:
              mov ebx, 1
              mul ebx
              add imag_part, eax
              dec cl 
              mov tamanno_Number1, cl
              cmp ch, 1				               ; a negative number?
              je changeToNeg2
              jmp L3

            changeToNeg2:
                MOV EAX, imag_part
                neg eAx
                MOV negative_imag_part, eAx
                MOV EAX, negative_imag_part
                MOV imag_part, EAX

         L3:

            ;Mandar los números al atan2
            MOV EAX, real_part
            MOV EBX, imag_part
            ret
            INC ECX

            JMP Tam_Num
            
            


     read_values endp
    
    write_values PROC

         ; Crea un nuevo archivo de texto.
         MOV BX, AX
         CALL WriteInt
         mov edx, OFFSET fileName2
         call CreateOutputFile
         mov fileHandler, eax

         ;Escribe el búfer en el archivo de salida.

         Conver_Int_to_String:
            mov  bl, [esi]
            CMP AL, 13 
            LOOP Conver_Int_to_String
        

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