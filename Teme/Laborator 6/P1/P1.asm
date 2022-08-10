bits 32
global  start 


extern  exit
import  exit msvcrt.dll

segment  data use32 class=data 

    s1 db 7, 33, 55, 19, 46
    L1 equ $-s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    L2 equ $-s2
    d times L2 db 0

segment  code use32 class=code
start:
    
    mov ECX, L2
    jecxz end_loop
    for_every_element_in_s2:
        ; the position for the current element is s2 + L2 - ECX
        mov EDX, L2
        sub EDX, ECX ; EDX = L2 - ECX
        
        push ECX ; we save the current counter for the first loop
        
        mov ECX, L1 ; we put in ECX the length of the first series
            jecxz end_of_second_loop
            for_every_element_in_s1:
                ;the position for the current element is s1 + L1 - ECX
                mov EBX, L1
                sub EBX, ECX ; EBX = L1 - ECX
                
                mov AL, [s1 + EBX]
                cmp AL, [s2 + EDX] ; We check if the current element from s1 is equal with the current element from s2
                JNE next_element
                    inc BL
                    mov [d + EDX], BL 
                    ;Because the value of L1 - ECX fits in one byte, it will be found in BL
                    
                next_element:
            loop for_every_element_in_s1
            
            end_of_second_loop:
         
        pop ECX

    loop for_every_element_in_s2
    end_loop:
    push   dword 0
    call   [exit]