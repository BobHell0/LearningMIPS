# Exericse: translate the C code from exercise1.c
.data
enter_int_prompt:   .asciiz "Enter an integer "
res_gt_50:          .asciiz "The number is greater than 50\n"
res_lt_50:          .asciiz "The number is less than 50\n"
res_eq_50:          .asciiz "You entered 50!\n"

.text
### Register log
# $t0 will hold the number
# $t1 will hold the immediate value 50

main:
    li      $v0, 4
    la      $a0, enter_int_prompt
    syscall

    li      $v0, 5
    syscall
    move    $t0, $v0

    li      $t1, 50
    
    ble     $t0, $t1, not_gt_50
    li      $v0, 4
    la      $a0, res_gt_50
    syscall
    j       terminate_prog

not_gt_50:
    beq     $t0, $t1, eq_50
    li      $v0, 4
    la      $a0, res_lt_50
    syscall
    j       terminate_prog

eq_50:
    li      $v0, 4
    la      $a0, res_eq_50
    syscall

terminate_prog:
    li      $v0, 10
    syscall

