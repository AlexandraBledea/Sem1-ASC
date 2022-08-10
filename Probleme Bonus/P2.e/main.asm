bits 32 ; assembling for the 32 bits architecture

global start

extern exit, fopen, fread, fclose, scanf, fprintf, fscanf            
import exit msvcrt.dll    
                          
import fread msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fscanf msvcrt.dll

;Se citeste un text din fisier si un character de la tastatura.
;e)      Calculati numarul de cuvinte din fisier.

segment data use32 class=data
    
    counter dd 0
    actual_length dd 0
    file_name db "input.txt", 0
    access_mode db "r", 0    
    file_descriptor dd -1
    len equ 100
    text times len db 0
    
segment code use32 class=code    
    start:

        ;fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je cleanup
        
        mov [file_descriptor], EAX
        
        ;We read the text from the file, until the number of read characters is 0
        read:
            ; EAX = fscanf(text, 1, len, file_descriptor)
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword text
            call [fread]
            add ESP, 4*4
            
            cmp EAX, 0
            je end_read
            
            mov EBX, EAX
            mov dword[actual_length], EAX

            ;We put in EAX the number of characters read 
            ; In ESI we place the address of the text we read
            mov ECX, dword[actual_length]
            mov ESI, text
            cld
            ;We go through every character until we find a whitespace, when we find a white space it means we have a word, so we increase the counter by 1
            for_every_character:
                lodsb
                cmp AL, 020h
                jne label1
                    add dword[counter], 1
            label1:
            loop for_every_character
            jmp read
            
        end_read:    
        ;We increase the counter by one again because if we read 5 words, we will have only 4 spaces.
        add dword[counter], 1
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        
        cleanup:
        push    dword 0
        call    [exit]
        