#include "Chaine.h"
#include <string>
#include <algorithm>


Chaine::Chaine()
{
	this->array = new char[1];
	std::cout << "Construcion d'une chaine de taille 0." << std::endl;

	this->array[0] = '\0';
}

Chaine::Chaine(char * c){
	int size = strlen(c);

	this->array = new char[size + 1];
	std::cout << "Construcion d'une chaine de taille " << size << "." << std::endl;

	for (int i = 0; i < size; i++){
		this->array[i] = c[i];
	}
	this->array[size] = '\0';
}

Chaine::Chaine(Chaine& c){
	int l = c.len();

	this->array = new char[l];
	std::cout << "Construcion d'une chaine de taille " << l << "." << std::endl;

	for (int i = 0; i < l; i++){
		this->array[i] = c[i];
	}
	this->array[l] = '\0';
}

Chaine::Chaine(Chaine & c, int d, int f){
	int l_cut = f - d;

	this->array = new char(l_cut + 1);
	std::cout << "Construcion d'une chaine de taille " << l_cut << "." << std::endl;

	for (int i = 0; i < l_cut; i++){
		this->array[i] = c[d + i];
	}
	this->array[l_cut] = '\0';
}

int Chaine::len(){
	int l = 0;

	while (this->array[l] != '\0'){
		l++;
	}

	return l;
}

char Chaine::operator[](int b){
	return this->array[b];
}


Chaine::~Chaine()
{
	std::cout << "Destruction de la chaine." << std::endl;
	delete this->array;
}


Chaine Chaine::operator+(Chaine b){
	Chaine result = Chaine();

	result += *this;
	result += b;

	return result;
}

Chaine Chaine::operator+=(Chaine b){
	int l1 = this->len();
	int l2 = b.len();
	

	char * ra = new char[l1 + l2 + 1];

	for (int i = 0; i < l1; i++){
		ra[i] = this->array[i];
	}
	for (int j = 0; j < l2; j++){
		ra[l1 + j] = b[j];
	}
	ra[l1 + l2] = '\0';

	delete this->array;
	this->array = ra;

	return *this;
}


int Chaine::diff(Chaine &a, Chaine &b){
	int la = a.len(), lb = b.len();
	int l_min = std::min(la, lb);

	for (int i = 0; i < l_min; i++){
		if (a[i] != b[i]){
			return b[i] - a[i];
		}
	}

	if (la > l_min){
		return a[l_min];
	}
	if (lb > l_min){
		return b[l_min];
	}

	return 0;
}

bool Chaine::operator==(Chaine b){
	return diff(*this, b) == 0;
}

bool Chaine::operator<(Chaine b){
	return diff(*this, b) < 0;
}

bool Chaine::operator<=(Chaine b){
	return diff(*this, b) <= 0;
}

bool Chaine::operator>(Chaine b){
	return diff(*this, b) > 0;
}

bool Chaine::operator>=(Chaine b){
	return diff(*this, b) >= 0;
}

int Chaine::find(char c){
	int i = 0;
	while (this->array[i] != '\0'){
		if (this->array[i] == c){
			return i;
		}
	}

	return -1;
}

Chaine Chaine::sous_chaine(char deb, char fin){
	return sous_chaine(this->find(deb), this->find(fin));
}

Chaine Chaine::sous_chaine(int ind_deb, int ind_fin){
	int l = this->len();

	if (ind_deb < 0 || ind_fin > l){
		return Chaine();
	}
	
	return Chaine(*this, ind_deb, ind_fin);
}

std::ostream& operator<<(std::ostream& os, const Chaine& c){
	os << c.array;
	return os;
}