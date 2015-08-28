close([_], [], 0).
close([], [_], 0).
close([], [], 0).

close([A|R1], [A|R2], V1):-
	close(R1, R2, V),
	V1 is V + 1.

close([A|R1], [B|R2], V):-
	\==(A, B),
	close(R1, R2, V).

test(N,M):-
	!,
	member(N,[1,2]),
	member(M,[3,4]).
testo(N,M,K,J):-
	test(N,M),
	!,
	test(K,J).