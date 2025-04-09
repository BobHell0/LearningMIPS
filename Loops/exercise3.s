# Write a program to find the min and max of the array in the previous exercise
### After completing this exercise, I wanted to explain the addition of check_max
### and check_min labels. Especially at the start of the loop, it is possible for
### the current element to be the new min AND the new max. So it was essential 
### that I allowed both the min check and the max check to be conducted on each
### element. (Basically to if statements, rather than an if-else if statement.)
.data
array: .word 93, 8, 78, -6, 51, 49, 3, 2, 128, 0

.text
main:
la      $t1, array      # address saver (*p)

li      $t2, 0          # i = 0
li      $t3, 10         # SIZE = 10

li      $t8, -2147483648 # max              # TODO: figure out in hex
li      $t9, 2147483647 # min


loop:
lw      $t0, 0($t1)     # loading integer from array address


check_max:
bgt     $t0, $t8, update_max

check_min:
blt     $t0, $t9, update_min
j       loop_increment

update_max:
move    $t8, $t0
j       check_min

update_min:
move    $t9, $t0

loop_increment:
addi    $t2, $t2, 1     # i += 1
addi    $t1, $t1, 4     # *p += 4

blt     $t2, $t3, loop

terminate_loop:
div     $t0, $t3        # divide sum by SIZE
mflo    $t5             # store the answer in $t5



li      $v0, 1          # print the maximum
move    $a0, $t8
syscall

li      $v0, 11
li      $a0, '\n'
syscall


li      $v0, 1          # print the minimum
move    $a0, $t9
syscall


li      $v0, 11
li      $a0, '\n'
syscall

li      $v0, 10
syscall