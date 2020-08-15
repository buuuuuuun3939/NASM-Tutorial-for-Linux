; hello2.asm
; nasm -felf64 hello2.asm && gcc hello2.o && ./a.out

          global    main
          extern    puts

          section   .text
main:                               ; This is called by the C library startup code
          mov       rdi, message    ; First integer (or pointer) argument in rdi
          call      puts wrt ..plt  ; puts(message)
          ret

message:
          db        "Hello, World2", 0