bits 32

global D

segment  data use32 public code

D:

; ESP - return address
; ESP + 4 - actual_length

    mov EBX, 0
    add EBX, [ESP + 4]
    
    ret