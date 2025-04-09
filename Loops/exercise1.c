#include <stdio.h>
#include <stdlib.h>

int main()
{
	int num = rand() % 101;
	int guess;
	puts("I'm thinking of a number 0-100.  Try to guess it!");
	while (1) {
		printf("Guess a number: ");
		scanf("%d", &guess);

		if (guess > num) {
			puts("Too high!");
		} else if (guess < num) {
			puts("Too low!");
		} else {
			break;
		}
	}

	printf("Correct, it was %d!\n", num);

	return 0;
}