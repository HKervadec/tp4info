#pragma once
class Chaine
{
	char * array;

	static int diff(Chaine &a, Chaine &b);

	Chaine(Chaine & c, int d, int f);
public:
	Chaine();
	Chaine(char * c);
	Chaine(Chaine & c);

	Chaine operator+(Chaine b);
	Chaine operator+=(Chaine b);

	Chaine operator=(Chaine b);


	bool operator==(Chaine b);

	bool operator>(Chaine b);
	bool operator>=(Chaine b);

	bool operator<(Chaine b);
	bool operator<=(Chaine b);

	inline char operator[](int b);

	Chaine sous_chaine(char deb, char fin);
	Chaine sous_chaine(int ind_deb, int ind_fin);

	int find(char c);

	int len();

	virtual ~Chaine();
};

