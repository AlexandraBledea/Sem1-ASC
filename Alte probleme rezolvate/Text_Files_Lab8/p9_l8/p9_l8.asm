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
    spec_char times (len+1) dw 0
    freq_list times 300 dd 0
    freq_character dd 0
    character_with_max_freq dd 0
    special_characters_list times 300 dd
    freq_length dd 0
    message db "The most used special character is: %c with an appearance of %d.", 0

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
        ;fread(spec_char, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword spec_char
        call [fread]
        add ESP, 4*4
        
        cmp EAX, 0
        je stop_reading
        
        cmp dword[spec_char], 'a'
        ja check_next
        jb go_further
        check_next:
            cmp dword[spec_char], 'z'
            jb not_special_character
            ja special_character
        go_further:
            cmp dword[spec_char], 'Z'
            ja special_character
            jb continue
        continue:
        cmp dword[spec_char], 'A'
        ja not_special_character
        jb special_character
        
        special_character:
            mov ESI, [spec_char]
            inc dword[freq_list + ESI*4]
    not_special_character:
        jmp keep_reading
    
    stop_reading:
    ;fclose(file_descriptor)
    push dword [file_descriptor]
    call [fclose]
    add ESP, 4*1
    
    mov ESI, '!'
    mov ECX, 127

    parse_the_frequency:
        mov EAX, [freq_list + ESI*4]
        cmp EAX, [freq_character]
        ja modify
        
        jmp dont_modify
        
        modify:
            mov [freq_character], EAX
            mov [character_with_max_freq], ESI
            
       dont_modify:
       inc ESI
    loop parse_the_frequency
    
    ;printf(message, letter_with_max_freq, freq_letter)
    push dword [freq_character]
    push dword [character_with_max_freq]
    push dword message
    call [printf]
    add ESP, 4*3
   
        
    final:
    push dword 0
    call [exit]