/* finished */
solvefgb([b], _, _, []).

/* Valid list for alone */
valid([]).
valid([_]).
valid([wolf, cabbage]).
valid([cabbage, wolf]).



solvefgb([a|L], D, N, [I|R]):-
	\==(N, 0),
	M is N - 1,
	chooseone(L, I, L1),
	valid(L1),
	conc(I, D, ND),
	solvefgb([b|L1], ND, M, R).

solvefgb([b|L], D, N, [I|R]):-
	\==(N, 0),
	M is N - 1,
	chooseone(D, I, D1),
	valid(D1),
	conc(I, L, NL),
	solvefgb([a|NL], D1, M, R).


chooseone([], [], []).
chooseone([a|R], [a], R).
chooseone([a|R], X, [a|Y]):-
	chooseone(R, X, Y).