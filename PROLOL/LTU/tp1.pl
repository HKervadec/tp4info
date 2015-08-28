/* Valid list for stuff left alone */
valid([]).
valid([_]).
valid([wolf, cabbage]).
valid([cabbage, wolf]).


/* finished */
solvefgb([b], _, _, []).

/* move stuff */
solvefgb([a|L], D, N, [I|R]):-
	\==(N, 0),
	M is N - 1,
	chooseone(L, I, L1),
	valid(L1),
	append(I, D, ND),
	solvefgb([b|L1], ND, M, R).

solvefgb([b|L], D, N, [I|R]):-
	\==(N, 0),
	M is N - 1,
	chooseone(D, I, D1),
	valid(D1),
	append(I, L, NL),
	solvefgb([a|NL], D1, M, R).

/* Pick something (or not) to move, and create a list with the remaining stuff */
chooseone([], [], []).
chooseone([A|R], [A], R).
chooseone([A|R], X, [A|Y]):-
	chooseone(R, X, Y).


/*
?-solvefgb([a, wolf, cabbage, sheep], [], 6, T).
*/