#include <iostream>

#include "Chaine.h"

int main(void){
	char input[81];
	std::cin >> input;

	Chaine c1(input), c2("Super c'est trop bien.");

	std::cout << c1 << std::endl;
	std::cout << c2 << std::endl;
	Chaine c3 = c1 + c2;
	std::cout << c3 << std::endl;

	system("PAUSE");
	return 0;
}