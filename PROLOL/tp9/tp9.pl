/**
TP 9 Prolog

@author Hoel KERVADEC
@version Annee scolaire 2014/2015
*/


% =======================================
% Q 1.1
% =====

combiner([],[]).
combiner([F|R], Res):-
	combiner2(F, R, B),
	combiner(R, L),
	append(B, L, Res).

combiner2(_, [], []).
combiner2(A, [F|R], [(A,F)|L]):-
	combiner2(A, R, L).


/* 
[eclipse 31]: ?-combiner([pluto, riri, fifi, loulou], B).
	B = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
	Yes (0.00s cpu)
*/

% =======================================
% Q 1.2
% =====

extraire(B, 0, [], B).
extraire([B|L], N, [B|Ltp], RB):-
	remove(B, L, NL, Discard),
	M is N - 1,
	extraire(NL, M, Ltp, Lrb),
	append(Discard, Lrb, RB).

remove(_, [], [], []).
remove((B1, B2), [(B1,L2)|R], NL, [(B1,L2)|D]):-
	remove((B1, B2), R, NL, D).
remove((B1, B2), [(L1,B1)|R], NL, [(L1,B1)|D]):-
	remove((B1, B2), R, NL, D).
remove((B1, B2), [(B2,L2)|R], NL, [(B2,L2)|D]):-
	remove((B1, B2), R, NL, D).
remove((B1, B2), [(L1,B2)|R], NL, [(L1,B2)|D]):-
	remove((B1, B2), R, NL, D).
remove((B1, B2), [(L1,L2)|R], [(L1,L2)|NR], D):-
	\==(B1,L1),
	\==(B1,L2),
	\==(B2,L1),
	\==(B2,L2),
	remove((B1, B2), R, NR, D).
	

/* 
[eclipse 62]: ?-combiner([pluto, riri, fifi, loulou], B),remove((pluto, riri), B, R, D).
	B = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
	R = [(fifi, loulou)]
	D = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou)]
	Yes (0.00s cpu, solution 1, maybe more) ? ;


[eclipse 67]: ?-combiner([pluto, riri, fifi, loulou], B),extraire(B, 0, Tp, R).
	B = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
	Tp = []
	R = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)


[eclipse 64]: ?-combiner([pluto, riri, fifi, loulou], B),extraire(B, 2, Tp, R).
	B = [(pluto, riri), (pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou), (fifi, loulou)]
	Tp = [(pluto, riri), (fifi, loulou)]
	R = [(pluto, fifi), (pluto, loulou), (riri, fifi), (riri, loulou)]
*/

% =======================================
% Q 1.3
% =====

les_tps([], []).
les_tps(P, Res):-
	combiner(P, B),
	length(B, N),
	M is div(N, 2),
	les_tps2(B, M, Res).

les_tps2([], _, []).
les_tps2(B, N, [Tp|R]):-
	extraire(B, N, Tp, Rest),
	les_tps2(Rest, N, R).

/*

[eclipse 78]: ?-les_tps([pluto, riri, fifi, loulou], Tps).
	Tps = [[(pluto, riri), (fifi, loulou)], 
		   [(pluto, fifi), (riri, loulou)], 
		   [(pluto, loulou), (riri, fifi)]]
	Yes (0.00s cpu, solution 1, maybe more) ? ;

	No (0.00s cpu)
*/