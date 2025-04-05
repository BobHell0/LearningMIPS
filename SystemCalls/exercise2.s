### Exercise: Write a program that asks the user for their name, reads it in, 
### and then prints "Hello [user’s name]!"

# I make the assumption that the end of input is marked by control-D instead 
# of a new line. Could not figure out how to make the new line not appear 
# when printing the name (caused the ! to be on a new line)

.data
whats_your_name:    .asciiz "Hello young padawan, what is your name? "   
name:                .space 100

greeting:           .asciiz "Hello "


.text
main:
    li      $v0, 4
    la      $a0, whats_your_name
    syscall

    li      $v0, 8
    la      $a0, name
    li      $a1, 100
    syscall
    
    li      $v0, 11
    li      $a0, '\n'
    syscall

    li      $v0, 4
    la      $a0, greeting
    syscall

    li      $v0, 4
    la      $a0, name
    syscall

    li      $v0, 11
    li      $a0, '!'
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall

    li      $v0, 10
    syscall
