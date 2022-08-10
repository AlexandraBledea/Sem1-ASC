bits 32

global C

segment  data use32 public code


C:

;ESP - return address
;ESP + 4 - actual_length
;ESP + 8 - input_text
;ESP + 12 - final

    mov ECX, [ESP + 4]
    mov ESI, [ESP + 8]
    mov EDI, [ESP + 12]
    mov EBX, 0
    cld
    again:
        lodsb
        cmp AL, 59h ; We check if AL is equal with y, because we take this case separatly, y should be a
        je label1
        cmp AL, 5Ah ; We check if AL is equal with z, because we take this case separatly, z should be b
        je label2
        cmp AL, 79h ; We check if AL is equal with Y, because we take this case separatly, Y should be A
        je label3
        cmp AL, 7Ah ; We check if AL is equal with Z, because we take this case separatly, Z should be B
        je label4
        cmp AL, 41h
        jb not_a_letter ; If it is smaller then 41h it means it is not a letter
        cmp AL, 58h
        jbe is_a_letter ; If it is below or equal to 58h it means it is a letter
        cmp AL, 61h
        jb not_a_letter ; If it is below 61h it means it is not a letter
        cmp AL, 78h
        jbe is_a_letter ; If it is below or equal to 78h it means it is a letter
        jmp not_a_letter ; If none of the conditions are checked it means it is not a letter either
        
        label1:
            mov AL, 41h
            sub ECX, 1
            stosb
            cmp ECX, 0
            jne again
            jmp final
        
        label2:
            mov AL, 42h
            sub ECX, 1
            stosb
            cmp ECX, 0
            jne again
            jmp final
            
        label3:
            mov AL, 61h
            sub ECX, 1
            stosb
            cmp ECX, 0
            jne again
            jmp final
        
        label4:
            mov AL, 62h
            sub ECX, 1
            stosb
            cmp ECX, 0
            jne again
            jmp final
        
        is_a_letter:
            add AL, 2h
            sub ECX, 1
            stosb
            cmp ECX, 0
            jne again
            jmp final
        
        not_a_letter:
            stosb
            sub ECX, 1
            cmp ECX, 0
            jne again
            jmp final
    
    final:
        ret
        
       