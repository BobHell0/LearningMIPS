### Prompt for the user’s name, then tell them whether their name starts with 
### a letter from the first or second half of the alphabet. Be sure to handle 
### both upper and lower case correctly, but assume they entered a valid letter.

# first half        a - m inclusive
# second half       n - z inclusive

#### ASCII Information

# A - M         65 - 77
# N - Z         78 - 90

# a - m         97 - 109
# n - z         110 - 122



## Register log
# - $t0 will store the value of the first character of the name
# - $t1 will store the immeidate to determien whether the first character is 
# in the first or second haflf of the alphabet

.data
prompt_user_name:       .asciiz "What is your name? "
starts_1st_half:        .asciiz "Your name starts with a letter in the first half of the alphabet"
starts_2nd_half:        .asciiz "Your name starts with a letter the second half of the alphabet"
name:                   .space 100

.text
main:
    li      $v0, 4
    la      $a0, prompt_user_name
    syscall

    li      $v0, 8
    la      $a0, name
    li      $a1, 100
    syscall

    la      $t0, name
    lb      $t0, 0($t0)         # load (first) byte from $t0 register into $t0

    li      $t1, 97
    bge     $t0, $t1, capital_letter

    li      $t1, 78
    bge     $t0, $t1, second_half
    j       first_half

capital_letter:
    li      $t1, 110
    bge     $t0, $t1, second_half
    j       first_half

first_half:
    li      $v0, 4
    la      $a0, starts_1st_half
    syscall
    j       terminate

second_half:
    li      $v0, 4
    la      $a0, starts_2nd_half
    syscall

terminate:
    li      $v0, 11
    li      $a0, '\n'
    syscall

    li      $v0, 10
    syscall


