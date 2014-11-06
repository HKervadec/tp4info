/**
TP 7 Base de Données Déductives (BDD) - Prolog

@author Hoel Kervadec
@version Annee scolaire 2014/2015
*/


/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================
*/
% ============================================================================= 
% SECTION 1 : Base de données
% ============================================================================= 

assemblage(voiture, porte, 4).
assemblage(voiture, roue, 4).
assemblage(voiture, moteur, 1).
assemblage(roue, jante, 1).
assemblage(porte, tole, 1).
assemblage(porte, vitre, 1).
assemblage(roue, pneu, 1).
assemblage(moteur, piston, 4).
assemblage(moteur, soupape, 16).

           
piece(p1, tole, lyon).
piece(p2, jante, lyon).
piece(p3, jante, marseille).
piece(p4, pneu, clermontFerrand).
piece(p5, piston, toulouse).
piece(p6, soupape, lille).
piece(p7, vitre, nancy).
piece(p8, tole, marseille).
piece(p9, vitre, marseille).

                  
demandeFournisseur(dupont, lyon).
demandeFournisseur(michel, clermontFerrand).
demandeFournisseur(durand, lille).
demandeFournisseur(dupond, lille).
demandeFournisseur(martin, rennes).
demandeFournisseur(smith, paris).
demandeFournisseur(brown, marseille).
          
          
fournisseurReference(f1, dupont, lyon).
fournisseurReference(f2, durand, lille).
fournisseurReference(f3, martin, rennes).
fournisseurReference(f4, michel, clermontFerrand).
fournisseurReference(f5, smith, paris).
fournisseurReference(f6, brown, marseille).

                  
livraison(f1, p1, 300).
livraison(f2, p2, 200).
livraison(f3, p3, 200).
livraison(f4, p4, 400).
livraison(f6, p5, 500).
livraison(f6, p6, 1000).
livraison(f6, p7, 300).
livraison(f1, p2, 300).
livraison(f4, p2, 300).
livraison(f4, p1, 300).


% ============================================================================= 
% SECTION 2 : Opération relationnelles
% ============================================================================= 

% Q 2.1
?-piece(X, Y, lyon).

% Q 2.2
?-piece(X, Y, _).

% Q 2.3
union(Nom, Ville):-
	demandeFournisseur(Nom, Ville).
union(Nom, Ville):-
	not(demandeFournisseur(Nom, Ville)),
	fournisseurReference(_, Nom, Ville).

intersection(Nom, Ville):-
	demandeFournisseur(Nom, Ville),
	fournisseurReference(_, Nom, Ville).


diff(Nom, Ville):-
	demandeFournisseur(Nom, Ville),
	not(fournisseurReference(_, Nom, Ville)).


% Q 2.4
prod_cart(N1, N2, Nom, Ville, Piece, Q):-
	fournisseurReference(N1, Nom, Ville),
	livraison(N2, Piece, Q).


% Q 2.5
jointure(Num, Nom, Ville, Piece, Q):-
	fournisseurReference(Num, Nom, Ville),
	livraison(Num, Piece, Q).

jointure_350(Num, Nom, Ville, Piece, Q):-
	jointure(Num, Nom, Ville, Piece, Q),
	Q > 350.


% Q 2.6
division(Piece, Nom):-
	jointure(_, Nom, _, Piece, _),
	piece(Piece, _, lyon).

% Q 2.7
total(Nom, SQ):-
	fournisseurReference(Num, Nom, _),
	findall(Q, livraison(Num, _, Q), Liste),
	sum_l(Liste, SQ).

sum_l([], 0).
sum_l([A|R], Q):-
	sum_l(R, Q2),
	Q is A + Q2.


% ============================================================================= 
% SECTION 3 : Au delà de l’algèbre relationnelle
% ============================================================================= 

% Q 3.1
% Sale, a ameliorer
% Utilise pas assez recursivite
ensemble_comp(C, Ens):-
	findall(Composant, assemblage(C, Composant, _), L1),
	ensemble_comp2(L1, Ens1),
	ensemble_comp2(Ens1, Ens2),
	append(L1, Ens1, Ens3),
	append(Ens2, Ens3, Ens).

ensemble_comp2([], []).
ensemble_comp2([A|R], L):-
	findall(Composant, assemblage(A, Composant, _), L1),
	ensemble_comp2(R, L2),
	append(L1, L2, L).

% Q 3.2
% Suppose que ensemble_comp est valide
% A fixer
piece_total(C, Total):-
	ensemble_comp(C, Ens),
	sum_ens(Ens, Total).

sum_ens([], 0).
sum_ens([A|R], T):-
	sum_ens(R, Q2),
	assemblage(_, A, Q1),
	T is Q1 + Q2.


% Q 3.3



/*
===============================================================================
===============================================================================
 Tests
===============================================================================


===============================================================================
[eclipse 5]: ?-piece(X,Y,lyon).

X = p1
Y = tole
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = p2
Y = jante
Yes (0.00s cpu, solution 2)


===============================================================================
[eclipse 7]: ?-piece(X,Y,_).

X = p1
Y = tole
Yes (0.00s cpu, solution 1, maybe more) ? ;

...

X = p9
Y = vitre
Yes (0.00s cpu, solution 9)



===============================================================================
[eclipse 25]: ?-union(X,Y).

X = dupont
Y = lyon
Yes (0.00s cpu, solution 1, maybe more) ? ;

...

X = brown
Y = marseille
Yes (0.00s cpu, solution 7, maybe more) ? ;

No (0.00s cpu)



===============================================================================
[eclipse 18]: ?-intersection(X,Y).

X = dupont
Y = lyon
Yes (0.00s cpu, solution 1, maybe more) ? '

...

X = brown
Y = marseille
Yes (0.00s cpu, solution 6)


===============================================================================
[eclipse 24]: ?-diff(X, Y).

X = dupond
Y = lille
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)
===============================================================================
[eclipse 36]: ?-prod_cart(A,B,C,D,E,F).

A = f1
B = f1
C = dupont
D = lyon
E = p1
F = 300
Yes (0.00s cpu, solution 1, maybe more) ? ;

...

A = f6
B = f4
C = brown
D = marseille
E = p1
F = 300
Yes (0.02s cpu, solution 60)




===============================================================================
[eclipse 30]: ?-jointure(A,B,C,D,E).

A = f1
B = dupont
C = lyon
D = p1
E = 300
Yes (0.00s cpu, solution 1, maybe more) ? ;

A = f1
B = dupont
C = lyon
D = p2
E = 300
Yes (0.00s cpu, solution 2, maybe more) ? ;

A = f2
B = durand
C = lille
D = p2
E = 200
Yes (0.00s cpu, solution 3, maybe more) ? ;

A = f3
B = martin
C = rennes
D = p3
E = 200
Yes (0.00s cpu, solution 4, maybe more) ? ;

A = f4
B = michel
C = clermontFerrand
D = p4
E = 400
Yes (0.00s cpu, solution 5, maybe more) ? ;

A = f4
B = michel
C = clermontFerrand
D = p2
E = 300
Yes (0.00s cpu, solution 6, maybe more) ? ;

A = f4
B = michel
C = clermontFerrand
D = p1
E = 300
Yes (0.00s cpu, solution 7, maybe more) ? ;

A = f6
B = brown
C = marseille
D = p5
E = 500
Yes (0.00s cpu, solution 8, maybe more) ? ;

A = f6
B = brown
C = marseille
D = p6
E = 1000
Yes (0.00s cpu, solution 9, maybe more) ? ;

A = f6
B = brown
C = marseille
D = p7
E = 300
Yes (0.00s cpu, solution 10)

===============================================================================
[eclipse 39]: ?-jointure_350(A,B,C,D,E).

A = f4
B = michel
C = clermontFerrand
D = p4
E = 400
Yes (0.00s cpu, solution 1, maybe more) ? ;

A = f6
B = brown
C = marseille
D = p5
E = 500
;;

A = f6
B = brown
C = marseille
D = p6
E = 1000
Yes (0.00s cpu, solution 3, maybe more) ? ;

No (0.00s cpu)

===============================================================================
[eclipse 41]: ?-division(X,Y).

X = p1
Y = dupont
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = p2
Y = dupont
Yes (0.00s cpu, solution 2, maybe more) ? ;

X = p2
Y = durand
Yes (0.00s cpu, solution 3, maybe more) ? ;

X = p2
Y = michel
Yes (0.00s cpu, solution 4, maybe more) ? ;

X = p1
Y = michel
Yes (0.00s cpu, solution 5, maybe more) ? ;

No (0.00s cpu)

===============================================================================
[eclipse 58]: ?-total(dupont, Q).

Q = 600
Yes (0.00s cpu)

===============================================================================
[eclipse 72]: ?-ensemble_comp(voiture, Ens).

Ens = [porte, roue, moteur, tole, vitre, jante, pneu, piston, soupape]
Yes (0.00s cpu)

===============================================================================
[eclipse 74]: ?-piece_total(voiture, T).

T = 33
Yes (0.00s cpu)
[eclipse 75]: ?-piece_total(moteur, T).

T = 20
Yes (0.00s cpu)




*/

