bits 32

global A

segment data use32 public data
    counter dd 0
segment code use32 public code
    A:
    ; AB CD EF GH
    ; ESP - return address
    ; ESP + 4 - address of sir1
    ; ESP + 8 - length of sir1
    ; ESP + 12 - address of sir2
    
    mov ESI, [ESP + 4]
    mov ECX, [ESP + 8]
    mov EDI, [ESP + 12]
    
    for_every_doubleword:
        lodsb
        lodsb
        cmp AL, 0
        jge next_double_word
            stosb
            inc dword[counter]
        
        next_double_word:
        lodsw
        loop for_every_doubleword
    mov EBX, [counter]
    
    ret