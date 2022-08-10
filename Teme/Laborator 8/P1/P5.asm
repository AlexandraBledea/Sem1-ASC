bits 32
global start        
;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. Calculate a/b and display the quotient and the remainder in the following format: "Quotient = <quotient>, remainder = <remainder>". Example: for a = 23, b = 10 it will display: "Quotient = 2, remainder = 3".
;The values will be displayed in decimal format (base 10) with sign.


; declare extern functions used by the program
extern exit, printf         ; add printf as extern function            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf can be found in library msvcrt.dll


segment data use32 class=data
; char arrays are of type byte
    a dd 47
    b dd 10
    format1 db "Quotient = %d",10, 13, 0  ; %d will be replaced with a number
    format2 db "Remainder = %d",10, 13, 0 ; %d will be replaced with a number
            ; char strings for C functions must terminate with 0
segment  code use32 class=code
    start:
        
        mov EAX, dword[a+0]
        cdq
        ;We put in EDX:EAX the value of a so we could do the division a/b
        mov EBX, [b]
        idiv EBX
        ; EAX = a/b --> the quotient
        ; EDX = a%b --> the reminder
        
        pushad ;We push on stack the values of the registers in case they are modified within the function
        ;printf("Quotient = %d, EAX)
        push dword EAX
        push dword format1
        call [printf]     
        add ESP, 4*2
        popad ;We pop the values of the registers so we could use them with their saved value
        
        ;printf("Reminder = %d, EDX)
        push dword EDX
        push dword format2
        call [printf]
        add ESP, 4*2

        push dword 0      ; push on stack the parameter for exit
        call [exit]       ; call exit to terminate the programme
