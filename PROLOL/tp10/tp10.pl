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

people([abby, bess, cody, dana]).

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

proposition1([likes(dana, cody)|_]).
proposition1([likes(A, B)|R]):-
	\==(A, dana),
	\==(B, cody),
	proposition1(R).

/*
?-proposition1([likes(dana, cody)]).
?-proposition1([likes(cody, dana)]).
*/

proposition2([]).
proposition2([likes(A, B)|R]):-
	\==(A, bess),
	\==(B, dana),
	proposition2(R).

proposition3([]).
proposition3([likes(A, B)|R]):-
	\==(A, cody),
	\==(B, abby),
	proposition2(R).

proposition4([likes(A, B)|R]):-
	proposition4(R),
	proposition42(A, B, R).
proposition42(A, B, [likes(B, A)|R]):-
	proposition42(A, B, R).





% Questions 1.6 and 1.7
test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.