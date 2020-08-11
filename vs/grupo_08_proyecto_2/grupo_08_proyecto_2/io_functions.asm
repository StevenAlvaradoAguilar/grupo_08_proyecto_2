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
include    io_functions.inc           ;We include an .inc file that declares a prototype of the function

.data
; declarar variables aqui
filename       db 'input_data.txt',0	
filenameresult db 'output_data.txt',0	 
NLine          db 13, 10, '$'
handle         dw 0                  ; will be the file handle. the number that DOS assigns to the open file.
buffer         db 255 DUP (' ')      ; make a plain buffer (not a strange input one like before).  
;result_text db 250 dup('$')      
;result db "output.txt", 0   
handler        dw ?    
handler2       dw ?  
len            dw 0 
len2           db 255                ; we need an input buffer this time.

act            db 0

.code
 ; Escribir codigo aqui 

io_functions PROC 
MOV AX, @DATA 
MOV DS, AX 

	MOV AH, 3Dh                    ; 3Dh of DOS Services opens a file.
	MOV AL, 0                      ; 0 - for reading. 1 - for writing. 2 - both
	MOV DX, OFFSET filename        ; make a pointer to the filename
	INT 21h                        ; call DOS
	MOV handle,ax                  ; Function 3Dh returns the file handle in AX, here we save it for later use.

	;'DOS Service Function number 3Fh reads from a file.

	MOV AH, 3Fh
	MOV CX, 27                    ; I will assume imput_data.txt has atleast 4 bytes in it. CX is how many bytes to read.
	MOV DX, OFFSET buffer         ; DOS Functions like DX having pointers for some reason.
	MOV BX, handle                ; BX needs the file handle.
	INT 21h                       ; call DOS

	;Here we will put a $ after 4 bytes in the buffer and print the data read:

	MOV DX, OFFSET buffer
	ADD DX, AX                   ; Function 3Fh returns the actual amount of bytes read in AX (should be 4 if
	
	; nothing went wrong.
	MOV BX, DX
	MOV byte [bx], '$'			 ; byte pointer so we don't mess with the whole word (a word is 16bits).
            
    MOV CL, 20
    MOV BL, 1   

    MOV DX, OFFSET buffer		 ; put the pointer back in DX.
	MOV AH, 9

	INT 21h						 ; call DOS Function 9 (Print String).  
    MOV DX, OFFSET NLine		 ; put the pointer back in DX.

	MOV AH, 9
	INT 21h					     ; call DOS Function 9 (Print String).
	
		call to_lower

	return:  
	; call Print 
		LEA SI, buffer 
   
		mov DX, OFFSET buffer    ; put the pointer back in DX.
		mov AH, 9
		int 21h                  ; call DOS Function 9 (Print String).  

		mov DX, OFFSET NLine     ; put the pointer back in DX.
		mov AH, 9
		int 21h                  ; call DOS Function 9 (Print String).   
		
;---------------------------------------------------------------------------------------------------------

	label:  
         MOV AL,[SI] 

         ;mov dl,al
         ;mov ah,2h
         ; int 21h
         CALL moving1      
         CMP AL,'a'
         jge changeLetter
         ;cmp al,'A'
         ; jge changeLetter1step
         inc SI 
         dec CL
           

         ; mov bl,0 
         jnz label      

;---------------------------------------------------------------------------------------------------------   

         jz Print

;---------------------------------------------------------------------------------------------------------
	
	changeLetter: 
           
         cmp bl,1
         je changefirst  
         inc si 
             
         dec cl 
          
         jnz label
	     ;;;;;;;;;;;;;;;;  
         jz Print                     ; dont go down     
		         
		 jnz label    
		 changefirst:
		 ;inc si  
		 
		 mov al,[si]
		 sub al,32d  
		 mov [si],al
		 mov bl,0

		 inc si 
         ; dec cl
		 jnz label       
		 ;ret      
;---------------------------------------------------------------------------------------------------------
	
	moving1: 
	
		cmp al,' '
		je increment
		cmp al,'Z'
		jle decrement
		ret

	increment:
		mov bl,1
		ret 

	decrement:
		mov bl,0
		 ret
		  
	to_lower:
		lea si,buffer

	lower:
		mov al,[si]
		cmp al,60h
		jg inc_di_lo
		cmp al,40h
		jl inc_di_lo
		add al,20h
		mov [si],al
		inc si
		jmp lower
		inc_di_lo:
		inc si
		cmp al,'$'
		je return
		jmp lower    
  
	 Print:
		
		mov dx,offset buffer         ; put the pointer back in DX.
		mov ah,9
		int 21h                      ; call DOS Function 9 (Print String).   
		
			
;---------------------------------------------------------------------------------------------------------

        mov dx,offset filenameresult ; put offset of filename in dx 
		mov cx,0                     ; clear cx - make ordinary file 
		mov ah,3Ch                   ; function 3Ch - create a file 
		int 21h                      ; call DOS service 
		;mov dx,offset               ; put offset of filename in dx 
		mov ah,3Dh					 ; 3Dh of DOS Services opens a file.
		mov al,1					 ; 0 - for reading. 1 - for writing. 2 - both
		mov dx,offset filenameresult ; make a pointer to the filename
		int 21h						 ; call DOS
		mov handle,ax                ; Function 3Dh returns the file handle in AX, here we save it for later use.

	;Get input:

	;	mov ah,0Ah
		;mov dx,offset buffer
		;int 21h

;	DOS Service Function number 40h writes to a file.

		mov ah,40h
		mov bx,255                    ; pointer to number of bytes read from user.
		mov cl,27                     ; get the contents of the byte at the pointer.
		; note that even though CX takes the length, CL physically IS the low byte of CX.
		mov dx,offset buffer         ; pointer to the actual data in DX.
		mov bx,handle                ; BX needs the file handle.
		int 21h                      ; call DOS

;---------------------------------------------------------------------------------------------------------

		mov ah,4Ch
		int 21h                      ; Function 4Ch (Exit Program)      
   
		end

 INVOKE ExitProcess, 0

io_functions ENDP

; (insertar procesos adicionales aqui)

END 