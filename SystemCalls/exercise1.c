#include <stdio.h>

int main() {
	float price;
	double golden = 1.618;
	int ret;

	printf("Enter what the price of gas was last time you filled up: ");
	scanf("%f", &price);

	printf("%f is too expensive!\n", price);

	printf("The golden ratio is roughly %f\n", golden);


	printf("Enter an integer for the program to return: ");
	scanf("%d", &ret);
	return ret;
}