bits 32

global start

extern exit, printf, scanf, fread, fclose, fopen

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll

;Two strings of words are given. Concatenate the string of low bytes of the words 
;from the first string to the string of high bytes of the words from the second string.
;The resulted string of bytes should be sorted in ascending order in the signed interpretation.  

segment data use32 class=data
    first_string dw 2345h, 0A5h, 368h, 3990h 
    len1 equ ($-first_string)/2
    second_string dw 4h, 2655h, 10  
    len2 equ ($-second_string)/2
    len_tot equ (len1 + len2)
    destination times len_tot db 0
    format db "%x ", 0
    number dd 0
    
segment code use32 class=code
    start:
    
    mov ECX, len1
    mov ESI, first_string
    mov EDI, destination
    cld
    for_every_number_in_first_string:
        lodsb ; <- we load in AL the low byte from the word
        stosb ; <- we store in EDI the low byte from the word
        lodsb
    loop for_every_number_in_first_string
    
    mov ECX, len2
    mov ESI, second_string
    cld
    for_every_number_in_second_string:
        lodsb
        lodsb
        stosb
    loop for_every_number_in_second_string
    
    ;Sortare:
    
    while_:
    mov BL, 0
    mov ECX, len_tot - 1
    mov ESI, destination
    cld
    keep_sorting:
        lodsb
        cmp AL, [ESI]
        jle next_number
        mov DL, [ESI]
        mov [ESI - 1], DL
        mov [ESI], AL
        mov BL, 1
        
        next_number:
        loop keep_sorting
        cmp BL, 1
        je while_
        
    mov ECX, len_tot
    mov ESI, destination
    cld
    mov EAX, 0
    for_every_number:
        lodsb
        mov dword[number], EAX
        pushad
        push dword [number]
        push dword format
        call [printf]
        add ESP, 4*2
        popad
        loop for_every_number
        
    push dword 0
    call [exit]