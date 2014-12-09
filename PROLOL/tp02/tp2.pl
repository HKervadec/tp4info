% Septembre 2012
% TP2 TERMES CONSTRUITS - A compléter et faire tourner sous Eclipse Prolog
% ==============================================================================
% ============================================================================== 
%	FAITS
% ============================================================================== 
/*
	hauteur(Valeur)
*/
hauteur(deux).
hauteur(trois).
hauteur(quatre).
hauteur(cinq).
hauteur(six).
hauteur(sept).
hauteur(huit).
hauteur(neuf).
hauteur(dix).
hauteur(valet).
hauteur(dame).
hauteur(roi).
hauteur(as).

/*
	couleur(Valeur)
*/
couleur(trefle).
couleur(carreau).
couleur(coeur).
couleur(pique).

/*
	succ_hauteur(H1, H2)
*/
succ_hauteur(deux, trois).
succ_hauteur(trois, quatre).
succ_hauteur(quatre, cinq).
succ_hauteur(cinq, six).
succ_hauteur(six, sept).
succ_hauteur(sept, huit).
succ_hauteur(huit, neuf).
succ_hauteur(neuf, dix).
succ_hauteur(dix, valet).
succ_hauteur(valet, dame).
succ_hauteur(dame, roi).
succ_hauteur(roi, as).

/*
	succ_couleur(C1, C2)
*/
succ_couleur(trefle, carreau).
succ_couleur(carreau, coeur).
succ_couleur(coeur, pique).

/*
  carte_test
  cartes pour tester le prédicat EST_CARTE
*/

carte_test(c1,carte(sept,trefle)).
carte_test(c2,carte(neuf,carreau)).
carte_test(ce1,carte(7,trefle)).
carte_test(ce2,carte(sept,t)).

/* 
	main_test(NumeroTest, Main) 
	mains pour tester le prédicat EST_MAIN 
*/

main_test(main_triee_une_paire, main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).
% attention ici m2 représente un ensemble de mains	 
main_test(m2, main(carte(valet,_), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(as,pique))).
main_test(main_triee_deux_paires, main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).
main_test(main_triee_brelan, main(carte(sept,trefle), carte(dame,carreau), carte(dame,coeur), carte(dame,pique), carte(roi,pique))).	
main_test(main_triee_suite,main(carte(sept,trefle),carte(huit,pique),carte(neuf,coeur),carte(dix,carreau),carte(valet,carreau))).
main_test(main_triee_full,main(carte(deux,coeur),carte(deux,pique),carte(quatre,trefle),carte(quatre,coeur),carte(quatre,pique))).

main_test(merreur1, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle), carte(as,pique))).
main_test(merreur2, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle))).

% ============================================================================= 
%        QUESTION 1 : est_carte(carte(Hauteur,Couleur))
% ==============================================================================
est_carte(carte(H,C)):-
	couleur(C),
	hauteur(H).

% ============================================================================= 
%	QUESTION 2 : est_main(main(C1,C2,C3,C4,C5))
% ============================================================================= 
est_main(main(C1,C2,C3,C4,C5)):-
	est_carte(C1),
	est_carte(C2),
	est_carte(C3),
	est_carte(C4),
	est_carte(C5),
	\==(C1,C2),
	\==(C1,C3),
	\==(C1,C4),
	\==(C1,C5),
	\==(C2,C3),
	\==(C2,C4),
	\==(C2,C5),
	\==(C3,C4),
	\==(C3,C5),
	\==(C4,C5).

% Test:
% ?-est_main(M).
% 5 parmis 52 resultats = beaucoup


% ==============================================================================
%       QUESTION 3 : inf_carte(C1,C2) première version
% ============================================================================= 
inf_hauteur(H1,H2):-
	succ_hauteur(H1,H2).
inf_hauteur(H1,H2):-
	succ_hauteur(H1,X),
	inf_hauteur(X,H2).

inf_couleur(C1,C2):-
	succ_couleur(C1,C2).
inf_couleur(C1,C2):-
	succ_couleur(C1,X),
	inf_couleur(X,C2).

inf_carte(carte(H1,_),carte(H2,_)):-
	inf_hauteur(H1,H2).
inf_carte(carte(H,C1),carte(H,C2)):-
	inf_couleur(C1,C2).



% ============================================================================= 
%       QUESTION 3 : inf_carte_b(C1,C2) deuxième version
% ==============================================================================



% ==============================================================================
%       QUESTION 4 : est_main_triee(main(C1,C2,C3,C4,C5))
% ==============================================================================
est_main_triee(main(C1,C2,C3,C4,C5)):-
	est_main(C1,C2,C3,C4,C5),
	inf_carte(C1,C2),
	inf_carte(C2,C3),
	inf_carte(C3,C4),
	inf_carte(C4,C5).



% ==============================================================================
%       QUESTION 5 : une_paire(main(C1,C2,C3,C4,C5))
% ==============================================================================
une_paire(main(carte(H,_),carte(H,_),_,_,_)).
une_paire(main(_,carte(H,_),carte(H,_),_,_)).
une_paire(main(_,_,carte(H,_),carte(H,_),_)).
une_paire(main(_,_,_,carte(H,_),carte(H,_))).


 
% ==============================================================================
%       QUESTION 6 : deux_paires(main(C1,C2,C3,C4,C5))
% ==============================================================================
deux_paires(main(carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_),_)):-
	\==(H1,H2).
deux_paires(main(carte(H1,_),carte(H1,_),_,carte(H2,_),carte(H2,_))):-
	\==(H1,H2).
deux_paires(main(_,carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_))):-
	\==(H1,H2).


% ============================================================================= 
%       QUESTION 7 : brelan(main(C1,C2,C3,C4,C5))
% ============================================================================= 
brelan(main(carte(H,_),carte(H,_),carte(H,_),_,_)).
brelan(main(_,carte(H,_),carte(H,_),carte(H,_),_)).
brelan(main(_,_,carte(H,_),carte(H,_),carte(H,_))).



% ============================================================================= 
%       QUESTION 8 : suite(main(C1,C2,C3,C4,C5))
% ==============================================================================
suite(main(carte(H1,_),carte(H2,_),carte(H3,_),carte(H4,_),carte(H5,_))):-
	succ_hauteur(H1,H2),
	succ_hauteur(H2,H3),
	succ_hauteur(H3,H4),
	succ_hauteur(H4,H5).


% ============================================================================= 
%       QUESTION 9 : full(main(C1,C2,C3,C4,C5))
% ============================================================================= 
full(main(carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_),carte(H2,_))):-
	\==(H1,H2).
full(main(carte(H1,_),carte(H1,_),carte(H1,_),carte(H2,_),carte(H2,_))):-
	\==(H1,H2).




% ==============================================================================

/* TESTS QUESTION 1 : carte_test

[eclipse 2]: ?-est_carte(C).

C = carte(deux, trefle)
Yes (0.00s cpu, solution 1, maybe more) ? ;

C = carte(trois, trefle)
Yes (0.00s cpu, solution 2, maybe more) ? ;

...

C = carte(roi, pique)
Yes (0.00s cpu, solution 51, maybe more) ? ;

C = carte(as, pique)
Yes (0.00s cpu, solution 52)

*/

% ============================================================================= 

/*  TESTS QUESTION 2 : est_main

[eclipse 4]: ?-est_main(M).

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(cinq, trefle), carte(six, trefle))
Yes (0.00s cpu, solution 1, maybe more) ? ;

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(cinq, trefle), carte(sept, trefle))
Yes (0.00s cpu, solution 2, maybe more) ? ;

...

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(cinq, trefle), carte(deux, carreau))
Yes (0.01s cpu, solution 10, maybe more) ? ;

...

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(roi, trefle), carte(quatre, carreau))
Yes (0.04s cpu, solution 396, maybe more) ? ;

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(roi, trefle), carte(cinq, carreau))
Yes (0.04s cpu, solution 397, maybe more) ? 

etc...

*/

% ============================================================================= 

/* TESTS QUESTION 3 premiere version

[eclipse 5]: ?-inf_carte(carte(deux,coeur),carte(roi,trefle)).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 6]: ?-inf_carte(carte(roi, trefle),carte(dix,pique)).

No (0.00s cpu)

[eclipse 7]: ?-inf_carte(carte(roi,trefle),carte(roi,pique)).

Yes (0.00s cpu, solution 1, maybe more) ? 


*/

% ==============================================================================

/* TESTS QUESTION 3 deuxieme version

*/

% ==============================================================================

/* TESTS QUESTION 4

[eclipse 9]: ?-est_main_triee(main(carte(deux,trefle),carte(trois,coeur),carte(sept,trefle),carte(roi,trefle),carte(roi,pique))).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 10]: ?-est_main_triee(main(carte(deux,trefle),carte(trois,coeur),carte(sept,trefle),carte(roi,pique),carte(roi,trefle))).

No (0.00s cpu)


*/

% ============================================================================= 

/* TESTS QUESTION 5

[eclipse 11]: ?-une_paire(main(carte(deux,trefle),carte(deux,coeur),carte(trois,trefle),carte(quatre,coeur),carte(roi,coeur))).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 13]: ?-une_paire(main(carte(deux,trefle),carte(trois,trefle),carte(cinq,trefle),carte(sept,coeur),carte(roi,coeur))).

No (0.00s cpu)



*/

% ==============================================================================

/* TESTS QUESTION 6

[eclipse 15]: ?-deux_paires(main(carte(deux,trefle),carte(deux,coeur),carte(trois,trefle),carte(trois,coeur),carte(roi,coeur))).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 16]: ?-deux_paires(main(carte(deux,trefle),carte(deux,coeur),carte(trois,trefle),carte(quatre,coeur),carte(roi,coeur))).

No (0.00s cpu)

*/

% ==============================================================================


/* TESTS QUESTION 7
[eclipse 17]: ?-brelan(main(carte(deux,trefle),carte(deux,coeur),carte(deux,trefle),carte(trois,coeur),carte(roi,coeur))).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 18]: ?-brelan(main(carte(deux,trefle),carte(deux,coeur),carte(trois,trefle),carte(trois,coeur),carte(roi,coeur))).

No (0.00s cpu)


*/

% ==============================================================================

/* TESTS QUESTION 8

[eclipse 19]: ?-suite(main(carte(quatre,trefle),carte(cinq,coeur),carte(six,pique),carte(sept,carreau),carte(huit,pique))).

Yes (0.00s cpu)

[eclipse 20]: ?-suite(main(carte(quatre,trefle),carte(cinq,coeur),carte(six,pique),carte(sept,carreau),carte(dame,pique))).

No (0.00s cpu)


*/

% ============================================================================= 

/* TESTS QUESTION 9

[eclipse 21]: ?-full(main(carte(trois,pique),carte(trois,carreau),carte(roi,pique),carte(roi,trefle),carte(roi,carreau))).

Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 22]: ?-full(main(carte(trois,pique),carte(trois,carreau),carte(dame,pique),carte(roi,trefle),carte(roi,carreau))).

No (0.00s cpu)

*/
