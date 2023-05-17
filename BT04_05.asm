;Bài t?p 5. 
;vi?t chuong trình th?c hi?n các ch?c nang sau:
;
;1. Nh?p m?ng 1 chi?u n ph?n t? s? nguyên
;
;2. Xu?t m?ng
;
;3. Li?t kê các s? nguyên t?
;
;4. Tìm giá tr? l?n nh?t trong m?ng
;
;5. Tính trung bình m?ng

%include "io.inc"
extern _getch

section .data
    new_line db 13, 10, 0
    ;menu
    menu_msg db "-----------------------------------", 13, 10, "Bai tap 05:", 13, 10, "===========================", 13, 10, "1. Nhap mang 1 chieu n phan tu so nguyen.", 13, 10, "2. Xuat mang.", 13, 10, "3. Liet ke cac so nguyen to.", 13, 10, "4. Tim gia tri lon nhat trong mang.", 13, 10, "5. Tinh trung binh mang.", 13, 10, "6. Thoat.", 13, 10, "===========================", 13, 10, "Chon so tuong ung roi an enter: ", 0
    input_one_number_fmt db "%d", 0
    
    ;InputArray
    input_array_length_msg db "Nhap so phan tu cua mang: ", 0
    input_element_msg db "Nhap phan tu %d cua mang: ", 0
    
    ;PrintArray
    print_array_msg db "Cac phan tu cua mang la: ", 0
    print_element_fmt db "%d ", 0
    
    ;PrintPrimes
    print_primes_msg db "Cac phan tu la so nguyen to cua mang la: ", 0
    
    ;PrintMax
    print_max_msg db "Phan tu co gia tri lon nhat cua mang la: ", 0
    
    ;PrintAvg
    print_avg_msg db "Gia tri trung binh cua cac phan tu trong mang la: ", 0
    print_float_fmt db "%f", 0    
    
section .bss
    ;menu
    choice resd 1
    
    ;InputArray
    nums_len resd 1
    nums resd 100
    
    ;PrintMax
    max resd 1

    ;PrintAvg
    sum resd 1
    avg resq 1
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
;    ;test
;    mov dword[nums_len], 4
;    mov dword[nums + 4], 1
;    mov dword[nums + 8], 3
;    mov dword[nums + 12], 6
;    mov dword[nums + 16], 7
;    mov dword[choice], 5
    
    CMAIN_start:
        ;;print menu_msg
        push menu_msg
        call _printf
        add esp, 4
        
        ;;scanf choice
        push choice
        push input_one_number_fmt
        call _scanf
        add esp, 8
     
;        ;test
;        mov dword[choice], 21
        
        ;navigation
        cmp dword[choice], 1
        je CMAIN_func_01
        
        cmp dword[choice], 2
        je CMAIN_func_02
        
        cmp dword[choice], 3
        je CMAIN_func_03
        
        cmp dword[choice], 4
        je CMAIN_func_04
        
        cmp dword[choice], 5
        je CMAIN_func_05
        
        cmp dword[choice], 6
        je CMAIN_exit
        
        ;else
        mov dword[choice], 0
        cmp dword[choice], 0
        je CMAIN_start
    
    CMAIN_func_01:
        ;call function
        call _InputArray
        
        ;
        jmp CMAIN_start

    CMAIN_func_02:
        ;call function
        call _PrintArray
        
        ;
        jmp CMAIN_start
        
    CMAIN_func_03:
        ;call function
        call _PrintPrimes
        
        ;
        jmp CMAIN_start
    
    CMAIN_func_04:
        ;call function
        call _PrintMax
        
        ;
        jmp CMAIN_start              
    
    CMAIN_func_05:
        ;call function
        call _PrintAvg
        
        ;
        jmp CMAIN_start      
    CMAIN_exit:
        xor eax, eax
        ret
    
global _InputArray
_InputArray:    
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;print input_array_length_msg
    push input_array_length_msg
    call _printf
    add esp, 4
    
    ;scanf array_len
    push nums_len
    push input_one_number_fmt
    call _scanf
    add esp, 8
    
    ;prepare for InputArray_loop
    mov esi, 0 ;esi = counter
    mov ebx, nums ;ebx = nums array's address
    
    InputArray_loop:
        inc esi
        add ebx, 4
        
        ;break loop condition
        cmp esi, dword[nums_len]
        jg InputArray_exit
        
        ;print input_element_msg
        push esi
        push input_element_msg
        call _printf
        add esp, 8
        
        ;scanf current element
        push ebx
        push input_one_number_fmt
        call _scanf
        add esp,8
        
        jmp InputArray_loop
        
    InputArray_exit:
        ;restore the caller's stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret
        
        
global _PrintArray
_PrintArray:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;print print_array_msg
    push print_array_msg
    call _printf
    add esp, 4
    
    ;prepare for InputArray_loop
    mov esi, 0 ;esi = counter
    mov ebx, nums ;ebx = nums array's address
    
    PrintArray_loop:
        inc esi
        add ebx, 4
        
        ;break loop condition
        cmp esi, dword[nums_len]
        jg PrintArray_exit
        
        ;print print_element_fmt
        push dword[ebx]
        push print_element_fmt
        call _printf
        add esp, 8
        
        jmp PrintArray_loop
        
    PrintArray_exit:
        ;print new_line
        push new_line
        call _printf
        add esp, 4
        
        ;clear choice
        mov dword[choice], 0
        
        ;restore the caller's stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret

global _PrintPrimes
_PrintPrimes:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;print print_primes_msg
    push print_primes_msg
    call _printf
    add esp, 4
    
    ;prepare for PrintPrimes_loop
    mov esi, 0 ;esi = counter
    mov ebx, nums ;ebx = nums array's address
    
    PrintPrimes_loop:
        inc esi
        add ebx, 4
        
        ;break loop condition
        cmp esi, dword[nums_len]
        jg PrintPrimes_exit
        
        ;prepare for _IsPrime
        mov ebx, dword[ebx] ; pass current num as argument 1 of _IsPrime
        xor ecx, ecx ;ecx stores result
        call _IsPrime
        add esp, 4
        
        ;restore ebx value : the address of nums array's current element
        mov eax, 4
        mul esi
        mov ebx, nums
        add ebx, eax
        
        ;if IsPrime == true => print element
        cmp ecx, 1
        je PrintPrimes_print_element
        
        ;if not => loop
        jne PrintPrimes_loop
    
    PrintPrimes_print_element:
        ;print print_element_fmt
        push dword[ebx]
        push print_element_fmt
        call _printf
        add esp, 8
        
        ;jump back to PrintPrimes_loop
        jmp PrintPrimes_loop
        
    PrintPrimes_exit:
        ;print new_line
        push new_line
        call _printf
        add esp, 4
        
        ;clear choice
        mov dword[choice], 0
        
        ;restore the caller's stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret

global _IsPrime
_IsPrime:
    ;the number to be checked stores in ebx
    
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;edi = counter = 2
    mov edi, 2
    
    IsPrime_loop:
        ;compare n with i
        cmp ebx, edi
        
        ;case n < 2
        jl IsPrime_false
        
        ;check if n == i => true
        je IsPrime_true
        
        ;check if n mod i == 0 => false
        mov eax, ebx
        xor edx, edx
        div edi
        cmp edx, 0
        je IsPrime_false
        
        ;else: i++
        inc edi
        
        ;loop
        jmp IsPrime_loop
       
    
    IsPrime_false:        
        ;ecx(result) = 0(false)
        mov ecx, 0
        
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        ret
        
    IsPrime_true:
        ;ecx(result) = 0(false)
        mov ecx, 1
        
        ;restore old stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret


global _PrintMax
_PrintMax:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;print print_max_msg
    push print_max_msg
    call _printf
    add esp, 4
    
    ;prepare for PrintMax_loop
    mov esi, 0 ;esi = counter
    
    ;max = nums[0]
    mov ebx, dword[nums + 4]
    mov dword[max], ebx
    
    mov ebx, nums ;ebx = nums array's address
    
    PrintMax_loop:
        inc esi
        add ebx, 4
        
        ;ecx stores current number
        mov ecx, dword[ebx]
        
        ;break loop condition
        cmp esi, dword[nums_len]
        jg PrintMax_print_result
        
        ;if max < current number => PrintMax_update_max
        cmp dword[max], ecx
        jl PrintMax_update_max
    
    PrintMax_update_max:
        ; max = current number
        mov dword[max], ecx
        
        ;return to PrintMax_loop
        jmp PrintMax_loop
    
    PrintMax_print_result:
        ;print print_element_fmt
        push dword[max]
        push print_element_fmt
        call _printf
        add esp, 8
        
        ;jump to PrintMax_exit
        jmp PrintMax_exit
        
    PrintMax_exit:
        ;print new_line
        push new_line
        call _printf
        add esp, 4
        
        ;clear choice
        mov dword[choice], 0
        
        ;restore the caller's stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret

global _PrintAvg
_PrintAvg:
    ;backup ebp
    push ebp
    
    ;create stack frame
    mov ebp, esp
    sub esp, 64
    
    ;print print_avg_msg
    push print_avg_msg
    call _printf
    add esp, 4
    
    ;prepare for PrintAvg_loop
    mov esi, 0 ;esi = counter  
    mov ebx, nums ;ebx = nums array's address
    mov dword[sum], 0
    mov dword[avg], 0
    
    PrintAvg_loop:
        inc esi
        add ebx, 4
        
        ;ecx stores current number
        mov ecx, dword[ebx]
        
        ;break loop condition
        cmp esi, dword[nums_len]
        jg PrintAvg_print_result
        
        ;sum += num[i]
        add dword[sum], ecx

        ;loop
        jmp PrintAvg_loop
    
    PrintAvg_print_result:
        ;calculate average
        finit ; init FPU stack
        fild dword[sum]
        fild dword[nums_len]
        fdiv
        fstp qword[avg]
        
        fstp st0 ;clean FPU stack
        
        ;print avg in float format 
        ;printf %f requires 64bit float argument.      
        ;sasm do not support push qword(64 bit) => push each part of avg in dword
        push dword[avg+4] 
        push dword[avg]
        push dword print_float_fmt 
        call printf
        add esp, 12
        
        ;jump to PrintAvg_exit
        jmp PrintAvg_exit
        
    PrintAvg_exit:
        ;print new_line
        push new_line
        call _printf
        add esp, 4
        
        ;clear choice
        mov dword[choice], 0
        
        ;restore the caller's stack frame
        mov esp, ebp
        pop ebp
        
        ;return
        ret