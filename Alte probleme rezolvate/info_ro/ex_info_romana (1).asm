
    ;Se da un sir de doubleworduri. 
    ;Sa se creeze sirul rezultat care sa contina doar wordurile 
    ;care au ultima cifra k si fac parte (wordurile) dintr-un doubleword pozitiv. 
    ;Sa se calculeze expresia formata din maximul numerelor din acest sir impartita
    ;la minimul wordurilor din acest sir rezultat. Se va afisa afisa pe ecran exprsia
    ;sub forma: MX/MN = cat este C si restul este R, unde MX, MN, C si R sunt valori 
    ;efective in functie de exemplu pus in data segment.
    
bits 32
global start
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data

    sir dd 20,25,13,17,18,95
    lungime_sir equ ($-sir)/4
    maxim dd 0
    minim dd 0
    mesaj db "%d/%d= catul este %d si restul este %d", 0
    rez dw 0
    
    k db 5
    rezultat resw 12
    
    copy dd 0
    lungime_rez dd 0
    unused db 1
segment code use32 class=code
start:
    mov ecx, lungime_sir
    
    mov esi, sir
    mov edi, rezultat
    cld
    each_dword:
        lodsd ; EAX <- dword from esi
        cmp eax, 0
        jl final
        mov dword [copy], eax
        mov bl, 10
        idiv bl ; AH <- ax %10
        cmp ah, [k]
            jne skip_word
            mov ax, [copy]
            stosw
            inc dword [lungime_rez]
        skip_word:
            mov ax, [copy+2]
            mov bl, 10
            idiv bl ; AH <- ax %10
            cmp ah, [k]
            jne final
            mov ax, [copy+2]
            stosw
            inc dword [lungime_rez]
    final:
    loop each_dword
  
    mov ESI,rezultat ;asta lipsea
    mov ax, [rezultat]
    mov word [minim], ax
    mov word [maxim], ax
    mov ecx, [lungime_rez]
    each_word:
        lodsw ; AX 
        cmp ax, [minim]
        jge bigger
        mov word [minim], ax
        jmp smaller
        bigger:
        cmp ax, [maxim]
        jle smaller
        mov word [maxim], ax
        smaller:
    loop each_word
    
    
 
    mov ax, word [maxim]
    cwd ; DX:AX
    mov bx, word [minim]
    idiv bx ; AX cat, DX rest
    
    mov CX,DX ; golim edx sa punem restul in el ca dword 
    mov EDX,0 ;
    mov DX,CX ;
    
    push dword EDX
    push dword eax
    push dword [minim]
    push dword [maxim]
    push dword mesaj
    call [printf]
    add esp, 4*5
    
    push dword 0
    call [exit]