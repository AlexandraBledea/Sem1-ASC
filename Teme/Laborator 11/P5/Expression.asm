bits 32

global Expression

segment  data use32 public code

Expression:
    
    mov AL, byte[ESP+4]
    cbw
    cwde
    mov EBX, EAX ; EBX = first number <=> a
    
    mov AL, byte[ESP+8]
    cbw
    cwde
    mov ECX, EAX ; ECX = second number <=> b
    
    mov AL, byte[ESP+12]
    cbw
    cwde
    
    add EBX, ECX ; EBX = first number + second number <=> a + b
    sub EBX, EAX ; EBX = first number + second number - third number <=> a + b - c

  
    ret 4*3
    