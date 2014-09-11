#pragma once

#include <vector>

typedef enum Couleur {PIQUE, TREFLE, COEUR, CARREAU};
typedef enum Valeur {AS, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF, DIX, VALET, DAME, ROI};

class Carte
{
	Couleur c;
	Valeur v;
	char possesseur;
	Carte* next;
public:
	static Carte* Nd;
	static Carte* Nf;
	static Carte* Sd;
	static Carte* Sf;

	Carte();
	Carte(Couleur c, Valeur v, char p);
	~Carte();

	void afficher();
	bool egale(Carte* card);
	Carte* suc();

	static void afficherN();
	static void afficherS();

	static Carte* getNTete();
	static Carte* getSTete();
};

Carte* Carte::Nd = NULL;
Carte* Carte::Nf = NULL;
Carte* Carte::Sd = NULL;
Carte* Carte::Sf = NULL;

