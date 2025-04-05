### Modify the hello world program to print something different, perhaps your name.

.data
hello:      .asciiz "You were meant to bring balance to the force, not leave it in darkness!\n"

.text
main:
    li      $v0, 4          # load immeidate, v0 = 4 (4 is the printing)
    la      $a0, hello      # load address of string to print into a0
    syscall

    li      $v0, 10         # exit syscall
    syscall