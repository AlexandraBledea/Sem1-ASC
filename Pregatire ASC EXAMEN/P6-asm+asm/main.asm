bits 32

global start

extern exit, gets, printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

    len equ 100
    sir1 times len db 0
    sir2 times len db 0
    sir3 times len db 0
    format db "%c", 0
    character1 db 0

segment code use32 class=code
    start:
    
    mov EDI, sir1
    mov ECX, len
    repeat_reading1:
        ;scanf(format, character1)
        push dword character1
        push dword format
        call [scanf]
        add ESP, 4*2
        cmp EAX, 0
    je end_1
    stosb
    jne repeat_reading1
    
    end_1:
    
    mov EDI, sir2
    mov ECX, len
    repeat_reading2:
        ;scanf(format, character1)
        push dword character1
        push dword format
        call [scanf]
        add ESP, 4*2
        cmp EAX, 0
    je end_2
    stosb
    jne repeat_reading2
    
    end_2:
    
    mov EDI, sir3
    mov ECX, len
    repeat_reading3:
        ;scanf(format, character1)
        push dword character1
        push dword format
        call[scanf]
        add ESP, 4*2
        cmp EAX, 0
    je end_3
    stosb
    jne repeat_reading3
        

    
    end_3:
    push dword 0
    call [exit]