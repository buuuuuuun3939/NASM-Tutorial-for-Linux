; echo.asm
; nasm -felf64 echo.asm && gcc echo.o && ./a.out dog 22 -zzz "hi there"

; int main(int argc, char** argv)

        global  main
        extern  puts
        section .text

main:
        push    rdi         ; save registers that puts uses
        push    rsi
        sub     rsp, 8      ; must align stack before call

        mov     rdi, [rsi]  ; the argument string to display
        call    puts wrt ..plt ; print it

        add     rsp, 8      ; restore %rsp to pre-aligned value
        pop     rsi         ; restore registers puts used
        pop     rdi

        add     rsi, 8      ; point to next argument
        dec     rdi         ; count down
        jnz     main        ; if not done counting keep going

        ret