bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;(c-a-d)+(c-b)-a
; the result should be for this set of data 670

segment  data use32 class=data 
    a db 100
    b dw 500
    c dd 700
    d dq 30
    
    
segment  code use32 class=code
start:

    mov EBX, [c] ; EBX = c 
    mov AX, [b] ; AX = b
    mov DX, 0 ; DX = 0
    
    push DX
    push AX
    pop EAX ; EAX = b
    
    mov EDX, EAX ; EDX = b
    
    sub EBX, EAX ; EBX = c - b
    
    mov AL, [a] ; AL = a
    mov DX, 0 ; DX = 0
    mov AH, 0 ; AH = 0
    
    push DX
    push AX
    pop EAX
    
    sub EBX, EAX ; EBX = (c - b) - a
    
    add EDX, EBX ; EDX = b + c - b - a --> EDX = c - a
    
    mov ESI, EBX ; ESI = (c - b) - a
    
    mov EAX, EDX ; EAX = c - a
    mov EDX, 0 ; EDX = 0
    ; EDX:EAX = c - a
    
    mov ECX, dword[d] ; ECX = low part of d
    mov EBX, dword[d+4] ; EBX = high part of d
    ; EBX:ECX = d
    
    sub EAX, ECX 
    sbb EDX, EBX 
    ; EDX:EAX = (c - a - d) --> EDX:EAX = EDX:EAX - EBX:ECX 
    
    mov ECX, ESI ; ECX = (c - b) - a
    mov EBX, 0 ; EBX = 0
    ; EBX:ECX = (c - b) - a  
    
    add EAX, ECX
    adc EDX, EBX
    ; EDX:EAX = (c - a - d) + (c - b) - a
    
    push   dword 0
    call   [exit]