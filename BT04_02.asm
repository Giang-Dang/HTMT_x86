;Bài t?p 2. 
;Vi?t chuong trình nh?p s? nguyên n. 
;Ki?m tra n có là s? nguyên hoàn thi?n hay không ?

%include "io.inc"
extern _getch

section .data
    input_msg       db  "Nhap so nguyen n: ", 0
    perfect_msg     db  "So nhap vao LA so hoan hao.", 0
    not_perfect_msg db  "So nhap vao KHONG PHAI la so hoan hao.", 0
    n_input_fmt     db  "%d", 0

section .bss
    n   resd    1
    IsPerfectNumber_res resd 1
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
    
    ;;test
;    mov dword[n], 28
    
    ;prepare for _CheckPerfectNumber
    push dword[n]
    mov dword[IsPerfectNumber_res], 0 ;set return value to 0
    call _IsPerfectNumber
    add esp, 4
    
    cmp dword[IsPerfectNumber_res], 0
    je CMAIN_not_perfect
    jne CMAIN_perfect
    
    CMAIN_perfect:
        ;print perfect_msg
        push perfect_msg
        call _printf
        add esp, 4
    
        ;getch
        call _getch
        
        jmp CMain_exit
        
        
    CMAIN_not_perfect:
        ;print not_perfect_msg
        push not_perfect_msg
        call _printf
        add esp, 4
    
        ;getch
        call _getch
        
        jmp CMain_exit
        
    CMain_exit:
        xor eax, eax
        ret

;functions 
;   
global _IsPerfectNumber
_IsPerfectNumber:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;get argument
    mov ebx, [ebp + 8] ;ebx = n
    
    ;set sum = 0
    xor ecx, ecx
    
    ;set counter = 1
    mov esi, 1
    
    ;if n = 1 => not_perfect
    cmp ebx, 1
    jle not_perfect
    
    
    perfect_check_divisor:
        mov eax, ebx
        xor edx, edx
        div esi
        cmp edx, 0
        jne perfect_increase_counter
        
        add ecx, esi
        
    perfect_increase_counter:
        ;i++
        inc esi
        
        cmp esi, ebx
        
        ;if i < n => check_divisor
        jl perfect_check_divisor
        
        ;else, compare sum with n
        cmp ecx, ebx
        je perfect
        jne not_perfect
    
    perfect:
        mov dword[IsPerfectNumber_res], 1
        jmp exit_perfect
    
    not_perfect:
        mov dword[IsPerfectNumber_res], 0
        jmp exit_perfect

    exit_perfect:
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret
    
     
    
    
    
    