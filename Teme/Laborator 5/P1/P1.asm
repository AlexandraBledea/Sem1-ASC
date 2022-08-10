bits 32
global  start 


extern  exit
import  exit msvcrt.dll

;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate literele mici din sirul S.
;Exemplu:
;S: 'a', 'A', 'b', 'B', '2', '%', 'x'
;D: 'a', 'b', 'x'


segment  data use32 class=data 
    s db 'a', 'A', 'b', 'B', '2', '%', 'x', 'd', 'C'
    l equ $-s ; the length of the initial string is determined like that
    d times l db 0 ; reserving a space of size l for the destination string d and initialize it

segment  code use32 class=code
start:

    mov ECX, l
    mov ESI, 0
    mov EDI, 0
    mov BL, 'a'
    mov DL, 'z'
    jecxz Outoftheloop
    my_loop:
        mov AL, [s+ESI] ; We put in AL the current element from s starting from left to right
        inc ESI ; After that we increment the value of ESI, preparing it to be used for the next element from s
        cmp AL,BL 
        jnae out_of_first_if ; We check if the current element from s is greater then 'a'
        next_if:
            cmp AL, DL
            jnbe out_ot_the_second_if ; We check if the current element from is smaller then 'z'
            next_if2:
                mov [d+EDI], AL ; If both conditions are checked it means the curent element from s is a lower case character
                inc EDI ; We increment the value of EDI, preparing it to be used for the next lower case character if it exists in the string s
        out_ot_the_second_if:       
        out_of_first_if: 
    loop my_loop
    Outoftheloop:


    push   dword 0
    call   [exit]