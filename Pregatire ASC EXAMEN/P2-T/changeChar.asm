bits 32

global changeChar

segment data use32 class=data
    c dd 0
    op dd 0
    n dd 0

segment code use32 class=code

changeChar:

; ESP - return address
; ESP + 4 - index
; ESP + 8 - operation
; ESP + 12 - character

        mov EAX, [ESP + 4] ; index
        mov [n], EAX
        mov EAX, [ESP + 8] ; op
        mov [op], EAX
        mov EAX, [ESP + 12] ; c
        mov [c], EAX
        
        cmp dword[op], '-'
        je operation_minus
        
        cmp dword[op], '-'
        je operation_and
        
        jmp final
        
        operation_minus:
            mov EAX, [n]
            sub dword[c], EAX
            mov EAX, [c]
            jmp final
            
        operation_and:
            mov EAX, [c]
            mov EBX, [n]
            and EAX, EBX
            add EAX, 'a'
            
        
        
        final:
        
        ret