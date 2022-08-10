bits 32

global start

extern exit, printf, scanf, fread, fclose, fopen

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
;Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. Sa se afiseze
;in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
;a = 32 = 0010 0000b
;b = 1Ah = 0001 1010b
;32 + 1Ah = 0011 1010b
;Se va afisa pe ecran valoarea 4.

segment data use32 class=data
    format1 db "%d", 0
    format2 db "%x", 0
    number1 dd 0
    number2 dd 0
    sum_of_numbers dd 0
    sum dd 0
    
segment code use32 class=code
    start:
    
    ;scanf(format1, number)
    push dword number1
    push dword format1
    call [scanf]
    
    ;scanf(format2, number2)
    push dword number2
    push dword format2
    call [scanf]
    
    mov EAX, 0
    mov EAX, [number1]
    add EAX, [number2]
    mov dword[sum_of_numbers], EAX
    
    mov ECX, 32
    mov EDX, 0
    for_every_bit:
        shl EAX, 1
        jnc go_further
        inc EDX
        go_further:
        loop for_every_bit
    
    mov dword [sum], EDX
    
    push dword [sum]
    push dword format1
    call[printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]