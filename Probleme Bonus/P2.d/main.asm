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
            
            ;In [actual_length] we calculate the length of the file, or in other words the number of characters
            add dword[actual_length], EAX
            
            cmp EAX, 0
            je end_read
            
            jmp read
            
        end_read:    
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        
        cleanup:
        push    dword 0
        call    [exit]
        