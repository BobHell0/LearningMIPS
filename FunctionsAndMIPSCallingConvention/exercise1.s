# Implement the following functions in MIPS and write a program to demonstrate their use. 
# You can reuse much of your code from the previous chapter's exercises.


# C PROGRAM FUNCTION PROTOTYPES
#   // return the min or max
#   int get_min(int* array, int size);
#   int get_max(int* array, int size);

#   // return the index of the min/max
#   int locate_min(int* array, int size); 
#   int locate_max(int* array, int size); 
#   // return the average of the array

#   int calc_average(int* array, int size);


.data
    array:          .word 4, 3, 18, 2, 27, 4, 5, 9, 6, 3, 2
    min_value_is:   .asciiz "The min value of the array is: "
    max_value_is:   .asciiz "The max value of the array is: "
    
    min_value_location_is:  .asciiz "The location of the min value is: "
    max_value_location_is:  .asciiz "The location of the max value is: "

    average_is:     .asciiz "The average value is: "
.text
main:
    ## getting the min value
    la      $a0, array
    li      $a1, 11

    jal     get_min

    move    $t0, $v0

    li      $v0, 4
    la      $a0, min_value_is
    syscall

    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall
    ##

    ## getting the max value

    la      $a0, array
    li      $a1, 11
    
    jal     get_max
    move    $t0, $v0
    
    li      $v0, 4
    la      $a0, max_value_is
    syscall
    
    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall
    ##

    ## getting location of min value
    la      $a0, array
    li      $a1, 11
    jal     locate_min

    move    $t0, $v0
    
    li      $v0, 4
    la      $a0, min_value_location_is
    syscall

    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall
    ##

    ## getting location of min value
    la      $a0, array
    li      $a1, 11
    jal     locate_max

    move    $t0, $v0
    
    li      $v0, 4
    la      $a0, min_value_location_is
    syscall

    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall
    ##

    # getting average
    la      $a0, array
    li      $a1, 11
    jal     average

    move    $t0, $v0
    
    li      $v0, 4
    la      $a0, average_is
    syscall

    li      $v0, 1
    move    $a0, $t0
    syscall

    li      $v0, 11
    li      $a0, '\n'
    syscall
    ##

    

    li      $v0, 10         # exit syscall
    syscall
    

# get_min register usage
#   $a0: int* array
#   $a1: size(array)
#   $t0: i - loop increment value
#   $t1: current min value
#   $t2: current array value
get_min:
    li      $t1, 2147483647

    # assume the address to the array is stored in $a0 and 
    # the size of the array is in $a1
    li      $t0, 0      # i = 0

    move    $s0, $a0

get_min_loop:
    bge     $t0, $a1, get_min_exit

    lw      $t2, 0($s0) # curr_val = arr[i]



    bge     $t2, $t1, get_min_inc
    move    $t1, $t2

    
get_min_inc:
    addi    $t0, $t0, 1     # i += 1
    addi    $s0, $s0 4      # *p += 4
    j       get_min_loop

get_min_exit:
    move    $v0, $t1
    jr      $ra


get_max:
    li      $t1, -2147483648
    li      $t0, 0
    move    $s0, $a0

get_max_loop:
    bge     $t0, $a1, get_max_exit
    lw      $t2, 0($s0)
    ble     $t2, $t1, get_max_inc
    move    $t1, $t2

get_max_inc:
    addi    $t0, $t0, 1
    addi    $s0, $s0, 4
    j       get_max_loop

get_max_exit:
    move    $v0, $t1
    jr      $ra


# Gets the FIRST location of the min value of the array
# $a0: address of the array
# $a1: size of the array

# Register use
# $t0: increment value
# $t1: current min value
# $t2: current location value
# $t3: current array value
# s0: copied address of array (copied from $a0)
locate_min:
    move    $s0, $a0
    li      $t0, 0
    li      $t1, 2147483647
    li      $t2, -1

locate_min_loop:
    bge     $t0, $a1, locate_min_exit
    lw      $t3, 0($s0)
    bge     $t3, $t1, locate_min_inc

    move    $t2, $t0        # updating current min location with current index value
    move    $t1, $t3        # updating current min with current array value
    
locate_min_inc:
    addi    $t0, $t0, 1
    addi    $s0, $s0, 4
    j       locate_min_loop

locate_min_exit:
    move    $v0, $t2
    jr      $ra


# Gets the FIRST location of the max value of the array
# $a0: address of the array
# $a1: size of the array

# Register use
# $t0: increment value
# $t1: current max value
# $t2: current location value
# $t3: current array value
# s0: copied address of array (copied from $a0)
locate_max:
    move    $s0, $a0
    li      $t0, 0
    li      $t1, -2147483648
    li      $t2, -1

locate_max_loop:
    bge     $t0, $a1, locate_max_exit
    lw      $t3, 0($s0)
    ble     $t3, $t1, locate_max_inc        # if we have not found a bigger value, 
                                            # go straight to incrementing 

    move    $t2, $t0        # updating current max location with current index value
    move    $t1, $t3        # updating current max with current array value
    
locate_max_inc:
    addi    $t0, $t0, 1
    addi    $s0, $s0, 4
    j       locate_max_loop

locate_max_exit:
    move    $v0, $t2
    jr      $ra

# Gets the average value of elements in an array
# $a0: address of the array
# $a1: size of the array

# Register use
# $t0: increment value
# $t1: current sum
# $t2: current array value
# s0: copied address of array (copied from $a0)
average:
    move    $s0, $a0
    li      $t0, 0
    li      $t1, 0          

average_loop:
    bge     $t0, $a1, average_exit
    lw      $t2, 0($s0)
    add     $t1, $t1, $t2
    
average_inc:
    addi    $t0, $t0, 1
    addi    $s0, $s0, 4
    j       average_loop

average_exit:
    div     $t1, $a1
    mflo    $v0
    jr      $ra


