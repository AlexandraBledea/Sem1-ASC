bits 32

global  start 


extern  exit
import  exit msvcrt.dll


;(a+b/c-1)/(b+2)-x
;unsigned

segment  data use32 class=data 
    a dd 197
    b db 8
    c dw 2
    x dq 10

    
segment  code use32 class=code
start:

   
    mov AL, [b] ; AH = b
    mov AH, 0 ; AX = b
    mov DX, 0 ; DX:AX = b
    div word[c] ; AX = b/c
    
    mov DX, 0 ; DX:AX = b/c
    
    mov CX, word[a]
    mov BX, word[a+2]
    ; BX:CX = a
    
    add CX, AX
    adc DX, BX
    ; BX:CX = a + b/c
    
    sub CX, 1
    sbb BX, 0
    ; BX:CX = a + b/c - 1
    
    mov AL, [b] ; AL = b
    add AL, 2 ; AL = b + 2
    mov AH, 0 ; AX = b + 2
    mov DX, BX 
    mov BX, AX
    ; BX = b + 2
    mov AX, CX
    ; DX:AX = a + b/c - 1
    
    div BX
    ; AX = (a + b/c - 1)/(b + 2)
    
    mov DX, 0
    ; DX:AX = (a + b/c - 1)/(b + 2)
    
    push DX
    push AX
    push EAX
    
    mov EDX, 0
    ; EDX:EAX = (a + b/c - 1)/(b + 2)
    
    mov ECX, dword [x]
    mov EBX, dword [x+4]
    ; EBX:EAX = x
    
    sub EAX, ECX
    sbb EDX, EBX
    ; EDX:EAX = (a + b/c - 1)/(b + 2)-x
    ; the quotient will be in EAX
    ; the reminder will be in EDX

    push   dword 0
    call   [exit]