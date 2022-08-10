bits 32

; indicate to the assembler that the function _sumNumbers should be available to other compile units
global _Expression

; the linker may use the public data segment for external datta
segment data public data use32

; the code written in assembly language resides in a public segment, that may be shared with external code
segment code public code use32

_Expression:
    ; create a stack frame
    push EBP
    mov EBP, ESP
    
    ; retreive the function's arguments from the stack
    ; [ebp + 16 ] contains the value of c
    ; [ebp + 12] contains the value of b
    ; [ebp + 8 ] contains the value of a
    ; [ebp + 4] contains the return value 
    ; [ebp] contains the ebp value for the caller
    mov EAX, [EBP + 8]        ; eax <- a
    
    mov EBX, [EBP + 12]        ; ebx <- b
    mov ECX, [EBP + 16]
    
    add EAX, EBX            ; compute a + b
    sub EAX, ECX            ; compute a + b - c
                            ; the return value of the function should be in EAX

    ; restore the stack frame
    mov ESP, EBP
    pop EBP

    ret
    ; cdecl call convention - the caller will remove the parameters from the stack
