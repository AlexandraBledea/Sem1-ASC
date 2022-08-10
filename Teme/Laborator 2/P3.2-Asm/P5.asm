bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;calculate the expression: a*(b+c)+34

;for a=100,b=50,c=10 the result should be 400
segment  data use32 class=data 
    a db 10
    b db 50
    c db 10


segment  code use32 class=code
start:
    mov AL, [b] ; AL = b --> AL = 50
    add AL, [c] ; AL = AL + c --> AL = 50 + 10 --> AL = 60
    mov AH, [a] ; AH = b --> AH = 10
    mul AH ; AX = AL * AH --> AX = 60 * 10 --> AX = 600
    add AX, 34 ; AX = AX + 34 --> AX = 600 + 34 --> AX = 634
    
    push   dword 0
    call   [exit]