; power.asm
; nasm -felf64 power.asm && gcc -no-pie -o power power.o

; Sysntax: power x y
; x and y are (32-bit) integers

        global  main
        extern  printf
        extern  puts
        extern  atoi

        section .text
main:
        push    r12           ; save callee-save registers
        push    r13
        push    r14

        cmp     rdi, 3        ; must have exactly two arguments
        jne     error1

        mov     r12, rsi      ; argv

        mov     rdi, [r12+16] ; argv[2]
        call    atoi wrt ..plt         ; y in eax
        cmp     eax, 0        ; disallow negative exponents
        jl      error2
        mov     r13d, eax     ; y in r13d

        mov     rdi, [r12+8]  ; argv
        call    atoi wrt ..plt         ; x in eax
        mov     r14d, eax     ; x in r14d

        mov     eax, 1        ; start with answer = 1
check:
        test    r13d, r13d    ; we're counting y downto 0
        jz      gotit         ; done
        imul    eax, r14d     ; multiply in another x
        dec     r13d
        jmp     check
gotit:                        ; print report on success
        mov     rdi, answer
        movsxd  rsi, eax
        xor     rax, rax
        call    printf wrt ..plt
        jmp     done
error1:                       ; print error message
        mov     edi, badArgumentCount
        call    puts wrt ..plt
        jmp     done
error2:                       ; print error message
        mov     edi, negativeExponent
        call    puts wrt ..plt
done:                         ; restore saved rgisters
        pop     r14
        pop     r13
        pop     r12
        ret

answer:
        db      "%d", 10, 0
badArgumentCount:
        db      "Requires exactly two arguments", 10, 0
negativeExponent:
        db      "The exponent may not be negative", 10, 0