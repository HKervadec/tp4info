/**
TP Listes Prolog

@author Hoel KERVADEC
@version Annee scolaire 2014/2015
*/

/* Listes */
liste1([1,2,3,4,5,6,7,8,9]).
liste2([1,2,3,4,4,6,7,1]).
liste3([1,2,3,4,3,2,1]).
liste4([1,2,3,4,4,3,2,1]).
liste5([1,2,3]).
liste6([4,4]).

/* Q 1.1 */
membre(E,[E|_]).
membre(E,[_|R]):-
	membre(E,R).
	
/*
[eclipse 10]: ?-liste1(X),membre(1,X).
  (1) 1 CALL  liste1(X)   %> creep
  (1) 1 EXIT  liste1([1, 2, 3, ...])   %> creep
  (2) 1 CALL  membre(1, [1, 2, 3, ...])   %> creep
  (2) 1 *EXIT  membre(1, [1, 2, 3, ...])   %> creep

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 11]: ?-liste1(X),membre(5,liste1).
  (1) 1 CALL  liste1(X)   %> creep
  (1) 1 EXIT  liste1([1, 2, 3, ...])   %> creep
  (2) 1 CALL  membre(5, liste1)   %> creep
  (2) 1 NEXT  membre(5, liste1)   %> creep
  (2) 1 FAIL  membre(..., ...)   %> creep

No (0.00s cpu)
 */


/* Q 1.2 */
compte(_,[],0).
compte(X,[X|R],N1):-
	compte(X,R,N),
	N1 is N + 1.
compte(X,[A|R],N):-
	\==(A,X),
	compte(X,R,N).

/* [eclipse 27]: ?-liste2(X),compte(4,X,N).
  (1) 1 CALL  liste2(X)   %> creep
  (1) 1 EXIT  liste2([1, 2, 3, ...])   %> creep
  (2) 1 CALL  compte(4, [1, 2, 3, ...], N)   %> creep
  (2) 1 NEXT  compte(4, [1, 2, 3, ...], N)   %> creep
  (3) 2 CALL  1 \== 4   %> creep
  (3) 2 EXIT  1 \== 4   %> creep
  (4) 2 CALL  compte(4, [2, 3, 4, ...], N)   %> creep
  (4) 2 NEXT  compte(4, [2, 3, 4, ...], N)   %> creep
  (5) 3 CALL  2 \== 4   %> creep
  (5) 3 EXIT  2 \== 4   %> creep
  (6) 3 CALL  compte(4, [3, 4, 4, ...], N)   %> creep
  (6) 3 NEXT  compte(4, [3, 4, 4, ...], N)   %> creep
  (7) 4 CALL  3 \== 4   %> creep
  (7) 4 EXIT  3 \== 4   %> creep
  (8) 4 CALL  compte(4, [4, 4, 6, ...], N)   %> creep
  (9) 5 CALL  compte(4, [4, 6, 7, ...], _1230)   %> creep
  (10) 6 CALL  compte(4, [6, 7, 1], _1318)   %> creep
  (10) 6 NEXT  compte(4, [6, 7, 1], _1318)   %> creep
  (11) 7 CALL  6 \== 4   %> creep
  (11) 7 EXIT  6 \== 4   %> creep
  (12) 7 CALL  compte(4, [7, 1], _1318)   %> creep
  (12) 7 NEXT  compte(4, [7, 1], _1318)   %> creep
  (13) 8 CALL  7 \== 4   %> creep
  (13) 8 EXIT  7 \== 4   %> creep
  (14) 8 CALL  compte(4, [1], _1318)   %> creep
  (14) 8 NEXT  compte(4, [1], _1318)   %> creep
  (15) 9 CALL  1 \== 4   %> creep
  (15) 9 EXIT  1 \== 4   %> creep
  (16) 9 CALL  compte(4, [], _1318)   %> creep
  (16) 9 EXIT  compte(4, [], 0)   %> creep
  (14) 8 EXIT  compte(4, [1], 0)   %> creep
  (12) 7 EXIT  compte(4, [7, 1], 0)   %> creep
  (10) 6 EXIT  compte(4, [6, 7, 1], 0)   %> creep
  (17) 6 CALL  +(0, 1, ...)   %> creep
  (17) 6 EXIT  +(0, 1, 1)   %> creep
  (9) 5 *EXIT  compte(4, [4, 6, 7, ...], 1)   %> creep
  (18) 5 CALL  +(1, 1, ...)   %> creep
  (18) 5 EXIT  +(1, 1, 2)   %> creep
  (8) 4 *EXIT  compte(4, [4, 4, 6, ...], 2)   %> creep
  (6) 3 *EXIT  compte(4, [3, 4, 4, ...], 2)   %> creep
  (4) 2 *EXIT  compte(4, [2, 3, 4, ...], 2)   %> creep
  (2) 1 *EXIT  compte(4, [1, 2, 3, ...], 2)   %> creep

X = [1, 2, 3, 4, 4, 6, 7, 1]
N = 2
Yes (0.00s cpu, solution 1, maybe more) ? 

[eclipse 28]: ?-liste2(X),compte(9,X,N).
  (1) 1 CALL  liste2(X)   %> creep
  (1) 1 EXIT  liste2([1, 2, 3, ...])   %> creep
  (2) 1 CALL  compte(9, [1, 2, 3, ...], N)   %> creep
  (2) 1 NEXT  compte(9, [1, 2, 3, ...], N)   %> creep
  (3) 2 CALL  1 \== 9   %> creep
  (3) 2 EXIT  1 \== 9   %> creep
  (4) 2 CALL  compte(9, [2, 3, 4, ...], N)   %> creep
  (4) 2 NEXT  compte(9, [2, 3, 4, ...], N)   %> creep
  (5) 3 CALL  2 \== 9   %> creep
  (5) 3 EXIT  2 \== 9   %> creep
  (6) 3 CALL  compte(9, [3, 4, 4, ...], N)   %> creep
  (6) 3 NEXT  compte(9, [3, 4, 4, ...], N)   %> creep
  (7) 4 CALL  3 \== 9   %> creep
  (7) 4 EXIT  3 \== 9   %> creep
  (8) 4 CALL  compte(9, [4, 4, 6, ...], N)   %> creep
  (8) 4 NEXT  compte(9, [4, 4, 6, ...], N)   %> creep
  (9) 5 CALL  4 \== 9   %> creep
  (9) 5 EXIT  4 \== 9   %> creep
  (10) 5 CALL  compte(9, [4, 6, 7, ...], N)   %> creep
  (10) 5 NEXT  compte(9, [4, 6, 7, ...], N)   %> creep
  (11) 6 CALL  4 \== 9   %> creep
  (11) 6 EXIT  4 \== 9   %> creep
  (12) 6 CALL  compte(9, [6, 7, 1], N)   %> creep
  (12) 6 NEXT  compte(9, [6, 7, 1], N)   %> creep
  (13) 7 CALL  6 \== 9   %> creep
  (13) 7 EXIT  6 \== 9   %> creep
  (14) 7 CALL  compte(9, [7, 1], N)   %> creep
  (14) 7 NEXT  compte(9, [7, 1], N)   %> creep
  (15) 8 CALL  7 \== 9   %> creep
  (15) 8 EXIT  7 \== 9   %> creep
  (16) 8 CALL  compte(9, [1], N)   %> creep
  (16) 8 NEXT  compte(9, [1], N)   %> creep
  (17) 9 CALL  1 \== 9   %> creep
  (17) 9 EXIT  1 \== 9   %> creep
  (18) 9 CALL  compte(9, [], N)   %> creep
  (18) 9 EXIT  compte(9, [], 0)   %> creep
  (16) 8 EXIT  compte(9, [1], 0)   %> creep
  (14) 7 EXIT  compte(9, [7, 1], 0)   %> creep
  (12) 6 EXIT  compte(9, [6, 7, 1], 0)   %> creep
  (10) 5 EXIT  compte(9, [4, 6, 7, ...], 0)   %> creep
  (8) 4 EXIT  compte(9, [4, 4, 6, ...], 0)   %> creep
  (6) 3 EXIT  compte(9, [3, 4, 4, ...], 0)   %> creep
  (4) 2 EXIT  compte(9, [2, 3, 4, ...], 0)   %> creep
  (2) 1 EXIT  compte(9, [1, 2, 3, ...], 0)   %> creep

X = [1, 2, 3, 4, 4, 6, 7, 1]
N = 0
*/

/* Q 1.3 */
renverser_c([],[]).
renverser_c([A|R],[L2|A]):-
	renverser_c(R,L2).

renverser(L,R):-renverser_2(L,[],R).

renverser_2([],R,R).
renverser_2([A|D],L2,R):-
	renverser_2(D,[A|L2],R).



/*
[eclipse 48]: ?-liste2(X),renverser(X,R).

X = [1, 2, 3, 4, 4, 6, 7, 1]
R = [1, 7, 6, 4, 4, 3, 2, 1]
Yes (0.00s cpu)

*/


/* Q 1.4 */
% Does not work.
palind([]).
palind([_]).
palind([A,R,A]):-
	palind(R).

palind_2(X):-renverser(X,X).

/* [eclipse 60]: ?-liste3(X),palind_2(X).

X = [1, 2, 3, 4, 3, 2, 1]
Yes (0.00s cpu)
[eclipse 61]: ?-liste2(X),palind_2(X).

No (0.00s cpu)
 */


/* Q 1.5 */
nieme(0,[A|_],A).
nieme(N,[_|R],A):-
	\==(N,0),
	nieme(N1,R,A),
	N is N1 + 1.


/* [eclipse 20]: ?-liste1(X),nieme(0,X,A).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
A = 1
Yes (0.00s cpu, solution 1, maybe more) ? 
[eclipse 21]: ?-liste1(X),nieme(4,X,A).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
A = 5
Yes (0.00s cpu, solution 1, maybe more) ? 
[eclipse 22]: ?-liste1(X),nieme(30,X,A).

No (0.00s cpu)*/


/* Q 1.6 */
hors_de(_,[]).
hors_de(A,[C|R]):-
	\==(A,C),
	hors_de(A,R).

/* [eclipse 25]: ?-liste1(X),hors_de(1,X).

No (0.00s cpu)
[eclipse 26]: ?-liste1(X),hors_de(10,X).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Yes (0.00s cpu)
*/

/* Q 1.7 */
tous_diff([]).
tous_diff([C|R]):-
	tous_diff(R),
	hors_de(C,R).

/* [eclipse 30]: ?-liste1(X),tous_diff(X).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Yes (0.00s cpu)
[eclipse 31]: ?-liste3(X),tous_diff(X).

No (0.00s cpu)
 */



/* Q 1.8 */

conc3([],[],Z,Z).
conc3([],[C|R],Z,[C|T]) :- conc3([],R,Z,T).
conc3([C|R],Y,Z,[C|T]) :- conc3(R,Y,Z,T).


/* 
[eclipse 4]: ?-liste1(X),liste2(Y),liste3(Z),conc3(X,Y,Z,T).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Y = [1, 2, 3, 4, 4, 6, 7, 1]
Z = [1, 2, 3, 4, 3, 2, 1]
T = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4, 4, 6, 7, 1, 1, 2, ...]
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)
*/


/* Q 1.9 */
debute_par(_,[]).
debute_par([A|R1],[A|R2]):-
	debute_par(R1,R2).

/* 
[eclipse 15]: ?-liste2(X),liste5(Y),debute_par(X,Y).

X = [1, 2, 3, 4, 4, 6, 7, 1]
Y = [1, 2, 3]
Yes (0.00s cpu)
[eclipse 16]: ?-liste1(X),liste2(Y),debute_par(X,Y).

No (0.00s cpu)
*/



/* Q 1.10 */
sous_liste(X,Y):-
	debute_par(X,Y).
sous_liste([_|R],Y):-
	sous_liste(R,Y).


/* [eclipse 18]: ?-liste1(X),liste5(Y),sous_liste(X,Y).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Y = [1, 2, 3]
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)
[eclipse 19]: ?-liste2(X),liste6(Y),sous_liste(X,Y).

X = [1, 2, 3, 4, 4, 6, 7, 1]
Y = [4, 4]
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)

[eclipse 20]: ?-liste1(X),liste1(Y),sous_liste(X,Y).

X = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Y = [1, 2, 3, 4, 5, 6, 7, 8, 9]
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)
[eclipse 21]: ?-liste1(X),liste2(Y),sous_liste(X,Y).

No (0.00s cpu)*/


/* Q 1.11 */
elim(X,Y):-
	elim(X,[],Y).
elim([],Y,Y).
elim([C|R],Acc,Y):-
	hors_de(C,Acc),
	elim(R,[C|Acc],Y).
elim([C|R],Acc,Y):-
	membre(C,Acc),
	elim(R,Acc,Y).

/* [eclipse 2]: ?-liste4(X),elim(X,Y).

X = [1, 2, 3, 4, 4, 3, 2, 1]
Y = [4, 3, 2, 1]
Yes (0.00s cpu, solution 1, maybe more) ? ;

No (0.00s cpu)

*/

/* Q 1.12 */
inserer(E,[],[E]).
inserer(E,[Elem|Rest],[E,Elem|Rest]):-
	E=<Elem.
inserer(E,[Elem|Rest1],[Elem|L2]):-
	E>Elem,
	inserer(E,Rest1,L2).

















