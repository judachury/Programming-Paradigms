mazeSize(5,9).
barrier(1,8).
barrier(2,8).
barrier(2,2).
barrier(2,4).
barrier(2,5).
barrier(3,4).
barrier(3,7).
barrier(3,9).
barrier(4,4).
barrier(4,7).
barrier(4,8).
barrier(4,9).
barrier(5,2).

move(X,X,Z).
move([FromX|[FromY|_]],[ToX|[ToY|_]],Path) :- move0(FromX,ToX,FromY,ToY,[],P), rev(P,Path).

move0(X,X,Y,Y,P,P).
move0(FromX,ToX,FromY,ToY,P,R) :-
	Z is FromX+1,
	isValid(Z,FromY,P),
	move0(Z,ToX,FromY,ToY,[[Z,FromY]|P],R).
move0(FromX,ToX,FromY,ToY,P,R) :-
	Z is FromY+1, 
	isValid(FromX,Z,P), 
	move0(FromX,ToX,Z,ToY,[[FromX,Z]|P],R).
move0(FromX,ToX,FromY,ToY,P,R) :-
	Z is FromX-1,
	isValid(Z,ToX,P),
	move0(Z,ToX,FromY,ToY,[[Z,FromY]|P],R).
move0(FromX,ToX,FromY,ToY,P,R) :-
	Z is FromY-1, 
	isValid(FromX,Z,P), 
	move0(FromX,ToX,Z,ToY,[[FromX,Z]|P],R).

isValid(X,Y,P) :-
	mazeSize(A,Z),
	(X =< A, X >= 1),
	(Y =< Z, Y >= 1),
	not(barrier(X,Y)),
	ok([X,Y],P).

ok(X,[]).
ok(X,[H|T]) :- X \== H, ok(X,T).

rev(L1,L2) :- reverseme(L1,[],L2).

reverseme([],L,L).
reverseme([X|L],L2,L3) :- reverseme(L,[X|L2],L3).

%print the maze
columns(AnyRow,0).
columns(Row,Column) :- barrier(Row,Column), write('x '), NewColumn is Column-1, columns(NewRow,NewColumn).
columns(Row,Column) :- write('. '), NewColumn is Column-1, columns(Row,NewColumn).

printNumbers(X,X).
printNumbers(X,Y) :- 
	Z is X+1, write(Z), write(' '), printNumbers(Z,Y).

printDivider(0).
printDivider(X) :-
	print('--'), Z is X-1, printDivider(Z).

columns0(X,X) :- write('. '). 
columns0(From,To) :- write('. '), Z is From+1, columns0(Z,To).

mazeTable(X,X,Z) :- write(X), write(' | '), columns0(1,Z), write('|').
mazeTable(From,Rows,Columns) :- 
	write(From), 
	write(' | '), 
	columns0(1,Columns), 
	write('|'), 
	nl, 
	Z is From+1, 
	mazeTable(Z,Rows,Columns).


printMaze(X,X).
printMaze(X,Y) :-
	print('    '), printNumbers(0,Y), nl,
	print('  +'), printDivider(Y), print('-+'), nl,
	mazeTable(1,X,Y), nl,
	print('  +'), printDivider(Y), print('-+'), nl.

maze :- 
	mazeSize(X,Y), 
	printMaze(X,Y).
