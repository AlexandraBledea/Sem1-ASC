bits 32 

global start        

extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll   
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

;A text file is given. Read the content of the file, count the number of special characters and display the result on the screen. 
;The name of text file is defined in the data segment.

segment data use32 class=data
    output_format db "The number of special characters is: %u", 0
    input_file_name db "input.txt", 0
    acces_mode db "r", 0
    file_descriptor resd 1
    special_character_counter dd 0
    
    max_length equ 100
    actual_length resd 1
    input_text resb max_length
   
segment code use32 class=code
    start:
        
    ;fopen(input_file_name, acces_mode)
        push acces_mode
        push input_file_name
        call [fopen]
        add esp, 4 * 2
        mov dword[file_descriptor], eax
        cmp eax, 0
        je end_program
        
    ;fread(input_text, 1, max_length, file_descriptor)
        push dword[file_descriptor]
        push max_length
        push 1
        push input_text
        call [fread]
        add esp, 4 * 4
        mov dword[actual_length], eax
    
    ;we must count how many special characters we have in the string input_text
    ;special characters have codes 33-47, 58-64, 91-96, 123-126
        mov ecx, dword[actual_length]
        mov esi, input_text
        cld
        for_every_character_in_the_input:
            lodsb
            ;we must check if the byte stored in al is a special character
            cmp al, 33
            jb not_a_special_character
            cmp al, 47
            jbe is_special_character
            cmp al, 58
            jb not_a_special_character
            cmp al, 64
            jbe is_special_character
            cmp al, 91
            jb not_a_special_character
            cmp al, 96
            jbe is_special_character
            cmp al, 123
            jb not_a_special_character
            cmp al, 126
            jbe is_special_character
            jmp not_a_special_character
            
            
            is_special_character:
                inc dword[special_character_counter]
                
            not_a_special_character:
        loop for_every_character_in_the_input
    
    ;printf("The number of special characters is: %u", special_character_counter)
        push dword[special_character_counter]
        push output_format
        call [printf]
        add esp, 4 * 2
    
    ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 * 1
        
    end_program:
    push    dword 0
    call    [exit]
