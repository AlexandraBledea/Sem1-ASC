bits 32

global start

extern exit, printf, scanf
extern A
;extern B

import scanf msvcrt.dll
import exit msvcrt.dll
import printf msvcrt.dll
;"0.0.10.1,256.11.11.11,192.168.10.2,11.2000.1.0"
segment data use32 class=data
    
    format db "%u", 0
    len_string equ 1001
    string times len_string db 0
    format_read db "%s", 0
    len_characters dd 0
    ip_string times len_string db 0
    counter dd 0
    complete_ip times len_string db 0
    copy_of_character db 0
    char_format db "%c", 0
    integer dd 0
    
segment code use32 class=code
    start:
    
    ; We read the string
    push dword string
    push dword format_read
    call [scanf]
    add ESP, 4*2
    
    mov dword[len_characters], EAX
    
    mov ECX, dword[len_characters]
    mov ESI, string
    mov EDI, ip_string
    cld
    mov EBX, 0
    for_every_character:
        mov EDI, ip_string
        go_further:
        lodsb
        cmp AL, '.'
        je procedure_a
        cmp AL, ','
        je procedure_a
        cmp AL, 0
        je procedure_a
        stosb
        inc dword[counter]
        jmp go_further

        procedure_a:
            push ECX
            push EBX
            push ESI
            push EDI
            
            mov [copy_of_character], AL
            push dword ip_string
            push dword [counter]
            call A
            add ESP, 4*2
        
        cld
        mov [integer], EAX
        push dword [integer]
        push dword format
        call [printf]
        add ESP, 4*2
        
        mov EBX, 0
        mov ECX, dword[counter]
        reinitialize_ip_string:
            mov byte[ip_string + EBX], 0
            inc EBX
            loop reinitialize_ip_string
        
        pop EDI
        pop ESI
        pop EBX
        pop ECX
        
        mov [complete_ip + EBX*4], EAX
        inc EBX
        mov dword[counter], 0
        cmp byte[copy_of_character], ','
        jne for_every_character
        
            ;push dword complete_ip
            ;call B
            ; In eax i will have the value 1 if the ip have the right format and 0 if not
        
        cmp EAX, 1
        je print_ip
        mov EBX, 0
        jne for_every_character
        
        mov EBX, 0
        push ECX
        mov ECX, 0
        print_ip:
            push dword [complete_ip+ECX*4]
            push dword format
            call[printf]
            inc ECX
            cmp ECX, 4
            je for_every_character
            
    push dword 0
    call [exit]