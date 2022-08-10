bits 32

global start

extern exit, printf, scanf, fread, fopen, fclose
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll


segment data use32 class=data
    file_descriptor db -1
    file_name db "input.txt", 0
    access_mode db "r", 0
    len equ 1
    letter times (len+1) db 0
    frecv_letter dd 0 
    letter_with_max_frecv dd 0
    frecv_list times 300 dd 0
    message db "The most used lowercase letter is : %c with an appearance of %d.", 0
    
segment code use32 class=code
    start:
        ;fopen(file_name, access_mode)
        push access_mode
        push file_name
        call [fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je final
        mov [file_descriptor], EAX
        
        repeat_reading:
            ;fread(letter, 1, len, file_descriptor)
            push dword [file_descriptor]
            push dword len
            push dword 1
            push letter
            call [fread]
            add ESP, 4*4
            
            cmp EAX, 0
            je end_of_reading
           
            mov ESI, [letter]
            
            inc dword [frecv_list + 4*ESI]
            jmp repeat_reading
        end_of_reading:
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        
        mov ECX, 26
        mov ESI, 'a'
       
        parse_the_frequency:
            mov EAX, [frecv_list + ESI*4]
            cmp EAX, [frecv_letter]
            ja modify
            
            jmp dont_modify
            
            modify:
            mov [letter_with_max_frecv], ESI
            mov [frecv_letter], EAX
            
            dont_modify:
            inc ESI
            
        loop parse_the_frequency
        
    ;printf(message, letter_with_max_frecv, frecv_letter)
    push dword [frecv_letter]
    push dword [letter_with_max_frecv]
    push dword message
    call [printf]
    add ESP, 4*3
    
    final:
    push dword 0
    call [exit]