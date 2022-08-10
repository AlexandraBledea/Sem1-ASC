bits 32

global start

extern exit, printf, scanf, fread, fopen, fclose, fprintf, gets
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import gets msvcrt


segment data use32 class=data
    file_descriptor db -1
    file_name times 30 db 0
    print_format db "Type the file name", 10, 13, 0
    file_format db "%s", 0
    str_format db "%s", 0
    print_message_format db "Type the message: ", 0
    access_mode db "a+", 0
    empty db 0
    message times 120 db 0


    
segment code use32 class=code
    start:
    
        ;printf(print_format)
        push dword print_format
        call [printf]
        add ESP, 4*1
        
        ;gets(file_name)
        push dword file_name
        call [gets]
        add ESP, 4*1
        
        ;fopen(file_name, access_mode)
        push access_mode
        push file_name
        call [fopen]
        add ESP, 4*2
        
        cmp EAX, 0
        je final
        
        mov [file_descriptor], EAX
        
        ;printf(print_message_format)
        push dword print_message_format
        call [printf]
        add ESP, 4*2
        
        ;gets(message)
        push dword message
        call [gets]
        add ESP, 4*1
        
        ;fprintf(file_descriptor, message)
        push dword message
        push dword [file_descriptor]
        call [fprintf]
        add ESP, 4*2
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        
        final:
        push dword 0
        call [exit]