bits 32

global  start 


extern  exit
import  exit msvcrt.dll


;(a+b/c-1)/(b+2)-x
; The result shoudl be 10 for this example
;signed

segment  data use32 class=data 
    a dd 197
    b db 8
    c dw 2
    x dq 10

    
segment  code use32 class=code
start:
;(a+b/c-1)/(b+2)-x
    mov AL, [b]
    cbw
    cwd
    ;DX:AX = b
    idiv word [c]
    ;AX = b/c
    ;DX = b%c
    
    cwd
    mov CX, word[a]
    mov BX, word[a+2]
    ; BX:CX = a
    
    add CX, AX
    adc BX, DX
    ; BX:CX = a + b/c
    
    sub CX, 1
    sbb BX, 0
    ; BX:CX = a + b/c - 1
    
    mov AL, [b]
    add AL, 2
    cbw
    ; AX = b + 2
    mov DX, BX
    mov BX, AX
    ; BX = b + 2
    mov AX, CX
    ; DX:AX = a + b/c - 1
    idiv BX
    ; AX = (a + b/c - 1)/(b + 2)
    
    mov ECX, dword [x]
    mov EBX, dword [x+4]
    ; EBX:ECX = x
    
    cwde
    cdq
    ; EDX:EAX = (a + b/c - 1)/(b + 2) 
    
    sub EAX, ECX
    sbb EDX, EBX
    
    ; EBX:EAX = (a + b/c - 1)/(b + 2) - x


    push   dword 0
    call   [exit]