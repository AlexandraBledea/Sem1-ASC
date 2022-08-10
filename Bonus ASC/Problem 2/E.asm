bits 32

global E

segment  data use32 public code


E:

;ESP - return address
;ESP + 8 - input_text
;ESP + 4 - [actual_length]

    mov ECX, [ESP + 4]
    mov ESI, [ESP + 8]
    mov EBX, 0
    cld
    for_every_character:
        lodsb
        cmp AL, 20h
        jne label1
            add EBX, 1
        label1:
        loop for_every_character
        
    add EBX, 1 ; We increment EBX once more because if we have 4 spaces, it means we have 5 words and so on
    ret