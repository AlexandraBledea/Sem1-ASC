;Problem 6
;A text file is given. Read the content of the file, determine the digit with the highest frequency and display the digit along with its frequency on the screen. The name of text file is defined in the data segment.

bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll

; our data is declared here 
segment data use32 class=data
    nume_fisier db "input.txt", 0   ; numele fisierului care va fi deschis
    mod_acces db "r", 0             ; modul de deschidere a fisierului; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1            ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    nr_car_citite dd 0              ; variabila in care vom salva numarul de caractere citit din fisier in etapa curenta
    len equ 100                     ; numarul maxim de elemente citite din fisier intr-o etapa
    frecv times 10 db 0
    buffer resb len                 ; sirul in care se va citi textul din fisier
    curent_c db 0
    max_frecv dd 0
    max_numar dd 0
    format db "Frecventa = %d. Numar = %d", 0

    
; our code starts here
segment code use32 class=code
    start:
        ; apelam fopen pentru a deschide fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0                  
        je final
        
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; echivalentul in pseudocod al urmatoarei secvente de cod este:
        ;repeta
        ;   nr_car_citite = fread(buffer, 1, len, descriptor_fis)
        ;   daca nr_car_citite > 0
        ;       ; instructiuni pentru procesarea caracterelor citite in aceasta etapa
        ;pana cand nr_car_citite == 0
        
        bucla:
            ; citim o parte (100 caractere) din textul in fisierul deschis folosind functia fread
            ; eax = fread(buffer, 1, len, descriptor_fis)
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            ; eax = numar de caractere / bytes citite
            cmp eax, 0          ; daca numarul de caractere citite este 0, am terminat de parcurs fisierul
            je cleanup

            mov [nr_car_citite], eax        ; salvam numarul de caractere citie
            mov ebx, 0
            
            mov edi, buffer
            mov esi, frecv
            
            prelucram:
            mov eax,0
            mov al, [edi + ebx]
            
            cmp al, '0'
            jb next_character
            cmp al, '9'
            ja next_character
            
            sub al, '0'
            
            inc byte[esi + eax]
            
            next_character:     
            inc ebx 
            cmp ebx, [nr_car_citite]     
            jb prelucram
            
            ; reluam bucla pentru a citi alt bloc de caractere
            jmp bucla
        
        
      cleanup:
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4

        mov ecx,0
        
        mov esi, frecv
        
        frecventa:
        mov eax,0
        mov al,[esi + ecx]
        cmp al, [max_frecv]
        
        jb not_found_larger
        mov [max_frecv], eax
        mov [max_numar], ecx
        not_found_larger:
        inc ecx
        cmp ecx,10
        jb frecventa
        
        
        push dword[max_numar]
        push dword[max_frecv]
        push format
        call [printf]
        add esp, 4*3
      
      final:  
        ; exit(0)
        push    dword 0      
        call    [exit]       