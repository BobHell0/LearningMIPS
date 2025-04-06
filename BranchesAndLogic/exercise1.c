// NOTE: The function puts() writes the string s, and a terminating newline character, 
// to the stream stdout. [Taken from manual]

#include <stdio.h>

int main()
{
	int num;
	printf("Enter an integer: ");
	scanf("%d", &num);

	if (num > 50) {
		puts("The number is greater than 50");
	} else if (num < 50) {
		puts("The number is less than 50");
	} else {
		puts("You entered 50!");
	}

	return 0;
}