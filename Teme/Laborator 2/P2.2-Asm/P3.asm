bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;calculate the expression: (c+b+b)-(c+a+d)
;for a=100,b=200,c=50,d=125 the result should be 175

segment  data use32 class=data 
    a DW 100
    b DW 200
    c DW 50
    d DW 125

segment  code use32 class=code
start:
    mov CX, [c] ; CX = 50
    
    add CX,[b] ; CX = CX + b --> CX = 50 + 200 --> CX = 250
    add CX,[b] ; CX = CX + b --> CX = 250 + 200 --> CX = 450
    
    mov BX, [c] ; BX = 50
    
    add BX, [a] ; BX = BX + a --> BX = 50 + 100 --> BX = 150
    add BX, [d] ; BX = BX + d --> BX = 150 + 125 --> BX = 275
    
    sub CX, BX ; CX = CX - BX --> CX = 450 - 275 --> CX = 175
    
    push   dword 0
    call   [exit]