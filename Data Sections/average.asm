; average.asm
; nasm -felf64 average.asm && gcc average.o && ./a.out 19 8 21 -33

; displays their average as a floating point number.

          global    main
          extern    atoi
          extern    printf
          default   rel

          section   .text
main:
          dec       rdi                 ; argc-1, since we don't count progoram name
          jz        nothingToAverage
          mov       [count], rdi        ; save number of real arguments
accumulate:
          push      rdi                 ; save register across call to atoi
          push      rsi
          mov       rdi, [rsi+rdi*8]    ; argv[rdi]
          call      atoi wrt ..plt      ; now rax has the int value of arg
          pop       rsi                 ; restore registers after atoi call
          pop       rdi
          add       [sum], rax          ; accumulate sum as we go
          dec       rdi                 ; count down
          jnz       accumulate          ; more arguments?
average:
          cvtsi2sd  xmm0, [sum]
          cvtsi2sd  xmm1, [count]
          divsd     xmm0, xmm1          ; xmm0 is sum/count
          mov       rdi,  format        ; 1st arg to printf
          mov       rax,  1             ; printf is varargs, there is 1 non-int argument

          sub       rsp,  8             ; align stack pointer
          call      printf wrt ..plt    ; printf(format, sum/count)
          add       rsp,  8             ; restore stack pointer

          ret

nothingToAverage:
          mov       rdi,  error
          xor       rax,  rax
          call      printf wrt ..plt
          ret


          section   .data
count:    dq        0
sum:      dq        0
format:   db        "%g", 10, 0
error:    db        "There are no command line arguments to average", 10, 0