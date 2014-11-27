/**
TP 8 Traitement Automatique de la Langue (TAL) - Prolog

@author Hoel KERVADEC
@version Annee scolaire 2014/2015
*/


/*
===============================================================================
===============================================================================
 Définition des prédicats
===============================================================================
*/
% Afin de simplifier la correction,  merci de conserver dans votre grammaire
% l'ordre ci-dessous
 
% =======================================
% Q 1.1
% =====
/*
phrase_simple: gp_nominal gp_verbal |
			   gp_nominal gp_verbal gp_prepositionnel

gp_nominal: article gp_nomadj |
			article gp_nomadj relatif |
			nom_propre |
			nom_propre relatif

gp_nomadj: nom_commun |
		   adjectif nom_commun |
		   adjectif nom_commun adjectif |
		   nom_commun adjectif

gp_verbal: verbe |
		   verbe gp_nominal

gp_prepositionnel: prep gp_nominal |
				   prep gp_verbal

relatif: pronom gp_verbal


article: "le" | "la" | "les" | "un"

nom_commun: "chien" | "enfants" | "rue" | "femme" | "pull" | "steack"

nom_propre: "paul"

adjectif: "noir"

prep: "dans"

verbe: "aboie" | "jouent" | "marche" | "porte" | "mange"

pronom: "qui"
*/


% =======================================
% Q 2.1
% =====
analyse(X):-
	phrase_simple(X, []).


phrase_simple(L, R):-
	gp_nominal(L, L1), 
	gp_verbal(L1, R).
phrase_simple(L, R):-
	gp_nominal(L, L1), 
	gp_verbal(L1, L2), 
	gp_prepositionnel(L2, R).


gp_nominal(L, R):-
	article(L, L1), 
	gp_nomadj(L1, R).
gp_nominal(L, R):-
	article(L, L1), 
	gp_nomadj(L1, L2), 
	relatif(L2, R).
gp_nominal(L, R):-
	nom_propre(L, R).
gp_nominal(L, R):-
	nom_propre(L, L1), 
	relatif(L1, R).

gp_nomadj(L, R):-
	nom_commun(L, R).
gp_nomadj(L, R):-
	adjectif(L, L1), 
	nom_commun(L1, R).
gp_nomadj(L, R):-
	adjectif(L, L1), 
	nom_commun(L1, L2), 
	adjectif(L2, R).
gp_nomadj(L, R):-
	nom_commun(L, L1), 
	adjectif(L1, R).

gp_verbal(L, R):-
	verbe(L, R).
gp_verbal(L, R):-
	verbe(L, L1), 
	gp_nominal(L1, R).

gp_prepositionnel(L, R):-
	prep(L, L1), 
	gp_nominal(L1, R).
gp_prepositionnel(L, R):-
	prep(L, L1), 
	gp_verbal(L1, R).


relatif(L, R):-
	pronom(L, L1), 
	gp_verbal(L1, R).


article([le|L], L).
article([la|L], L).
article([les|L], L).
article([un|L], L).

nom_commun([chien|L], L).
nom_commun([enfants|L], L).
nom_commun([rue|L], L).
nom_commun([femme|L], L).
nom_commun([pull|L], L).
nom_commun([steack|L], L).

nom_propre([paul|L], L).

adjectif([noir|L], L).

prep([dans|L], L).

verbe([aboie|L], L).
verbe([jouent|L], L).
verbe([marche|L], L).
verbe([porte|L], L).
verbe([mange|L], L).

pronom([qui|L], L).

% =======================================
% Q 2.2
% =====
analyse2(X, A):-
	phrase_simple2(X, [], A).


phrase_simple2(L, R, phr(A1, A2)):-
	gp_nominal2(L, L1, A1), 
	gp_verbal2(L1, R, A2).
phrase_simple2(L, R, phr(A1, A2, A3)):-
	gp_nominal2(L, L1, A1), 
	gp_verbal2(L1, L2, A2), 
	gp_prepositionnel2(L2, R, A3).


gp_nominal2(L, R, gn(A1, A2)):-
	article2(L, L1, A1), 
	gp_nomadj2(L1, R, A2),
gp_nominal2(L, R, gn(A1, A2, A3)):-
	article2(L, L1, A1), 
	gp_nomadj2(L1, L2, A2), 
	relatif2(L2, R, A3),
gp_nominal2(L, R, gn(A1)):-
	nom_propre2(L, R, A1).
gp_nominal2(L, R, gn(A1, A2)):-
	nom_propre2(L, L1, A1), 
	relatif2(L1, R, A2).

gp_nomadj2(L, R, gna(A1)):-
	nom_commun2(L, R, A1).
gp_nomadj2(L, R, gna(A1, A2)):-
	adjectif2(L, L1, A1), 
	nom_commun2(L1, R, A2).
gp_nomadj2(L, R, gna(A1,A2,A3)):-
	adjectif2(L, L1, A1), 
	nom_commun2(L1, L2, A2), 
	adjectif2(L2, R, A3).
gp_nomadj2(L, R, gna(A1, A2)):-
	nom_commun2(L, L1, A1), 
	adjectif2(L1, R, A2).

gp_verbal2(L, R, gv(A1)):-
	verbe2(L, R, A1).
gp_verbal2(L, R, gv(A1, A2)):-
	verbe2(L, L1, A1), 
	gp_nominal2(L1, R, A2).

gp_prepositionnel2(L, R, gp(A1, A2)):-
	prep2(L, L1, A1), 
	gp_nominal2(L1, R, A2).
gp_prepositionnel2(L, R, gp(A1, A2)):-
	prep2(L, L1, A1), 
	gp_verbal2(L1, R, A2).


relatif2(L, R, rel(A1, A2)):-
	pronom2(L, L1, A1), 
	gp_verbal2(L1, R, A2).


article2([le|L], L, art(le)).
article2([la|L], L, art(la)).
article2([les|L], L, art(les)).
article2([un|L], L, art(un)).

nom_commun2([chien|L], L, nom_com(chien)).
nom_commun2([enfants|L], L, nom_com(enfants)).
nom_commun2([rue|L], L, nom_com(rue)).
nom_commun2([femme|L], L, nom_com(femme)).
nom_commun2([pull|L], L, nom_com(pull)).
nom_commun2([steack|L], L, nom_com(steack)).

nom_propre2([paul|L], L, nom_pro(paul)).

adjectif2([noir|L], L, adj(noir)).

prep2([dans|L], L, prep(dans)).

verbe2([aboie|L], L, verb(aboie)).
verbe2([jouent|L], L, verb(jouent)).
verbe2([marche|L], L, verb(marche)).
verbe2([porte|L], L, verb(porte)).
verbe2([mange|L], L, verb(mange)).

pronom2([qui|L], L, pronom(qui)).

% =======================================
% Q 2.3
% =====
analyse3(X, A):-
	phrase_simple3(X, [], A).


phrase_simple3(L, R, phr(A1, A2)):-
	gp_nominal3(L, L1, A1), 
	gp_verbal3(L1, R, A2).
phrase_simple3(L, R, phr(A1, A2, A3)):-
	gp_nominal3(L, L1, A1), 
	gp_verbal3(L1, L2, A2), 
	gp_prepositionnel3(L2, R, A3).


gp_nominal3(L, R, gn(A1, A2)):-
	article3(L, L1, A1), 
	gp_nomadj3(L1, R, A2),
	check_genre(L,L1).
gp_nominal3(L, R, gn(A1, A2, A3)):-
	article3(L, L1, A1), 
	gp_nomadj3(L1, L2, A2), 
	relatif3(L2, R, A3),
	check_genre(L,L1).
gp_nominal3(L, R, gn(A1)):-
	nom_propre3(L, R, A1).
gp_nominal3(L, R, gn(A1, A2)):-
	nom_propre3(L, L1, A1), 
	relatif3(L1, R, A2).

gp_nomadj3(L, R, gna(A1)):-
	nom_commun3(L, R, A1).
gp_nomadj3(L, R, gna(A1, A2)):-
	adjectif3(L, L1, A1), 
	nom_commun3(L1, R, A2).
gp_nomadj3(L, R, gna(A1,A2,A3)):-
	adjectif3(L, L1, A1), 
	nom_commun3(L1, L2, A2), 
	adjectif3(L2, R, A3).
gp_nomadj3(L, R, gna(A1, A2)):-
	nom_commun3(L, L1, A1), 
	adjectif3(L1, R, A2).

gp_verbal3(L, R, gv(A1)):-
	verbe3(L, R, A1).
gp_verbal3(L, R, gv(A1, A2)):-
	verbe3(L, L1, A1), 
	gp_nominal3(L1, R, A2).

gp_prepositionnel3(L, R, gp(A1, A2)):-
	prep3(L, L1, A1), 
	gp_nominal3(L1, R, A2).
gp_prepositionnel3(L, R, gp(A1, A2)):-
	prep3(L, L1, A1), 
	gp_verbal3(L1, R, A2).


relatif3(L, R, rel(A1, A2)):-
	pronom3(L, L1, A1), 
	gp_verbal3(L1, R, A2).


article3([le|L], L, art(le)).
article3([la|L], L, art(la)).
article3([les|L], L, art(les)).
article3([un|L], L, art(un)).

check_genre(le, chien).
check_genre(les, enfants).
check_genre(la, rue).
check_genre(la, femme).
check_genre(le, pull).
check_genre(le, steack).

nom_commun3([chien|L], L, nom_com(chien)).
nom_commun3([enfants|L], L, nom_com(enfants)).
nom_commun3([rue|L], L, nom_com(rue)).
nom_commun3([femme|L], L, nom_com(femme)).
nom_commun3([pull|L], L, nom_com(pull)).
nom_commun3([steack|L], L, nom_com(steack)).

nom_propre3([paul|L], L, nom_pro(paul)).

adjectif3([noir|L], L, adj(noir)).

prep3([dans|L], L, prep(dans)).

verbe3([aboie|L], L, verb(aboie)).
verbe3([jouent|L], L, verb(jouent)).
verbe3([marche|L], L, verb(marche)).
verbe3([porte|L], L, verb(porte)).
verbe3([mange|L], L, verb(mange)).

pronom3([qui|L], L, pronom(qui)).

        
/*
===============================================================================
===============================================================================
 Tests
===============================================================================
*/



/*
% n'hésitez pas à en définir d'autres
% Quelques phrases de test à copier coller pour vous faire gagner du temps,  mais
analyse([le, chien, aboie]).
analyse([les, enfants, jouent]).
analyse([paul, marche, dans, la, rue]).
analyse([la, femme, qui, porte, un, pull, noir, mange, un, steack]).
analyse([les, chien, aboie]).
analyse([la, femme, qui, porte, un, pull, noir, mange, un, chien]).

% =======================================
% Q 2.1
% =====
[eclipse 20]: analyse([le, chien, aboie]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 21]: analyse([les, enfants, jouent]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 22]: analyse([paul, marche, dans, la, rue]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 23]: analyse([la, femme, qui, porte, un, pull, noir, mange, un, steack]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 24]: analyse([les, chien, aboie]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 25]: analyse([la, femme, qui, porte, un, pull, noir, mange, un, chien]).
Yes (0.00s cpu,  solution 1,  maybe more) ? ;
No (0.00s cpu)

[eclipse 27]: ?-analyse(X).

X = [le,  chien,  aboie]
Yes (0.00s cpu,  solution 1,  maybe more) ? ;

....

X = [le,  chien,  aboie,  le,  noir,  chien]
Yes (0.00s cpu,  solution 12,  maybe more) ? 

% =======================================
% Q 2.2
% =====
[eclipse 31]: analyse2([paul,qui,porte,un,pull,noir,mange,un,steack],R).

R = phr(gn(nom_pro(paul), rel(pronom(qui), gv(verb(porte), gn(art(un), gna(nom_com(pull), adj(noir)))))), gv(verb(mange), gn(art(un), gna(nom_com(steack)))))

Yes (0.00s cpu, solution 1, maybe more) ? ;
No (0.01s cpu)

% =======================================
% Q 2.2
% =====
[eclipse 38]: analyse3([les, chien, aboie], R).

No (0.00s cpu)



*/
