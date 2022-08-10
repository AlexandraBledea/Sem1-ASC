;  programul calculeaza factorialul unui numar si afiseaza in consola rezultatul
;  procedura factorial este definita in fisierul MMCfactorial.asm
bits  32
global  start

extern  printf, exit, scanf
import  printf msvcrt.dll
import scanf msvcrt.dll
import  exit msvcrt.dll

extern Expression


segment  data use32 public data
    format_read db "%d%d%d", 0
	format_print db  "The result of the expression is = %d", 0
    first_number db 0
    second_number db 0 
    third_number db 0 
    result resd 1
segment  code use32 public code
start:
    
    ;scanf(format_read, first_number, second_number, third_number)
    push dword third_number
    push dword second_number
    push dword first_number
    push dword format_read
    call [scanf]
    add ESP, 4*4
    
    push dword [third_number]
    push dword [second_number]
    push dword [first_number]
   
    call Expression
    
    ;printf(format_print, a+b-c)
    push dword EBX
    push dword format_print
    call [printf]
    add ESP, 4*2
    
	push 0
	call [exit]