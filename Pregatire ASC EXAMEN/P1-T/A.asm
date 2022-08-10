bits 32

global A
extern printf
import printf msvcrt.dll


segment data use32  class=data
    
    counter dd 0
    copy_of_digit dd 0
    integer_form dd 0
    copy_of_counter dd 0
    format db "%d", 0
segment code use32 public code

A:

; ESP - return address
; ESP + 4 - [counter]
; ESP + 8 - ip_string
    mov dword[integer_form], 0
    mov ECX, [ESP + 4] ; the number of characters
    mov [counter], ECX
    
    mov ESI, [ESP + 8]
    add ESI, ECX
    sub ESI, 1
    cmp ECX, 1
    std
    je go_further
    jne for_every_character
    go_further:
        lodsb
        sub AL, '0'
        add [integer_form], AL
        jmp end_
    
    for_every_character:
            lodsb
            sub AL, '0'
            mov [copy_of_digit], AL
            mov EAX, [copy_of_digit]
            mov EBX, 10
            mul EBX
            add dword[integer_form], EAX
            loop for_every_character
    
    end_:        
    mov EAX, [integer_form]
    ret
            
            