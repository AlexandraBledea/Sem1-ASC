bits 32 ; assembling for the 32 bits architecture

global start

extern exit, fopen, fread, fclose, scanf, fprintf, printf            
import exit msvcrt.dll    
                          
import fread msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll

;Se citeste un text din fisier si un character de la tastatura.
;a)	Calculati numarul de aparitii al caracterului citit in textul dat si inlocuiti-l cu X, scriind reszultatul in alt fisier output.txt

segment  data use32 public data

    counter resd 1
    file_name db "input.txt", 0
    file_name2 db "result.txt", 0
    access_mode2 db "a+", 0
    access_mode db "r", 0    
    format_read db "%c", 0
    file_descriptor dd -1
    file_descriptor2 dd -1
    len equ 100
    len2 equ 100000
    actual_length resd 1
    result times len2 db 0
    input_text times len db 0
    character db 0
    
segment  code use32 public code   
    start:
        ;scanf(format_read, character)
        push dword character
        push dword format_read
        call [scanf]
        add ESP, 4*2
    
        ;fopen(file_name2, access_mode2)
        push dword access_mode2
        push dword file_name2
        call [fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je cleanup
        
        mov [file_descriptor2], EAX
        
        ;fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je cleanup
        
        mov [file_descriptor], EAX
        
        repeat:
            ;fread(input_text, 1, len, file_descriptor)
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword input_text
            call [fread]
            add ESP, 4*4
            
            cmp EAX, 0
            je end_of_read
            mov dword[actual_length], EAX

            mov ECX, dword[actual_length]
            mov ESI, input_text
            mov EDI, result
            cld
            
            for_every_read_character:
                lodsb
                ;we check if the character read is found in the text
                cmp AL, [character]
                jne label1
                    add dword[counter], 1
                    mov AL, 'X'
                
                label1:
                stosb
                loop for_every_read_character  
            
        jmp repeat
        
        end_of_read:
        
        ;append the new text to another file
        ;fprintf(file_descriptor2, result)
        push dword result
        push dword [file_descriptor2]
        call [fprintf]
        add ESP, 4*2
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        ;fclose(file_descriptor2)
        push dword [file_descriptor2]
        call [fclose]
        add ESP, 4*1
        
        cleanup:
        push    dword 0
        call    [exit]
        