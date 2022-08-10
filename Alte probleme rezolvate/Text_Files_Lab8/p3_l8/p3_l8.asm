bits 32

global start

extern exit, printf, scanf, fread, fopen
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll


segment data use32 class=data
    file_descriptor db -1
    file_name db "input.txt", 0
    access_mode db "r", 0
    format db "The number of odd digits is: %d", 0
    input_text times 100 db 0
    len equ 100
    counter dd 0
    
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
            
            mov ESI, input_text
            mov ECX, EAX
            for_every_character:
                lodsb
                cmp AL, 30h
                jge go_further
                jb not_a_digit
                go_further:
                    cmp AL, 39h
                    jbe digit_found
                    jg not_a_digit
                digit_found:
                cbw
                mov BL, 2
                idiv BL
                cmp AH, 0
                je not_odd_digit
                jne odd_digit
                
                odd_digit:
                inc dword[counter]
                
            not_odd_digit:
            not_a_digit:
            loop for_every_character
       jmp repeat_reading
       
    end_of_reading:    
    
    ;printf(format, counter)
    push dword [counter]
    push dword format
    call [printf]
    add ESP, 4*2
    
    final:
    push dword 0
    call [exit]