bits 32

global start

;A string of doublewords is given ( defined in module a.asm). Build the string of byte ranks
;that have the maximum value from each doubleword (considering them unsigned) by calling a 
;procedure from module b.asm. This procedure should also compute the sum of these bytes.
;Next, in the main module (a.asm) print this string of bytes on the screen (unsigned) and also print
;the sum of these bytes(signed).

;Example: If the string of doublewords is:
;sir dd 1234A678h, 12345678h, 1AC3B47Dh, FEDC9876h
;the bytes of max value are respectively A6h, 78h, C3h, FEh,
;the corresponding string of bytes ranks being "3421",
;and the sum of these bytes being -33.

extern B
extern exit, printf

import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data

    given_string dd 1234A678h, 12345678h, 1AC3B47Dh, 0FEDC9876h
    len equ ($-given_string)/4
    destination_string times len db 0
    destination dd 0
    sum_of_bytes dd 0
    format db "%x ", 0
    format2 db "%d", 0
    format3 db " ", 10, 13, 0
    copy dd 0
    result dd 5
    counter dd 0
    

segment code use32 class=code
start:

    push dword len
    push dword destination_string
    push dword given_string
    call B
    add ESP, 4*3
    
    mov [sum_of_bytes], EAX
    
    mov ESI, given_string ; We put in ESI the address of the initial string
    mov ECX, 0
    for_every_byte:
        mov AL, [destination_string + ECX] ; We put in AL the first rank of the given byte, the rank representing the position in the doubleword of the number
        push ECX ; We save the value of ECX, because we will need it later
        mov BL, [result] 
        sub BL, AL
        mov [copy], BL
        mov ECX, [copy] ; Here we compute how many times should we use lodsb to reach the byte corresponding to the position from the rank list, and because the
        for_:           ; Lodsb works in from right to left, and the rank was computed from left to right we have to subtract the value of the rank from 5 ( because we know
                        ; a doubleword is equivalent with 4 bytes) to obtain the number of times the lodsb instruction should be use, for example the first rank is 3
            lodsb       ; which means we need to use the lodsb instruction twice
            inc dword[counter]
            loop for_
        mov [destination], AL ; We move into the destination the obtained byte
        cmp dword[counter], 4 ; Then we compare the counter with 4, to check if we still need to move to the next doubleword
        jne label1 ; If the counter is not equal to 4, it means we need to pass to the next double word
        je label2
        label1:
        mov ECX, 4
        sub ECX, dword[counter] ; We compute how many times we need to use the lodsb intruction to go to the next doubleword
        rep lodsb
        label2:
        push dword [destination]
        push dword format
        call [printf]
        add ESP, 4*2
        mov dword[result], 5 ; We reinitialize the result with 5 and the counter with 0 for the next computations
        mov dword[counter], 0
        pop ECX
        inc ECX
        cmp ECX, len
        jne for_every_byte
    
    push dword format3
    call [printf]
    add ESP, 4*1
    
    mov AL, byte[sum_of_bytes]
    cbw
    cwde
    
    push dword EAX
    push dword format2
    call [printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]