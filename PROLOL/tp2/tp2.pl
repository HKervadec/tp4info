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

% Test:
% ?-est_carte(C).
% Obtient 52 resultats.

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

% Test
% > ?-inf_hauteur(carte(deux,trefle),carte(trois,trefle)).
% YES
% > ?-inf_hauteur(carte(deux,coeur),carte(neuf,carreau)).
% YES
% > ?-inf_hauteur(carte(quatre,carreau),carte(deux,trefle)).
% NO

inf_couleur(C1,C2):-
	succ_couleur(C1,C2).
inf_couleur(C1,C2):-
	succ_couleur(C1,X),
	inf_couleur(X,C2).

% Test
% > ?-inf_couleur(carte(deux,trefle),carte(deux,pique)).

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


*/

% ============================================================================= 

/*  TESTS QUESTION 2 : est_main



*/

% ============================================================================= 

/* TESTS QUESTION 3 premiere version

*/

% ==============================================================================

/* TESTS QUESTION 3 deuxieme version

*/

% ==============================================================================

/* TESTS QUESTION 4


*/

% ============================================================================= 

/* TESTS QUESTION 5


*/

% ==============================================================================

/* TESTS QUESTION 6


*/

% ==============================================================================


/* TESTS QUESTION 7


*/

% ==============================================================================

/* TESTS QUESTION 8


*/

% ============================================================================= 

/* TESTS QUESTION 9


*/
