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
    format db "The number is: %d. The frequency is: %d", 0
    input_text times 100 db 0
    len equ 100
    counter dd 0
    frecv times 10 db 0
    max_frecv dd 0
    max_nr dd 0
    
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
            ;fread(input_text, 1, len, file_descriptor)
            push dword [file_descriptor]
            push dword len
            push dword 1
            push input_text
            call [fread]
            
            cmp EAX, 0
            je end_of_reading
            
            mov EBX, 0
            mov ESI, input_text
            mov EDI, frecv
            mov ECX, EAX
            for_every_character:
                find_the_frequency:
                    mov EAX, 0
                    lodsb
                    cmp AL, '0'
                    jb not_digit
                    cmp AL, '9'
                    jg not_digit
                    
                    sub AL, '0'
                    inc byte[EDI + EAX] 
                
                not_digit:
                loop for_every_character
        jmp repeat_reading
            
       
    end_of_reading:    
        
    ;fclose
    push dword [file_descriptor]
    call [fclose]
    
    
    mov ESI, frecv
    mov EBX, 0
    mov ECX, 0
    find_maximum_frequency:
        lodsb
        cmp AL, [max_frecv]
        jb not_found_larger
        mov [max_frecv], AL
        mov [max_nr], ECX
        
    not_found_larger:
        inc ECX
        cmp ECX, 10
        jne find_maximum_frequency
    
    push dword [max_frecv]
    push dword[max_nr]
    push dword format
    call [printf]
    add ESP, 4*2
    
    final:
    push dword 0
    call [exit]