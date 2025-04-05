# Data Exercises
## Exercise 1

### Question 1          
- float a;
- **a:      float 0**

### Question 2          
- float b = 2.71;
- **b:      float 2.71**       

### Question 3          
- int myarray[10] = { 9, 8, 7, 6, 5, 4, 3, 2, 1 };
- **myarray     word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0**

### Question 4          
- short array2[10];
- **array2      half 20**        (recall shorts have 2 bytes)

### Question 5          
- char mips_str[] = "MIPS assembly is awesome!";
- **mips_str      asciiz "MIPS assembly is awesome!";**

## Exericse 2
```
struct point {
    float x;
    float y;
    float z;
}
```

*Declare an array of 500 points*
Working:
The struct point has three float variables which is equivalent to 12 bytes
So the total amount of space will be $12 \times 500 = 6000$ bytes

Answer:
- arr&nbsp;&nbsp;&nbsp;&nbsp;.space 6000

