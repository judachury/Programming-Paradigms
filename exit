mazeSize(5,9).
barrier(1,8).
barrier(2,1).
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

solve(From,To,Path) :- 
	mazeSize(X,Y),
	move(From,To,Z), 
	append([From],Z,Path),
	makeTable(X,Y,Path) .

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

%============================================================
printNumbers(X,X).
printNumbers(X,Y) :- 
	Z is X+1, write(Z), write(' '), printNumbers(Z,Y).

printColumnNumbers(From,To) :- write('    '), printNumbers(From,To), nl.

middleLine(X,X).
middleLine(X,Y) :- Z is X+1, write('--'), middleLine(Z,Y).

printDivider(X) :- write('  +-'), middleLine(0,X), write('+'), nl.

mycolumns(X,X,Row,Path).
mycolumns(From,To,Row,Path) :- 
	Z is From+1, member([Row,Z],Path), write('* '), mycolumns(Z,To,Row,Path).
mycolumns(From,To,Row,Path) :- 
	Z is From+1, not(barrier(Row,Z)), write('. '), mycolumns(Z,To,Row,Path).
mycolumns(From,To,Row,Path) :- 
	Z is From+1, barrier(Row,Z), write('x '), mycolumns(Z,To,Row,Path).

printTable(X,X,Y,Z,P).
printTable(X,Rows,Y,Columns,Path) :- 
	Z is X+1, write(Z), write(' | '),
	mycolumns(Y,Columns,Z,Path), write('|'), nl,
	printTable(Z,Rows,Y,Columns,Path).

makeTable(Rows,Columns,P) :-
	Z is 0, 
	printColumnNumbers(Z,Columns),
	printDivider(Columns),
	printTable(Z,Rows,Z,Columns,P),
	printDivider(Columns).   

maze :-
	mazeSize(X,Y),
	makeTable(X,Y,P).