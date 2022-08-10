bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;(c-a-d)+(c-b)-a

segment  data use32 class=data 
    a db 100
    b dw 500
    c dd 700
    d dq 30

    
segment  code use32 class=code
start:

    mov EBX, [c] ; EBX = c
    sub EBX, dword [b] ; EBX = c - b
    sub EBX, dword [a] ; EBX = (c - b) - a
    
    mov EAX, [c]
    sub EAX, dword [a]



    push   dword 0
    call   [exit]