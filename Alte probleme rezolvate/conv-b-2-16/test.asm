bits 32

global start

extern exit, printf, scanf, fread, fclose, fopen

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll

segment data use32 class=data
    number dd 0
    format db "%x", 0

segment code use32 class=code
    start:
        mov esi, number
        mov ebx, 0b
    .convert:
        lodsb
        cmp al, 0
        jz .endc
        sub al, 48
        mov ah, 0
        mov dx, 0
        push dx
        push ax
        pop eax
        add ebx, eax
        rol ebx, 1
   jmp .convert
   .endc:
        ror ebx, 1
        mov eax, ebx
        
    push dword EAX
    push dword format
    call [printf]
        
    push dword 0
    call [exit]