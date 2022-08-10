bits 32
global start

extern exit, printf, scanf
extern A

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

    sir1 DD 1245AB36h, 23456789h, 1212F1EEh
    len equ ($-sir1)/4
    sir2 times len db 0
    sir3 times len db 0
    len2 dd 0
    format db "%u", 0
    copy_len2 dd 0
    check_length dd 0
    string_base_2 times 100 db 0
    char_space db "%c", 0
segment code use32 class=code
    start:
    
    push dword sir2
    push dword len
    push dword sir1
    call A
    add ESP, 4*4
    
    mov [len2], EBX

    mov ECX, [check_length]
    for_every_byte:
        mov EDX, 0
        mov EAX, [sir2 + ECX]
        mov EBX, 2
        mov EDI, 0
        form_base_2:
            div EBX ; EAX = EDX:EAX/EBX , EDX = EDX:EAX%EBX
            mov [string_base_2 + EDI], EDX
            inc EDI
            mov EDX, 0
            cmp EAX, 0
            jne form_base_2
        dec EDI
        print_in_base_2:
            mov EAX, 0
            mov AL, [string_base_2 + EDI]
            push dword EAX
            push dword format
            call [printf]
            add ESP, 4*2
            dec EDI
            cmp EDI, 0
            jne print_in_base_2
            
            push dword " "
            push dword char_space
            call [printf]
            add ESP, 4*2
        
        inc ECX
        cmp ECX, [len2]
    jne for_every_byte
    
    push dword 0
    call [exit]
