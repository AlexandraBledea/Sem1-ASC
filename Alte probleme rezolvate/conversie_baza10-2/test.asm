bits 32

global start
extern printf, exit
import printf msvcrt.dll
import exit msvcrt.dll


segment data use32  class=data
    
    sir db 10h
    counter dd 0
    copy_of_digit dd 0
    integer_form dd 0
    copy_of_counter dd 0
    format db "%u", 0
    
segment code use32 public code

start:
    mov EAX, 0
    mov EBX, sir
    mov AL, 0
    xlat
    mov ECX, 3 ; the number of characters
    mov [counter], ECX
    
    mov ESI, sir
    ;add ESI, ECX
    ;sub ESI, 1
    cmp ECX, 1
    cld
    mov EAX, 0
    je go_further
    jne for_every_character
    go_further:
        lodsb
        sub AL, '0'
        add [integer_form], AL
        jmp end_
    
    for_every_character:
            push EAX
            lodsb
            sub AL, '0'
            mov [copy_of_digit], AL
            pop EAX
            add EAX, [copy_of_digit]
            mov EBX, 10
            mul EBX
            ;add dword[integer_form], EAX
            loop for_every_character
    
    end_:   
    ;mov EAX, 0
    ;mov EAX, [integer_form]
    mov EBX, 10
    div EBX
    
    push dword EAX
    push dword format
    call [printf]
    
    
    push dword 0
    call [exit]