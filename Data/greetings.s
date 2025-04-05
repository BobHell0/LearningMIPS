### In this chapter we primarily care about the data section
.data
age:        .word 0
ask_name:   .asciiz "What is your name and age?\n"
hello:      .asciiz "Hello "
nice_meet:  .asciiz ", nice to meet you!\n"

name        .space 30

### 
.text
# where the instructions would go to actually print these strings and take in
# user input (we will look into this in the syscall structures)


