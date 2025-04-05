.data
enter_price_cmd:     .asciiz "Enter what the price of gas was last time you filled up: "
too_expensive:       .asciiz " is too expensive!\n"
golden_ratio_is:     .asciiz "The golden ratio is roughly "
enter_ret_cmd:       .asciiz "Enter an integer for the program to return: "
golden_ratio:        .double  1.618

.text
main: 
    li      $v0, 4
    la      $a0, enter_price_cmd
    syscall             # printf("Enter what the price of gas was last time you filled up: ");

    li      $v0, 6
    syscall             # price stored in register f0

    li      $v0, 2
    mov.s     $f12, $f0   
    syscall         # printf(gas_price...)

    li      $v0, 4
    la      $a0, too_expensive
    syscall         # printf("is too expensive!")

    li      $v0, 4              # might not need
    la      $a0, golden_ratio_is
    syscall             # printf("The golden ratio is roughly...")

    li      $v0, 3
    l.d      $f12, golden_ratio
    syscall                 # printf(...1.618)

    li      $v0, 11
    li      $a0, '\n'
    syscall                 # printf("\n")

    li      $v0, 4
    la      $a0, enter_ret_cmd
    syscall

    li      $v0, 5
    syscall         # scanf("%d", &ret)         stored in v0

    move    $t0, $v0
    
    li      $v0, 17         # exit2
    move    $a0, $t0
    syscall
