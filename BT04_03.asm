;Bài t?p 3. 
;Vi?t chuong trình nh?p vào s? nguyên n. 
;Ki?m tra n có là s? chính phuong hay không ?

%include "io.inc"
extern _getch

section .data
    input_msg       db  "Nhap so nguyen n: ", 0
    square_num_msg     db  "So nhap vao LA so chinh phuong.", 0
    not_square_num_msg db  "So nhap vao KHONG PHAI la so chinh phuong.", 0
    n_input_fmt     db  "%d", 0

section .bss
    n   resd    1
    IsSquareNumber_res resd 1
section .text
global CMAIN
CMAIN:
    
    ;print input_msg
    push input_msg
    call _printf
    add esp, 4
    
    ;scanf n
    push n
    push n_input_fmt
    call _scanf
    add esp, 8
    
    ;prepare for _IsSquareNumber
    push dword[n]
    mov dword[IsSquareNumber_res], 0
    call _IsSquareNumber
    add esp, 4
    
    ;getch
    call _getch
    
    xor eax, eax
    ret


global _IsSquareNumber
_IsSquareNumber:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;get argument
    mov ebx, [ebp + 8]
    
    ;set counter = 0
    mov esi, 0
    
    square_num_loop:
        ;eax = i*i
        mov eax, esi
        mul esi
        
        ;
        cmp eax, ebx
        je square_num
        jg not_square_num
        
        ;i++
        inc esi
        jmp square_num_loop
        
    square_num:
        ;print square_num_msg
        push square_num_msg
        call _printf
        add esp, 4
        
        ;exit
        jmp exit_square_num
        
    not_square_num:
        ;print not_square_num_msg
        push not_square_num_msg
        call _printf
        add esp, 4
        
        ;exit
        jmp exit_square_num
    
    exit_square_num:
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret
    
    