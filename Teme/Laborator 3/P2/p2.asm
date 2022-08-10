bits 32

global  start 


extern  exit
import  exit msvcrt.dll

; (c+b+b)-(c+a+d)
; the result for this set of data should be 200
segment  data use32 class=data 
    a db 40
    b dw 150
    c dd 100
    d dq 60

    
segment  code use32 class=code
start:

    mov AX, [b]
    cwd
    ; DX:AX = b
    
    
    mov CX, word[c]
    mov BX, word[c+2]
    ; BX:CX = c
    
    
    add CX, AX
    adc BX, DX
    ; BX:CX = c + b
    
    
    add AX, CX
    adc DX, BX
    ; BX:CX = c + b + b
    
    
    push DX
    push AX
    pop EBX
    ; EBX = c + b + b
    
    mov EDI, EBX
    ; EBX = c + b + b
    
    
    mov AL, [a]
    cbw
    ; AX = a
    cwd
    ; DX:AX = a
    
    
    mov CX, word[c]
    mov BX, word[c+2]
    ; BX:CX = c
    
    
    add AX, CX
    adc DX, BX
    ; DX:AX = c + a
    
    push DX
    push AX
    pop EAX
    ; EAX = c + a
    
    cdq
    ; EDX:EAX = c + a
    
    mov ECX, dword[d]
    mov EBX, dword[d+4]
    ; EBX:ECX = d
    
    add ECX, EAX
    adc EBX, EDX
    ; EBX:ECX = c + a + d
    
    mov EAX, EDI ; EAX = c + b + b
    cdq
    ; EDX:EAX = c + b + b
    
    sub EAX, ECX
    sbb EDX, EBX
    ; EDX:EAX = (c + b + b) - (c + a + d)



    push   dword 0
    call   [exit]