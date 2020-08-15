; hello.asm
; nasm -felf64 hello.asm && ld hello.o && ./a.out

          global    _start

          section   .text
_start:   mov       rax, 1        ; system call for write
          mov       rdi, 1        ; file handle 1 is stdout
          mov       rsi, message  ; address of string ot output
          mov       rdx, 13       ; number of bytes(include \n)
          syscall                 ; system call for exit
          mov       rax, 60       ; exit
          xor       rdi, rdi      ; invoke operating system to exit
          syscall

          section   .data
message:  db        "Hello, World", 10