# Convert the  C code (in exercise1.c) to MIPS. If using SPIM, you can just hard 
# code a "random" number between 0 and 100.

.data
intro_instruction:   .asciiz "I'm thinking of a number 0-100. Try to guess it!\n"
prompt_instruction:  .asciiz "Guess a number: "

too_high:            .asciiz "Too high!\n"
too_low:             .asciiz "Too low!\n"

correct:             .asciiz "Correct, it was "

.text
main:
    # num = rand % 101
    li      $t9, 46

    # I'm thinking of a number 0 - 100. Try guess it!
    li      $v0, 4
    la      $a0, intro_instruction
    syscall

loop:
    # Guess a number
    li      $v0, 4
    la      $a0, prompt_instruction
    syscall

    # scanf
    li      $v0, 5
    syscall

    # if guess < true: goto low
    blt     $v0, $t9, low

    # elif true < guess: goto high
    blt     $t9, $v0, high

    # else: goto correct
    j       terminate_loop     


high:
    # Too high!
    li      $v0, 4
    la      $a0, too_high
    syscall

    # restart loop
    j       loop


low:
    # Too low!
    li      $v0, 4
    la      $a0, too_low
    syscall

    # restart loop
    j       loop


terminate_loop:
    # Correct it was 
    li      $v0, 4
    la      $a0, correct
    syscall

    # guess
    li      $v0, 1
    move    $a0, $t9
    syscall

    # new line
    li      $v0, 11
    li      $a0, '\n'
    syscall

    # exit
    li      $v0, 10
    syscall




    