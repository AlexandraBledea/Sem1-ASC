bits 32

global A

segment data use32 class=data

0 000 000 000 000 111
0 000 000 000 001 110
0 000 000 000 011 100
0 000 000 000 111 000
0 000 000 001 110 000
0 000 000 011 100 000
0 000 000 111 000 000
0 000 001 110 000 000
0 000 011 100 000 000
0 000 111 000 000 000
0 001 110 000 000 000
0 011 100 000 000 000
0 111 000 000 000 000
1 110 000 000 000 000  
segment code use32 class=code

A:

; ESP - return address
; ESP + 4 - given_string
; ESP + 8 - destination_string
; ESP + 12 - length

    