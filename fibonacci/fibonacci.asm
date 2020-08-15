; fibonacci.asm
; nasm -felf64 fibonacci.asm && gcc fibonacci.o && ./a.out

        global  main
        extern  printf

        section .text
main:
        push    rbx

        mov     ecx, 90           ; ecx will countdown to 0
        xor     rax, rax          ; rax will hold the current number
        xor     rbx, rbx          ; rbx will hold the next number
        inc     rbx               ; rbx is originally 1
print:
        push    rax
        push    rcx

        mov     rdi, format       ; set 1st parameter
        mov     rsi, rax          ; set 2nd parameter(current_number)
        xor     rax, rax          ; because printf is varargs

        call    printf wrt ..plt  ; printf(format, current_number)

        pop     rcx
        pop     rax

        mov     rdx, rax          ; save the current number
        mov     rax, rbx          ; next number is now current
        add     rbx, rdx          ; get the new next number
        dec     ecx               ; count down
        jnz     print             ; if not done counting, do some more

        pop     rbx               ; restore rbx before returning
        ret
format:
        db  "%20ld", 10, 0
