.data
hello:      .asciiz "Hello world!\n"

.text
main:
    li      $v0, 4          # load immediate, v0 = 4 (4 is the printing)
    la      $a0, hello      # load address of string to print into a0
    syscall

    li      $v0, 10         # exit syscall
    syscall
