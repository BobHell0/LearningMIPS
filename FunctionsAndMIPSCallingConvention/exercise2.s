# The Collatz conjecture is defined as follows: start with any positive integer n, 
# if n is even, divide by 2, otherwise, multiply by 3 and add 1. The conjecture is that all 
# sequences will eventually reach 1. Write 2 versions of the collatz function, one iterative and 
# one recursive. Print out the sequence as they go.




main:
    li      $a0, 24
    jal     collatz_iterative

    li      $a0, 63
    jal     collatz_recursive

    li      $v0, 11
    li      $a0, '\n'
    syscall

    li      $v0, 10             # exit syscall
    syscall


############################## Iterative Version ##############################
# $a0: n

# $t0: n % 2
# $t1: copy of n ($a0 is later used for syscalls)
# $t2 = 1 (for checking  terminating condition)
# $t3 = 2 (for dividing by 2)
# $t3 = 3 (for multiplying by 3)


collatz_iterative:
    move    $t1, $a0
    li      $t2, 1
    li      $t3, 2
    li      $t4, 3
    

collatz_iterative_loop:

    beq     $t1, $t2, collatz_iterative_terminate       # checking if n == 1
    li      $v0, 1
    move    $a0, $t1
    syscall

    li      $v0, 11
    li      $a0, ' '
    syscall

    div     $t1, $t3        # dividing n / 2 (without reassigning n) to get remainder

    mfhi    $t0             # n % 2
    beq     $t0, 0, collatz_iterative_update_even

collatz_iterative_update_odd:
    mult    $t1, $t4        # multiplying n by 3
    mflo    $t1             # n = 3 * n
    addi    $t1, $t1, 1     # n = n + 1
    j       collatz_iterative_loop


collatz_iterative_update_even:
    div     $t1, $t3
    mflo    $t1
    j       collatz_iterative_loop 

collatz_iterative_terminate:
    li      $v0, 1
    li      $a0, 1
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall

    jr      $ra

######### Recursive Version ########
collatz_recursive:
    move    $t1, $a0
    li      $t2, 1
    li      $t3, 2
    li      $t4, 3

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    li      $v0, 1
    move    $a0, $t1
    syscall



collatz_recursive_body:

    beq     $t1, $t2, collatz_recursive_terminate       # checking if n == 1
    
    li      $v0, 11
    li      $a0, ' '
    syscall

    div     $t1, $t3        # dividing n / 2 (without reassigning n) to get remainder

    mfhi    $t0             # n % 2
    beq     $t0, 0, collatz_recursive_update_even

collatz_recursive_update_odd:
    mult    $t1, $t4        # multiplying n by 3
    mflo    $t1             # n = 3 * n
    addi    $t1, $t1, 1     # n = n + 1

    j       collatz_recursive_recurse

collatz_recursive_update_even:
    div     $t1, $t3
    mflo    $t1

    j       collatz_recursive_recurse

collatz_recursive_recurse:
    move    $a0, $t1
    jal     collatz_recursive

collatz_recursive_terminate:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra