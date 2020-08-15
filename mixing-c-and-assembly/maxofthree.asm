; maxofthree.asm
; nasm -felf64 maxofthree.asm && gcc callmaxofthree.c maxofthree.o && ./a.out

; int_t maxofthree(int64_t x, int64_t y, int64_t z)

        global    maxofthree
        
        section   .text
maxofthree:
        mov       rax, rdi    ; result (rax) initially holds x
        cmp       rax, rsi    ; is x less than y?
        cmovl     rax, rsi    ; if so, set result to y
        cmp       rax, rdx    ; is max(x, y) less than z?
        cmovl     rax, rdx    ; if so, set result to z
        ret                   ; the max will be in rax