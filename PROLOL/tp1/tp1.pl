/* 1.1 */

?-hors_d_oeuvre(X).
?-viande(X).
?-poisson(X).
?-dessert(X).
?-calories(X,Y).


/* 1.2 */

plat(X):-
	viande(X);
	poisson(X).
repas(H,P,D):-
	hors_d_oeuvre(H),
	plat(P),
	dessert(D).
petit_plat(X):-
	calories(X,C),
	C > 200,
	C < 400.
plus_gros(P):-
	calories(P,C1),
	calories(bar_aux_algues,C2),
	C1 > C2.
valeur(H,P,D,V):-
	calories(H,C1),
	calories(P,C2),
	calories(D,C3),
	V is C1 + C2 + C3.
equilibre(H,P,D):-
	valeur(H,P,D,V),
	V < 800.

/* 1.3 */

/* 2.1 */
enfant(E,P):-
	pere(P,E);
	mere(P,E).
parent(P,E):-
	pere(P,E);
	mere(P,E).
grand_pere(G,E):-
	pere(G,X),
	parent(X,E).
frere(F,E):-
	homme(F),
	parent(P,F),
	parent(P,E),
	/==(F,E).
oncle(O,N):-
	homme(O),
	parent(P,N),
	frere(O,N).
cousin(C,E):-
	homme(C),
	parent(P1,C),
	parent(P2,E),
	parent(P3,P1),
	parent(P3,P2).
le_roi_est_mort_vive_le_roi(R1,D,R2):-
	roi(R1,T1,T2,D),
	roi(R2,T3,D,T4).

/* 2.2 */
ancetre(X,Y):-
	parent(X,Y).
ancetre(X,Y):-
	parent(X,Z),
	ancentre(Z,Y).










		
