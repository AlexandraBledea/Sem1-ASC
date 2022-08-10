bits 32

global  start 

extern  exit
import  exit msvcrt.dll

segment  code use32 class=code
start:
    mov AX, 10 ; AX=10
    mov BL, 4 ;BL=4
    div BL ; AL=AX/BL=10/4=2    AH=AX%BL=10%4=2
    push   dword 0
    call   [exit]