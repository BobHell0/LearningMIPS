## Basics
### Example 1 - If Statement
C version
```C
if (a > 0) {
    a++;
}
a *= 2
```

MIPS translation. We assume variable a is stored in register $t0
```s
    ble         $t0, $0, less_eq_0      # if (a <= 0) goto less_eq_0
    addi        $t0, $t0, 1            # else: a += 1

less_eq_0:
    sll         $t0, $t0, 1             # left bit shifting

```

- Test the **opposite condition** in MIPS to what we tested in C.
- For MIPS, if something is true, we likely *jump* over a block of code.
- sll instruction is short for **shift left logical**
- $0 is the zero register which always stores a value 0

### Example 2 - If-Else Statement
C code:
```c
if (a > 0) {
    b = 100;
} else {
    b -= 50;
}
```

MIPS translation:
```s
    ble         $t0, $0, less_than_equal_zero
    li          $t1, 100
    j greater_than_equal_zero

less_equal_0:
    addi $t1, $t1, -50

greater_0:
```
- j = the jump command

Simplification in C:
```c
b -= 50;
if (a > 0) {
    b = 100;
}
```

MIPS Translation:
```s
    addi        $t1, $t1, -50
    ble         $t0, $0, less_equal_0
    li          $t1, 100

less_equal_0:
```

## Compound Conditions
### Example 3 - Conjunction (And)
C code:
```c
if (a > 10 && a < b) {
    c += 20;
}

b &= 0xFF
```
MIPS Translation:
```s
    li      $t9, 10
    ble     $t0, $t9, b_mask    # if (a <= 10 or a >= b) {
    bge     $t0, $t1, b_mask    #   goto b_mask}

    addi    $t2, $t2, 20

b_mask:
    andi    $t1, $t1, 0xFF
```
- Translating conjunction means choosing negation of each condition, and if those get triggered, jump over the instructions *within* the if statement

- If the **addi** instruction is run, the program naturally runs the next instruction which will be the **andi** instruction as required

### Example 4 - Disjuntion (Or)
C code:
```c
if (a > 10 || a < b) {
    c += 20;
}

b &= 0xFF
```

MIPS Translation:
```s
    li      $t9, 10
    bgt     $t0, $t9, do_true
    blt     $t0, $t1, do_true
    j       done_if

do_true:
    addi    $t2, $t2, 20

done_if:
    andi    $t1, $t1, 0xFF
```

### Example 5 - Mixed Statements
C code:
```c
if (a > 10 || (c > 100 && b >= c)) {
    printf("True\n");
}

b |= 0xAA;
```
- Something to note: && is prioritised over ||
    - So technically the inner parentheses pair is not necessary (although it is for readability)

MIPS Translation:
```s
.data
true_text:   .asciiz "True\n"

.text
    li      $t8, 10
    li      $t9, 100
    bgt     $t0, $t8, do_true     # if a > 10 then condition is met

    ### At this point we know a <= 10
    ble     $t2, $t9, done_if     # if c <= 100, then the condition fails
    blt     $t1, $t2, done_if     # if b < c, then the condition fails

do_true:
    li      $v0, 4
    la      $a0, true_text
    syscall

done_if:
    ori     $t1, $t1, 0xAA
```

## If-Else If-Else Chains
### Example 6 - If-Else If-Else

C code:
```c
#include <stdio.h>

int main(void) {

    int score;
    char letter_grade;

    printf("Enter your score ");
    scanf("%d", &score);

    if (score >= 90) {
        letter_grade = 'A';
    } else if (score >= 80) {
        letter_grade = 'B';
    } else if (score >= 70) {
        letter_grade = 'C';
    } else if (score >= 60) {
        letter_grade = 'D';
    } else {
        letter_grade = 'F'
    }
    printf("You recieved a letter grade of %c\n", letter_grade);
    return 0;
}
```

MIPS Translation
```s
.data
grade_prompt: "Enter your score "
result: "You recieved a letter grade of "

.text
### Register $t0 will hold the score value
### Register $t1 will hold the letter_grade value

### Register $t2 will hold the value to compare
main:
    li      $v0, 4
    la      $a0, grade_prompt
    syscall

    li      $v0, 5
    syscall

    move    $t0, $v0            # $t0 holds score

    li      $t2, 90
    blt     $t0, $t2, not_a
    li      $t1, 'A'
    j       printing_result

not_a:
    li      $t2, 80
    blt     $t0, $t2, not_b
    li      $t1, 'B'
    j       printing_result

not_b:
    li      $t2, 70
    blt     $t0, $t2, not_c
    li      $t1, 'C'
    j       printing_result

not_c:
    li      $t2, 60
    blt     $t0, $t2, not_d
    li      $t1, 'D'
    j       printing_result

not_d:
    li      $t1, 'E'

printing_result:
    li      $v0, 4
    la      $a0, result
    syscall

    li      $v0, 11
    move    $a0, $t1
    syscall

    li      $a0, '\n'
    syscall



```