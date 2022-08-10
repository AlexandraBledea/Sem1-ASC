bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf, gets               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll


; Read a sentence from the keyboard. For each word, obtain a new one by taking the letters in reverse order and print each new word. 


; our data is declared here (the variables needed by our program)
segment date use32 class=data:
    format_string db "Type in the sentence: ", 0
    format db "%s ", 0
    given_sentence times 100 db 0
    new_word times 100 db 0
    
segment date use32 class=code:
    start:
    push dword format_string
    call [printf]
    add ESP, 4*1
    
    push dword given_sentence
    call[gets]
    add ESP, 4*1
    
    
    mov ESI, 0
    mov EDI, 0
    
    for_every_word:
    
        find_the_length_of_the_word:
        
            cmp byte[given_sentence + EDI], 20h ; We check if we reached a character which is a white space
            je go_further
            cmp byte[given_sentence + EDI], 0 ; We check if we reached the last word
            je go_further
            
            inc EDI
        jmp find_the_length_of_the_word
            
        go_further:
        mov EBX, 0
        mov ECX, 100
        for_every_character:
            mov byte[new_word + EBX], 0
            inc EBX
        loop for_every_character
        
        
        ; We need to compute the length of the word
        mov EBX, EDI
        sub EBX, ESI ; In EBX we have the length of the word
        mov ECX, EBX
        
        mov EBX, EDI ; We need to save the value of EDI
        dec EDI ; We remove the space or the zero character
        
        mov EDX, 0 ; With the help of EDX we will 
        
        mirror_the_word:
            mov AL, byte[given_sentence + EDI]
            mov byte[new_word + EDX], AL
            inc EDX
            dec EDI
            loop mirror_the_word

        push dword new_word
        push dword format
        call [printf]
        add ESP, 4*2
        
        mov EDI, EBX ; We restore the value of EDI
        cmp byte[given_sentence + EDI], 0
        je final
        
        mov ESI, EDI 
        inc ESI
        add EDI, 1
        jmp for_every_word
        
        
    
        
    final:
    push dword 0
    call [exit]

    
    
    
    