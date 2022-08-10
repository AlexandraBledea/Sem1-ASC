bits 32

global A

segment  data use32 public code


A:

; ESP - return address
; ESP + 4 - [character]
; ESP + 8 - result
; ESP + 12 - input_text
; ESP + 16 - actual_length

    mov ECX, [ESP + 16]
    mov ESI, [ESP + 12]
    mov EDI, [ESP + 8]
    mov EBX, 0
    cld
    for_every_character:
        lodsb
        ;we check if the character read from keyboard is found in the text
        cmp AL, [ESP + 4]
        jne label1
            add EBX, 1 ; In EBX we compute how many time the character appeared, so in EBX will be the return value
            mov AL, 'X'
        label1:
        stosb
        loop for_every_character
    
    ret