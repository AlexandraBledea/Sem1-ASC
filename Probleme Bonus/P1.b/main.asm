bits  32
global  start

extern exit, fopen, fclose, fscanf

import  exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll



segment  data use32 public data

    file_name db "input.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    numberToRead dd 0
    number_type db "%d"
    numbers times 100 db 0
    counter dd 0
    
segment  code use32 public code
    start:
        ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        mov dword[file_descriptor], EAX
        
        cmp EAX, 0
        je final
        
        readNumbers:
            ;EAX = fscanf(file_descriptor, number_type, number)
            push dword numberToRead ; read the text from file usinf fscanf()
            push dword number_type
            push dword [file_descriptor]
            call [fscanf]
            add ESP, 4*4 ; clean-up the stack
            
            cmp EAX, -1
            jne readNumbers
            
            add dword[counter], 1
            mov EBX, numberToRead
            mov [numbers], EBX
            
        sub dword[counter], 1
        
        Mov bl,1  ; OK  
        while : 
        Mov bl, 0  
        Mov ecx, dword[counter]
        Mov esi, numbers  
        CLD  
        repeta3 : 
           Lodsb ; 
           Cmp AL, [ESI]  
           JLE here 
              mov DL, [ESI]  
              sub ESI, 1
              mov [ESI], DL 
              add ESI, 1
              mov [ESI], AL 
              mov BL, 1 
        here :  
        Loop repeta3 
        Cmp BL , 1 
        JE while 

        ;fclose(file_descriptor)
        push dword[file_descriptor]
        call [fclose]
        add ESP, 4*1
        
        final:
        
        push    dword 0
        call    [exit]
            
            