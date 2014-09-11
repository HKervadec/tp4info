#include "Carte.h"
#include <iostream>

Carte::Carte()
{
}

Carte::Carte(Couleur c, Valeur v, char p){
	this->c = c;
	this->v = v;
	
	if (p == 'N'){
		if (Carte::Nd == NULL){
			Carte::Nd == this;
			Carte::Nf == this;
		}
		else{
			Carte::Nf->next = this;
			Carte::Nf == this;
		}
	}
	else {
		if (Carte::Sd == NULL){
			Carte::Sd == this;
			Carte::Sf == this;
		}
		else{
			Carte::Sf->next = this;
			Carte::Sf == this;
		}
	}
}

Carte::~Carte()
{
}

void Carte::afficher(){
	std::cout << this->c << " " << this->v << std::endl;
}

bool Carte::egale(Carte* card){
	return this->c == card->c && this->v == card->v;
}

Carte* Carte::suc(){
	return this->next;
}

void Carte::afficherN(){
	Carte * carteCourante = Carte::Nd;

	do{
		carteCourante->afficher();

		carteCourante = carteCourante->next;
	} while (carteCourante != Carte::Nf);
}

void Carte::afficherS(){
	Carte * carteCourante = Carte::Sd;

	do{
		carteCourante->afficher();

		carteCourante = carteCourante->next;
	} while (carteCourante != Carte::Sf);
}

Carte* Carte::getNTete(){
	return Carte::Nf;
}

Carte* Carte::getSTete(){
	return Carte::Sf;
}