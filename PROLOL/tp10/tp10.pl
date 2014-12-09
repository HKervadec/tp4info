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
make_all_pairs([A, B], [likes(A, B), likes(B, A), likes(A, A), likes(B, B)]).
/* make_all_pairs([A,B|R], Res):-
	make_all_pairs([A, B], Res1),
	make_all_pairs([A|R], Res2),
	make_all_pairs([B|R], Res3),
	append(Res1, Res2, Res4),
	append(Res3, Res4, Res). */

/*
[eclipse 13]: ?-make_all_pairs([1, 2], Res).
	Res = [likes(1, 2), likes(2, 1), likes(1, 1), likes(2, 2)]
	Yes (0.00s cpu)
*/

% =======================================
% Q 1.2
% =====

sub_list(_, []).
sub_list([], []).

sub_list(L, L).
sub_list([A|_], [A]).
sub_list([_|L], L).
sub_list([A|[B|_]], R):-
	sub_list([A,B], R).
sub_list([A|[_|L]], R):-
	sub_list([A|L], R).





/*
sub_list(L, L).
sub_list([_|B], R):-
	sub_list(B, R).
sub_list([_, B, _], [B]).
sub_list([_, C], [C]).
sub_list([_, B, C], [B, C]).
sub_list([A, _, C], [A, C]).
sub_list([A, B, _], [A, B]).
*/


/*
[eclipse 29]: ?-sub_list([1, 2], Res).
	Res = [1, 2]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	Res = [2]
	Yes (0.00s cpu, solution 2, maybe more) ? ;

	Res = [1]
	Yes (0.00s cpu, solution 3, maybe more) ? ;

	Res = []
	Yes (0.00s cpu, solution 4)

?-sub_list([1, 2, 3], Res).




*/


% =======================================
% Q 1.2
% =====



% Questions 1.6 and 1.7
test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.