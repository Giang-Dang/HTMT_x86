;Bài tap 1. 
;Viet chuong trình nhap so nguyên n. 
;Kiem tra n có là so nguyên to hay không ?

%include "io.inc"
extern _getch

section .data
    input_msg db "Nhap so nguyen n: ", 0
    prime_msg db "So nhap vao LA so nguyen to.", 0
    not_prime_msg db "So nhap vao KHONG PHAI la so nguyen to.", 0
    n_input_fmt db "%d", 0
    
section .bss
    n resd 1
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;print(input_msg)
    push input_msg
    call _printf
    add esp, 4
    
    ;scanf("%d", &n)
    push n
    push n_input_fmt
    call _scanf
    add esp, 8

    ;;test
;    mov word[n], 13
    
    ;prepare for _CheckPrime fucntion
    push dword[n] ;pass argument 1
    call _CheckPrime
    add esp, 4
    
    ;getch()
    call _getch
    
    ;exit program
    xor eax, eax
    ret
    
global _CheckPrime
_CheckPrime:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64 
    
    ;get arguments
    mov ebx, [ebp + 8] ;ebx = n
    
    ;set iterator = 2
    mov esi, 2 ; i = 2
    
    check_prime_loop:
        ;compare n with i
        cmp ebx, esi
        
        ;case n < 2
        jl check_prime_false 
        
        ;check if n == i => true
        je check_prime_true
        
        ;check if n mod i == 0 => false
        mov eax, ebx
        xor edx, edx
        div esi
        cmp edx, 0
        je check_prime_false
        
        ;else: i++
        inc esi
        
        ;loop
        jmp check_prime_loop
       
    
    check_prime_false:        
        ;print not_prime_msg
        push not_prime_msg
        call _printf
        add esp, 4
        
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        ret
        
    check_prime_true:
        ;print prime_msg
        push prime_msg
        call _printf
        add esp, 4
        
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret