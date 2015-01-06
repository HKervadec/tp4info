/**
TP 10 Prolog

@author Hoel KERVADEC
@version Annee scolaire 2014/2015
*/

% dana likes cody
% bess does not like dana
% cody does not like abby
% nobody likes someone who does not like her
% abby likes everyone who likes bess
% dana likes everyone bess likes
% everybody likes somebody

people([abby, bess, cody, dana, peter]).

% =======================================
% Q 1.1
% =====

make_all_pairs([], []).
make_all_pairs([A|R], Res):-
	make_all_pairs2(A, R, Res1),
	make_all_pairs(R, Res2),
	append(Res1, Res2, Res).

make_all_pairs2(A, [], [likes(A, A)]).
make_all_pairs2(A, [B|R], Res):-
	combine(A, B, Res1),
	make_all_pairs2(A, R, Res2),
	append(Res1, Res2, Res).

combine(A, B, [likes(A, B), likes(B, A)]).

/*
[eclipse 19]: ?-make_all_pairs([1, 2], Res).
	Res = [likes(1, 2), likes(2, 1), likes(1, 1), likes(2, 2)]
	Yes (0.00s cpu)

[eclipse 20]: ?-make_all_pairs([1, 2, 3], Res).
	Res = [likes(1, 2), likes(2, 1), likes(1, 3), likes(3, 1), likes(1, 1), likes(2, 3), likes(3, 2), likes(2, 2), likes(3, 3)]
	Yes (0.00s cpu)

[eclipse 21]: ?-make_all_pairs([1, 2, 3, 4], Res),length(Res, T).
	Res = [likes(1, 2), likes(2, 1), likes(1, 3), likes(3, 1), likes(1, 4), likes(4, 1), likes(1, 1), likes(2, 3), likes(3, 2), likes(2, 4), likes(4, 2), likes(2, 2), likes(3, 4), likes(4, 3), likes(3, 3), likes(4, 4)]
	T = 16
	Yes (0.00s cpu)
*/

% =======================================
% Q 1.2
% =====

sub_list(L, R):-
	create_list(L, Res),
	enum(Res, R).

/*
[eclipse 54]: ?-sub_list([1, 2], Res).
	Res = [1, 2]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Res = [1]
	Yes (0.01s cpu, solution 2, maybe more) ? ;

	Res = [2]
	Yes (0.01s cpu, solution 3, maybe more) ? ;

	Res = []
	Yes (0.01s cpu, solution 4, maybe more) ? ;

	No (0.01s cpu)

[eclipse 55]: ?-sub_list([1, 2, 3], Res).
	Res = [2, 3]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Res = [2]
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	Res = [3]
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	Res = []
	Yes (0.00s cpu, solution 4, maybe more) ? ;

	Res = [1, 2, 3]
	Yes (0.00s cpu, solution 5, maybe more) ? ;

	Res = [1, 2]
	Yes (0.00s cpu, solution 6, maybe more) ? ;

	Res = [1, 3]
	Yes (0.00s cpu, solution 7, maybe more) ? ;

	Res = [1]
	Yes (0.00s cpu, solution 8, maybe more) ? ;

	No (0.00s cpu)
*/

create_list([A, B], [[A, B], [A], [B], []]).
create_list([A|R], Res):-
	create_list(R, Res1),
	add_truc(A, Res1, Res2),
	append(Res1, Res2, Res).

add_truc(_, [], []).
add_truc(A, [L|R], Res):-
	add_truc2(A, L, Res1),
	add_truc(A, R, Res2),
	append(Res1, Res2, Res).

add_truc2(A, L, [[A|L]]).

enum([L|_], L).
enum([_|R], Res):-
	enum(R, Res).

/* Tests fonctions auxiliaires 
[eclipse 51]: ?-create_list([1,2], R).
	R = [[1, 2], [1], [2], []]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)

[eclipse 52]: ?-create_list([1,2,3], R).
	R = [[2, 3], [2], [3], [], [1, 2, 3], [1, 2], [1, 3], [1]]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)

[eclipse 53]: ?-create_list([1,2,3,4], R).
	R = [[3, 4], [3], [4], [], [2, 3, 4], [2, 3], [2, 4], [2], [1, 3, 4], [1, 3], [1, 4], [1], [1, 2, 3, 4], [1, 2, 3], [1, 2, 4], [1, 2]]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)

[eclipse 44]: ?-add_truc(t, [[1,2],[2,3],[]], R).
	R = [[t, 1, 2], [t, 2, 3], [t]]
	Yes (0.00s cpu)

[eclipse 26]: ?-enum([[1],[2],[3]],R).
	R = [1]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	R = [2]
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	R = [3]
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	No (0.00s cpu)
*/



% =======================================
% Q 1.3
% =====

proposition1(LiekList) :-
	member(likes(dana,cody),LiekList).

proposition2(LiekList) :-
	not(member(likes(bess,dana),LiekList)).

proposition3(LiekList) :-
	not(member(likes(cody,abby),LiekList)).

proposition4(LiekList) :-
	prop4(LiekList,LiekList).

prop4([likes(X,Y)|Reste],LiekList) :-
	member(likes(Y,X),LiekList),
	prop4(Reste,LiekList).

prop4([],_).

proposition5(LiekList) :-
	prop5(LiekList,LiekList).

prop5([],_).

prop5([likes(X,bess)|Reste],LiekList) :-
	member(likes(abby,X),LiekList),
	prop5(Reste,LiekList).

prop5([likes(_,Y)|Reste],LiekList) :-
	\==(Y,bess),
	prop5(Reste,LiekList).

proposition6(LiekList) :-
	prop6(LiekList,LiekList).

prop6([],_).

prop6([likes(bess,X)|Reste],LiekList) :-
	member(likes(dana,X),LiekList),
	prop6(Reste,LiekList).

prop6([likes(Y,_)|Reste],LiekList) :-
	\==(Y,bess),
	prop6(Reste,LiekList).


proposition7(LiekList) :-
        people(ListePersonnes),
        prop7(ListePersonnes,LiekList).

prop7([],_).

prop7([Personne|RestePersonne],LiekList) :-
        member(likes(Personne,_),LiekList),
        prop7(RestePersonne,LiekList),
        !.

% =======================================
% Q 1.4
% =====

possible_worlds(World) :-
        people(ListePersonnes),
        make_all_pairs(ListePersonnes,ListePaires),
        sub_list(ListePaires,World),
        proposition1(World),
        proposition2(World),
        proposition3(World),
        proposition4(World),
        proposition5(World),
        proposition6(World),
        proposition7(World).

/* 
[eclipse 14]: possible_worlds(W).
	W = [likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(abby, abby), likes(cody, dana), likes(dana, cody), likes(cody, cody), likes(dana, dana)]
	Yes (0.04s cpu, solution 1, maybe more) ? ;

	W = [likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(abby, abby), likes(cody, dana), likes(dana, cody), likes(cody, cody)]
	Yes (0.04s cpu, solution 2, maybe more) ? ;

	W = [likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(abby, abby), likes(cody, dana), likes(dana, cody), likes(dana, dana)]
	Yes (0.04s cpu, solution 3, maybe more) ? ;

	W = [likes(abby, bess), likes(bess, abby), likes(abby, dana), likes(dana, abby), likes(abby, abby), likes(cody, dana), likes(dana, cody)]
	Yes (0.04s cpu, solution 4, maybe more) ? ;

	No (0.05s cpu)
*/



% Questions 1.6 and 1.7
test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.

/*
Changer litteraux: change rien (logique).


4 membres: 65 536 mondes testés (~ 2^(2^4))
5 membres: 33 554 432 mondes testés (~ 2^(2^5)))
*/