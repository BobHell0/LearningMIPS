.data
name:               .space 50
name_prompt:        .asciiz "What's you name? "
hello_space:        .asciiz "Hello "
how_old:            .asciiz "How old are you? "
ask_height:         .asciiz "Enter you height in inches: "
age_plus_height:    .asciiz "Your age + height = "

.text
main:
    # "What's your name? "
    li      $v0, 4                      # preparing the print string call
    la      $a0, name_prompt            # load the address of name_prompt into a0
    syscall

    # Read in name
    li      $v0, 8
    la      $a0, name                   # the input buffer is the global variable
    la      $a1, 50                     # allocate maximum of 50 chars here
    syscall

    # "Hello ...
    li      $v0, 4
    la      $a0, hello_space
    syscall

    # ...name"
    # no need to load 4 into $v0 because $v0 is unaltered since last syscall
    la      $a0, name
    syscall

    # "How old are you"
    li      $v0, 4
    la      $a0, how_old
    syscall

    # Read in age
    li      $v0, 5
    syscall                     # result will be stored in v0
    move    $t0, $v0            # save age value in register t0

    # "Enter you height in integers: "
    li      $v0, 4
    la      $a0, ask_height
    syscall

    # Read in height
    li      $v0, 5
    syscall                     # height will be stored in v0
    add     $t0, $t0, $v0       # add age (stored in t0) and height (stored in v0) 
                                # and store result in t0

    # "Your age + height = "
    li      $v0, 4
    la      $a0, age_plus_height
    syscall

    # Printing age_plus_height value
    li      $v0, 1
    move    $a0, $t0            # Now a0 = age + height
    syscall

    # print newline (\n)
    li      $v0, 11
    li      $a0, '\n'
    syscall

    # exit (return 0)
    li      $v0, 10
    syscall
