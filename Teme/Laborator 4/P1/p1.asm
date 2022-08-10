;Se dau octetii A si B. Sa se obtina dublucuvantul C:
;bitii 16-31 ai lui C sunt 1
;bitii 0-3 ai lui C coincid cu bitii 3-6 ai lui B
;bitii 4-7 ai lui C au valoarea 0
;bitii 8-10 ai lui C au valoarea 110
;bitii 11-15 ai lui C coincid cu bitii 0-4 ai lui A


bits 32

global  start 

extern  exit
import  exit msvcrt.dll

segment  data use32 class=data 

    a db 01010111b
    b db 00111011b
    c dw 0    ;1111 1111 1111 1111 1101 1110 0000 1010

segment  code use32 class=code
start:

    mov EBX, 0
    mov AL, [b] ; we put the value of b in AL
    mov AH, 0 ; we convert it in AX
    mov DX, 0 ; we convert it in DX:AX
    
    push DX
    push AX
    pop EAX ; we put in EAX the value of b
    
    and EAX, 00000000000000000000000001111000b ; EAX = 0000 0000 0000 0000 0000 0000 0101 0000 ; we isolate from b the bits 0-3
    ror EAX, 3 ; EAX = 0000 0000 0000 0000 0000 0000 0000 1010 ; we rotate 2 positions to the right
    
    or EBX, EAX ; EBX = 0000 0000 0000 0000 0000 0000 0000 1010 ; we put the bits in the result
    or EBX, 11111111111111110000011000001010b ; we make the bits from the positions 4-7 to have the value 0, from 8-10 to have the value 110 and from 16-31 to have the value 1
    
    mov AL, [a] ; we put the value of a in AL
    mov AH, 0 ; we convert it in AX
    mov DX, 0 ; we convert it in DX:AX
    
    push DX
    push AX
    pop EAX ; we put in EAX the value of a
    
    and EAX, 00000000000000000000000000011111b ; EAX = 0000 0000 0000 0000 0000 0000 0001 1011 ; we isolate from a the bits 0-4
    rol EAX, 11 ; EAX = 0000 0000 0000 0000 1101 1000 0000 0000 ; We rotate 10 positions to left
    or EBX, EAX ; we put the bits in the result 
    
    mov dword [c], EBX ; c = 1111 1111 1111 1111 1101 1110 0000 1010
    
    push   dword 0
    call   [exit]
    
    
    