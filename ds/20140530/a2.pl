ntimes([], 0, _).
ntimes([H|T], N, H):-
	!,
	NewN is N - 1,
	ntimes(T, NewN, H).
ntimes([_|T], N, E):-
	ntimes(T, N, E).

ntimes(L, N, E):-
	member(E, L).