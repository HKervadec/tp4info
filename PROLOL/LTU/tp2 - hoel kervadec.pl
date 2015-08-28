x(a, 1).
x(b, 2).
x(c, 3).
x(d, 4).
x(e, 5).
x(f, 6).
x(g, 7).
x(h, 8).

opp(black, white).
opp(white, black).


/* legalmove(Color, Board, X, Y). */
/* Check if a move is legal */
/*
?-legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], c, 4).
?-legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], d, 3).
?-legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], f, 5).
?-legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], e, 6).

?-legalmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], X, Y).

legalmove(white,  [ (black, d, 3), (black, d, 4), (black, e, 4), (black, d, 5), (white, e, 5)], X, Y).
legalmove(white, [ (black, g, 7), (black, f, 6), (black, f, 5), (black, d, 4), (black, e, 4), (black, d, 5), (black, e, 5)], X, Y).
*/

legalmove(Color, B, X, Y):-
	val_x(X),
	val_y(Y),
	not(member((_, X, Y), B)),
	find_line(B, Color, B, X, Y).

/* Check if the position is valid
 Mostly used to generate the valid positions */
val_x(X):-
	member(X, [a,b,c,d,e,f,g,h]).
val_y(Y):-
	member(Y, [1,2,3,4,5,6,7,8]).

/* Try to find a valid line between the suggested coordinates and the Board
Stop as soon as one is found */
find_line(B, Color, [Cell|_], X, Y):-
	line(Color, X, Y, Cell, B, _),
	!.
find_line(B, Color, [_|R], X, Y):-
	find_line(B, Color, R, X, Y).

sameCol(C, (C, _, _)).

/* line(C1, X1, Y1, (C1, X2, Y2), B) */
/* Check if the two points form a line */

/* Check for a line on the x axis */
line(C, X, Y1, (C, X, Y2), B, LN):-
	include(cond_x(X, Y1, Y2), B, L),
	abs(Y2 - Y1, A),
	opp(C, OC),
	include(sameCol(OC), L, LN),
	length(LN, LL),
	LL =:= A - 1,
	LL > 0,
	!.

/* y axis */
line(C, X1, Y, (C, X2, Y), B, LN):-
	include(cond_y(Y, X1, X2), B, L),
	x(X1, VX1),
	x(X2, VX2),
	abs(VX2 - VX1, A),
	opp(C, OC),
	include(sameCol(OC), L, LN),
	length(LN, LL),
	LL =:= A - 1,
	LL > 0,
	!.


/* diagonal 1 */
line(C, X1, Y1, (C, X2, Y2), B, LN):-
	are_diag1(X1, Y1, X2, Y2),
	include(cond_d1(X1, Y1, X2, Y2), B, L),
	abs(Y2 - Y1, A),
	opp(C, OC),
	include(sameCol(OC), L, LN),
	length(LN, LL),
	LL =:= A - 1,
	LL > 0,
	!.


/* diagonal 2 */
line(C, X1, Y1, (C, X2, Y2), B, LN):-
	are_diag2(X1, Y1, X2, Y2),
	include(cond_d2(X1, Y1, X2, Y2), B, L),
	abs(Y2 - Y1, A),
	opp(C, OC),
	include(sameCol(OC), L, LN),
	length(LN, LL),
	LL =:= A - 1,
	LL > 0,
	!.


/* Check if the two points are neighbor */
neighbor(X1, Y1, (_, X2, Y2)):-
	x(X1, VX1),
	x(X2, VX2),
	DX is VX2 - VX1,
	DY is Y2 - Y1,
	abs(DX, ADX),
	abs(DY, ADY),
	ADX =< 1,
	ADY =< 1.


/* Check the point is on same X line and between y1 and y2 */
cond_x(X, Y1, Y2, (_, X, Y3)):-
	Y1 < Y2,
	between(Y1, Y2, Y3),
	!.
cond_x(X, Y1, Y2, (_, X, Y3)):-
	Y1 > Y2,
	between(Y2, Y1, Y3).

/* Check the point is on same y line and between x1 and x2 */
cond_y(Y, X1, X2, (_, X3, Y)):-
	x(X1, VX1),
	x(X2, VX2),
	x(X3, VX3),
	VX1 < VX2,
	between(VX1, VX2, VX3),
	!.
cond_y(Y, X1, X2, (_, X3, Y)):-
	x(X1, VX1),
	x(X2, VX2),
	x(X3, VX3),
	VX1 > VX2,
	between(VX2, VX1, VX3).

/* Pretty much the same, but for the diagonals */
cond_d1(X1, Y1, _, Y2, (_, X3, Y3)):-
	are_diag1(X1, Y1, X3, Y3),
	Y1 < Y2,
	between(Y1, Y2, Y3),
	!.
cond_d1(X1, Y1, _, Y2, (_, X3, Y3)):-
	are_diag1(X1, Y1, X3, Y3),
	Y1 > Y2,
	between(Y2, Y1, Y3).

cond_d2(X1, Y1, _, Y2, (_, X3, Y3)):-
	are_diag2(X1, Y1, X3, Y3),
	Y1 < Y2,
	between(Y1, Y2, Y3),
	!.
cond_d2(X1, Y1, _, Y2, (_, X3, Y3)):-
	are_diag2(X1, Y1, X3, Y3),
	Y1 > Y2,
	between(Y2, Y1, Y3).

/* Check if the points and on the same diagonal */
are_diag1(X1, Y1, X2, Y2):-
	x(X1, VX1),
	x(X2, VX2),
	VX1 - Y1 =:= VX2 - Y2.

are_diag2(X1, Y1, X2, Y2):-
	x(X1, VX1),
	x(X2, VX2),
	VX1 + Y1 =:= VX2 + Y2.

/* makemove(+Color, +Board, +X, +Y, -NewBoard) */
/*
makemove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], d, 3, R).
makemove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5),(white, e, 6),(white, f, 5),(white, f, 6),(black, g, 5)], e, 7, R).

*/
makemove(Color, Board, X, Y, [(Color, X, Y)|NewBoard]):-
	legalmove(Color, Board, X, Y),
	get_lines(Board, Color, X, Y, Board, LL),
	apply_lines(Color, LL, Board, NewBoard).


/* Get all lines that needs to be colored 
return a list of list */
get_lines([], _, _, _, _, []).	
get_lines([Cell|R], Color, X, Y, Board, [L|LL]):-
	line(Color, X, Y, Cell, Board, L),
	get_lines(R, Color, X, Y, Board, LL).
get_lines([Cell|R], Color, X, Y, Board, LL):-
	not(line(Color, X, Y, Cell, Board, _)),
	get_lines(R, Color, X, Y, Board, LL).


/* Will apply the lines (to be colored) one by one */
apply_lines(_, [], Board, Board).
apply_lines(Color, [L|R], Board, NewBoard):-
	set_color(Color, L, Board, NB),
	apply_lines(Color, R, NB, NewBoard).

/* Will color every point in the list to the board */
set_color(_, [], Board, Board).
set_color(Color, [(_, X, Y)|R], Board, NewBoard):-
	colorify(Color, X, Y, Board, NB),
	set_color(Color, R, NB, NewBoard).

/* Color a point */
colorify(_, _, _, [], []).
colorify(Color, X, Y, [(_, X, Y)|R], [(Color, X, Y)|L]):-
	colorify(Color, X, Y, R, L).
colorify(Color, X, Y, [(C, X2, Y2)|R], [(C, X2, Y2)|L]):-
	not(samePos(X, Y, X2, Y2)),
	colorify(Color, X, Y, R, L).

samePos(X, Y, X, Y).



/* makemoves(+Color, +Board, +N, -Moves, -NewBoard) */
/*
makemoves(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], 1, L, NB).
*/
makemoves(_, Board, 0, [], Board).
makemoves(Color, Board, N, [(Color, X, Y)|L], NewBoard):-
	N > 0,
	makemove(Color, Board, X, Y, NB),
	opp(Color, OC),
	N1 is N - 1,
	makemoves(OC, NB, N1, L, NewBoard).
makemoves(Color, Board, N, [(Color, N, N)|L], NewBoard):-
	N > 0,
	not(makemove(Color, Board, _, _, _)),
	opp(Color, OC),
	N1 is N - 1,
	makemoves(OC, Board, N1, L, NewBoard).

/* valueof(+Color,+Board,-Value) */
/* valueof(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], V). */
valueof(_, [], 0).
valueof(Color, [(Color, X, Y)|R], V):-
	cellValue(X, Y, CV),
	valueof(Color, R, NV),
	V is CV + NV.
valueof(Color, [(C, _, _)|R], V):-
	\==(Color, C),
	valueof(Color, R, V).

yedge(1).
yedge(8).
xedge(a).
xedge(h).

cellValue(X, Y, 3):-
	xedge(X),
	yedge(Y).
cellValue(X, Y, 2):-
	xedge(X),
	not(yedge(Y)).
cellValue(X, Y, 2):-
	not(xedge(X)),
	yedge(Y).
cellValue(X, Y, 1):-
	not(xedge(X)),
	not(yedge(Y)).

/* findbestmove(+Color, +Board, +N, -X, -Y) */
/*
findall((L, NB), makemoves(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], 1, L, NB), G).
findbestmove(black, [(white,d,4),(black,e,4),(black,d,5),(white,e,5)], 1, X, Y).
*/

findbestmove(black, B, N, X, Y):-
	findall((L, NB), makemoves(black, B, N, L, NB), G),
	predsort(cmp_b, G, SG),
	extract_X_Y(SG, X, Y).
findbestmove(white, B, N, X, Y):-
	findall((L, NB), makemoves(white, B, N, L, NB), G),
	predsort(cmp_w, G, SG),
	extract_X_Y(SG, X, Y).


extract_X_Y([([(_, X, Y)|_], _)|_], X, Y).

/* Only work around I found to sort the list of moves */
cmp_b(R, I1, I2):-
	cmp(black, R, I1, I2).
cmp_w(R, I1, I2):-
	cmp(white, R, I1, I2).


cmp(C, <, (_, B1), (_,B2)):-
	valueof(C, B1, V1),
	valueof(C, B2, V2),
	V1 < V2.
cmp(C, >, (_, B1), (_,B2)):-
	valueof(C, B1, V1),
	valueof(C, B2, V2),
	V1 > V2.
cmp(C, =, (_, B1), (_,B2)):-
	valueof(C, B1, V1),
	valueof(C, B2, V2),
	V1 = V2.