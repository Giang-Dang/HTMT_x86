;Bài t?p 4. 
;Vi?t chuong trình nh?p s? nguyên n. 
;Ki?m tra n có là s? d?i xung hay không ?

%include "io.inc"
extern _getch

section .data
    input_msg db "Nhap so nguyen n: ", 0
    palindrome_msg db "So nhap vao LA so doi xung.", 0
    not_palindrome_msg db "So nhap vao KHONG PHAI la so doi xung.", 0
    n_input_fmt db "%d", 0
    
section .bss
    n resd 1
    reversed_n resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;print input_msg
    push input_msg
    call _printf
    add esp, 4
    
    ;scanf n
    push n
    push n_input_fmt
    call _scanf
    add esp, 8

;    ;test
;    mov dword[n], 12321
    
    ;prepare for _IsPalindrome
    push dword[n]
    call _IsPalindrome
    add esp, 4
    
    ;getch
    call _getch
    
    xor eax, eax
    ret
    
global _IsPalindrome
_IsPalindrome:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;get argument
    mov eax, [ebp + 8];store n in eax
    ;store n in stack
    push eax
    
    reverse:
        ;if n = 0 (finish reversing) => go to compare_to_origin
        pop eax
        cmp eax, 0
        je compare_to_origin
        
        ;n = n div 10 then store n in ebx
        xor edx, edx
        mov ecx, 10
        div ecx
        ;store n in stack
        push eax
        ;store remainder in stack
        push edx
        
        ;reversed_n = reversed_n*10 + remainder
        mov eax, dword[reversed_n]
        mov ecx, 10
        mul ecx       
        ;pop and add remainder
        pop edx
        add eax, edx
        ;store result in reversed_n variable
        mov dword[reversed_n], eax
        ;loop
        jmp reverse
    
    compare_to_origin:
        mov ecx, dword[n]
        cmp ecx, dword[reversed_n]
        je palindrome
        jne not_palindrome
    
    palindrome:
        ;print palindrome_msg
        push palindrome_msg
        call _printf
        add esp, 4
        
        ;exit
        jmp exit_palindrome
        
    not_palindrome:
        ;print not_palindrome_msg
        push not_palindrome_msg
        call _printf
        add esp, 4
        
        ;exit
        jmp exit_palindrome
    
    exit_palindrome:
        ;restore ebp
        mov esp, ebp
        pop ebp
        
        ;exit
        ret
        
    