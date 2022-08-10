bits 32

global start

extern exit, printf, scanf
extern changeChar

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data

    ;s1 db 'ana,are,mere,eu,nu,mai,am'
    ;s1 db 'ppp,ppp,mppp,pp,pp,ppp,pp'
    s1 db 'pqp,pp'
    ;s2 db '---,&--,&---,--,&-,&&&,--'
    ;s2 db '---,---,&---,--,--,---,--'
    s2 db '---,--'
    len equ $-s2
    s3 times len db 0
    index dd 0
    frecv times 25 db 0
    max db 0
    format db "%u", 0

segment code use32 class=code
    start:
    mov ESI, s1
    mov EBX, 0
    mov EDI, s3
    mov ECX, len
    
    parse_s1:
        mov EAX, 0
        lodsb
        cmp AL, ','
        je continue
        
        mov EDX, 0
        mov DL, [s2 + EBX]
        mov dword[index], EBX
        inc EBX
        
        push EAX
        push EDX
        push dword [index]
        call changeChar
        add ESP, 4*3
        
        stosb ; In AL we will have the changed character
        jmp next
        
        continue:
            stosb
            inc EBX
        
        next:
        
    loop parse_s1
    
    mov ESI, s3
    mov ECX, len
    parse_s3:
        mov EAX, 0
        lodsb
        cmp AL, ','
        je next2
        
        sub AL, 'a'
        add byte[frecv + EAX], 1
        
        next2:
    loop parse_s3
        
    mov ESI, frecv
    mov ECX, 25
    parse_frecv:
        lodsb
        cmp byte[max], AL
        jbe change_max
        ja next3
        
        change_max:
            mov byte[max], AL
        
        next3:
    loop parse_frecv
    
    mov EAX, 0
    mov AL, [max]
    
    push EAX
    push dword format
    call [printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]