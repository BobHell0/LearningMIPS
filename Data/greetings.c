// An example program which takes in user input (via scanf) and looks to
// print a variable string based on that user input

#include <stdio.h>

int main(void) {
    char name[30];
    int age;
    printf("What is your name and age?\n");
    scanf("%s %d", name, &age);
    printf("Hello %s, nice to meet you\n", name);
    return 0;
}
