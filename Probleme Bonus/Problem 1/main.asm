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
    sum dd 0
    
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
            push dword numberToRead ; read the text from file usinf fscanf()
            ;EAX = fscanf(file_descriptor, number_type, number)
            push dword number_type
            push dword [file_descriptor]
            call [fscanf]
            add ESP, 4*4 ; clean-up the stack
            
            mov EDX, EAX
            cwde
            mov EBX, [numberToRead];
            add dword[sum], EBX
            cmp EBX, -128
            jnge label1
                cmp EBX, 127
                jnle label1
                    imul byte[numberToRead]
                    cmp EAX, -1 
                    jne readNumbers
                
                label1:
                    cmp EBX, -32768
                    jnge label2
                        cmp EBX, 32767
                        jnle label2
                            imul word[numberToRead]
                            idiv 
                            cmp EDX, -1 
                            jne readNumbers
                        
                        label2:
                            cmp EBX, -2147483648
                            jnge label3
                                cmp EBX, 2147483647
                                jnle label3
                                    imul dword[numberToRead]
                                    cmp EDX, -1 
                                    jne readNumbers
                                    label3:
                                        cmp EDX, -1 
                                        jne readNumbers
        
        sub dword[sum], EBX
            
        
        final:
        push 0
        call [exit]