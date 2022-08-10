bits 32

extern exit, printf
extern A

;A string of quadwords is defined in the data segment. The degree of an element is defined
;as being the number of "111" distinct sequences from its binary representation( ex: 111 111b has the degree 2).
;It is required to build as a result a string which will contain the inferior doublwords that have the degree at least
;2 from each qword. Print on the screen in base 2 the elements of the resulted string.

;Example: if the given string is:
;sir dq 1110111b, 100000000h, 0ABCD0002E7FCh, 5
;The resulted string is rez dd 1110111b, 0002E7FCh
;On the screen will be printed 1110111 101110011111111100

import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

    given_string dq 1110111b, 100000000h, 0ABCD0002E7FCh, 5
    len equ ($-given_string)/8
    destination_string time len dd 0

segment code use32 class=code
    start:
    
    push dword len
    push dword destination_string
    push dword given_string
    call A
    add ESP, 4*3
    
    push dword 0
    call [exit]