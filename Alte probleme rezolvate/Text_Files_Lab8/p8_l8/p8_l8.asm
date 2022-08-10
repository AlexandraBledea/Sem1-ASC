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
    file_descriptor db -1
    file_name db "input.txt", 0
    access_mode db "r", 0
    len equ 1
    letter times (len+1) db 0
    freq_list times 300 dd 0
    freq_letter dd 0
    letter_with_max_freq dd 0
    message db "The most used uppercase letter is: %c with an appearance of %d.", 0

segment code use32 class=code
    start:
    
    ;fopen(file_name, access_mode)
    push dword access_mode
    push dword file_name
    call [fopen]
    add ESP, 4*2
    
    cmp EAX, 0
    je final
    
    mov [file_descriptor], EAX
    
    keep_reading:
        ;fread(letter, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword letter
        call [fread]
        add ESP, 4*4
        
        cmp EAX, 0
        je stop_reading
        
        mov ESI, [letter]
        inc dword[freq_list + ESI*4]
        
    jmp keep_reading
    
    stop_reading:
    ;fclose(file_descriptor)
    push dword [file_descriptor]
    call [fclose]
    add ESP, 4*1
    
    mov ESI, 'A'
    mov ECX, 26
    
    parse_the_frequency:
        mov EAX, [freq_list + ESI*4]
        cmp EAX, [freq_letter]
        ja modify
        
        jmp dont_modify
        
        modify:
            mov [freq_letter], EAX
            mov [letter_with_max_freq], ESI
            
       dont_modify:
       inc ESI
   
    loop parse_the_frequency
    
    ;printf(message, letter_with_max_freq, freq_letter)
    push dword [freq_letter]
    push dword [letter_with_max_freq]
    push dword message
    call [printf]
    add ESP, 4*3
   
        
    final:
    push dword 0
    call [exit]