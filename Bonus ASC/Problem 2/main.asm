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

extern A ; subpoint a)
extern C ; subpoint c)
extern D ; subpoint d)
extern E ; subpoint e)

;Se citeste un text din fisier si un character de la tastatura.
; a)	Calculati numarul de aparitii al caracterului citit in textul dat si inlocuiti-l cu X, scriind reszultatul in alt fisier output.txt
; c)	Codificati textul folosind corespondenta ABCDâŚ WXYZ -> CDEFâŚ  YZAB si afisati condificarea intr-un nou fisier.
; d)    Calculati lungimea fisierului.
; e)      Calculati numarul de cuvinte din fisier.

segment data use32 class=data
    counter dd 0
    counter_words dd 0
    file_name db "input.txt", 0
    file_name2 db "result.txt", 0
    file_name3 db "final.txt", 0
    access_mode2 db "a+", 0
    access_mode db "r", 0    
    access_mode3 db "a+", 0
    format_read db "%c", 0
    file_descriptor dd -1
    file_descriptor2 dd -1
    file_descriptor3 dd -1
    len equ 100
    len2 equ 100000
    len3 equ 100000
    actual_length resd 1
    result times len2 db 0
    input_text times len db 0
    final times len3 db 0
    character db 0
    format_print db "The character %c appeared %u times", 10, 13, 0
    format_print2 db "The length of the file is %u", 10, 13, 0
    format_print3 db "The number of words is %u", 0
    total_length resd 1
    
segment code use32 class=code    
    start:
        ;scanf(format_read, character)
        push dword character
        push dword format_read
        call [scanf]
        add ESP, 4*2
    
        ;fopen(file_descriptor3, access_mode3)
        push dword access_mode3
        push dword file_name3
        call[fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je cleanup
        
        mov [file_descriptor3], EAX
    
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
            
            push dword[actual_length]
            push dword input_text
            push dword result
            push dword[character]
            call A
            add ESP, 4*4
            
            add dword[counter], EBX
            
            push dword final
            push dword input_text
            push dword [actual_length]
            call C
            add ESP, 4*3
            
            push dword[actual_length]
            call D
            add ESP, 4*1
            
            add dword[total_length], EBX
            
            push dword input_text
            push dword[actual_length]
            call E
            add ESP, 4*2
            
            add dword[counter_words], EBX
            
            
        jmp repeat
        
        end_of_read:
        
        ;append the new text to another file
        ;fprintf(file_descriptor2, result)
        push dword result
        push dword [file_descriptor2]
        call [fprintf]
        add ESP, 4*2
        
        ;append the new text to another file
        ;fprintf(file_descriptor3, final)
        push dword final
        push dword[file_descriptor3]
        call [fprintf]
        add ESP, 4*2
        
        ;printf(format_print, character, counter)
        push dword[counter]
        push dword[character]
        push dword format_print
        call [printf]
        add ESP, 4*3
        
        ;printf(format_print2, total_length)
        push dword[total_length]
        push dword format_print2
        call [printf]
        add ESP, 4*2
        
        ;printf(format_print3, counter_words)
        push dword[counter_words]
        push dword format_print3
        call [printf]
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
        