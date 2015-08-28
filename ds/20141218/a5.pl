picknumber(N, M):-
	picknumber(2, M, N).

picknumber(N, M, K):-
	N =< M,
	K = N.
picknumber(N, M, K):-
	N < M,
	N1 is N + 1,
	picknumber(N1, M, K).

bet(N, M, K) :- N =< M, K = N.
bet(N, M, K) :- N < M, N1 is N+1, bet(N1, M, K).