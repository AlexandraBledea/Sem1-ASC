bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;calculate the expression: (c-a-d)+(c-b)-a
; for a=15,b=10,c=100,d=30 the result should be 130

segment  data use32 class=data 
    a DB 15
    b DB 10
    c DB 100
    d DB 30

segment  code use32 class=code
start:
    mov AX, [a] ; AX = 15
    mov CX, [c] ; CX = 100
    mov DX, [d] ; DX = 30
    
    sub CX,AX ; CX = CX - AX --> CX = 100 - 15 --> CX = 85 
    sub CX,DX ; CX = CX - DX --> CX=85 - 30 --> CX = 55
    
    mov AX, [c] ; AX = 100
    mov BX, [b] ; BX = 10
    
    sub AX, BX ; AX = AX - BX --> AX = 100 - 10 --> AX = 90
    
    add CX, AX ; CX = CX + AX --> CX = 55 + 90 --> CX = 145
    
    mov AX, [a] ; AX = 15
    
    sub CX, AX ; CX = CX - AX --> CX = 145 - 15 --> CX = 130
    
    push   dword 0
    call   [exit] 
    