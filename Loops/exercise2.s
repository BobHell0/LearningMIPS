.data
array: .word 93, 8, 78, -6, 51, 49, 3, 2, 128, 0

.text
main:
li      $t0, 0          # sum = 0
la      $t1, array      # address saver (*p)

li      $t2, 0          # i = 0
li      $t3, 10         # SIZE = 10


loop:
lw      $t4, 0($t1)
add     $t0, $t0, $t4

addi    $t2, $t2, 1     # i += 1
addi    $t1, $t1, 4     # *p += 4

blt     $t2, $t3, loop

terminate_loop:
div     $t0, $t3        # divide sum by SIZE
mflo    $t5             # store the answer in $t5

li      $v0, 1          # print the result
move    $a0, $t5
syscall

li      $v0, 11
li      $a0, '\n'
syscall

li      $v0, 10
syscall