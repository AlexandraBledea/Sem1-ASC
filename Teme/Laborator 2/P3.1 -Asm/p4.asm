bits 32

global  start 

extern  exit
import  exit msvcrt.dll

;calculate the expression: [d-2*(a-b)+b*c]/2

;for a=100,b=50,c=10,d=400 the result should be 400

segment  data use32 class=data 
    a db 100
    b db 50
    c db 10
    d dw 400


segment  code use32 class=code
start:
    mov AH, [a] ; AH = a --> AH = 100
    
    sub AH, [b] ; AH = AH - b --> AH = 100 - 50 --> AH = 50
    mov AL, AH ; AL = AH --> AL = 50
    mov AH, 2 ; AH = 2
    mul AH ; AX = AL * AH --> AX = 50 * 2 --> AX = 100
    mov CX, AX ; CX = 2*(a-b) --> CX = AX --> CX = 100
    
    mov BL, [b] ; BL = 50
    mov AL, [c] ; AL = 10
    mul BL ; AX = AL * BL --> AX = 10 * 50 --> AX = 500
    mov DX, AX ; DX = b*c --> DX = AX --> DX = 500
    mov AX, CX ; AX =  2*(a-b) --> AX = CX --> AX = 100
    
    neg AX ; AX = -AX --> AX = -100
    
    add AX,DX ; AX = AX + DX --> AX = (-100) + 500 --> AX = 400 --> AX = -2*(a-b)+b*c
    
    mov BX, [d]
    add AX, BX
    mov AH, 2
    div AH ; --> AL = 400 ( the quotient) --> AH = 0 (the reminder)
    ;push DX ; we put on the stack the high part from DX:AX which is a double word
    ;push AX ; we put on the stack the low part from DX:AX which is a double word
    ;pop EDX ; EDX = DX : AX = ( 2 * (a - b) + b * c ) = 400
    
    ;mov EAX, [d] ; EAX = 400
    
    ;add EAX, EDX ; EAX = EAX + EDX --> EAX = 400 + 400 --> EAX = 800
   ; mov EBX, 1 ; EBX = 1
    ;mul EBX ; EDX:EAX = EAX * EBX --> EDX:EAX = 800 * 1 --> EDX:EAX = 800
    ;mov EBX, 2 ; EBX = 2
    ;div EBX ; EAX = EDX:EAX / EBX --> EAX = 800 / 2 --> EAX = 400

      
    ; EAX ← EDX:EAX / EBX
    ; EDX:EAX ← EAX * EBX
    
      
    push   dword 0
    call   [exit]