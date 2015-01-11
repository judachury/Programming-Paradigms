%barrier(newcastle,carlisle,58).
%barrier(carlisle,penrith,23).
%barrier(darlington,newcastle,40).
%barrier(penrith,darlington,52).
%barrier(workington,carlisle,40).
%barrier(workington,penrith,39).
%barrier(X,Y) :- barrier(X,Y,Z).

go(Start,Dest,Route) :-
	go0(Start,Dest,[],R),
	rev(R,Route).

go0(X,X,T,[X|T]).
go0(Place,Y,T,R) :-
	legalnode(Place,T,Next),
	go0(Next,Y,[Place|T],R).

legalnode(X,Trail,Y) :-
	(barrier(X,Y) ; barrier(Y,X)), legal(Y,Trail).

legal(X,[]).
legal(X,[H|T]) :- X \== H, legal(X,T).

%rev([],[]).
%rev([H|T],L) :- rev(T,Z), append(Z,[H],L).

revzap([],L,L).
revzap([X|L],L2,L3) :- revzap(L,[X|L2],L3).
rev2(L1,L2) :- revzap(L1,[],L2).

%another test, move from left to right.
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

findAWayOut(From,To,Path) :-
	not(lastStop(From,To)),
	moveRight(From,P),
	findAWayOut(P,To,Path), append([],P,Path).

moveRight([X|[Y|_]],Z) :-
	 A is Y+1, not(barrier(X,A)), write('*'), append([],[X,A],Z).
	 
lastStop(X, X2) :- X = X2.

solve(From, To, Path) :-
	write('*'),
	findAWayOut(From,To,Path).
	
% TEST SOME CONCEPTS HERE
findPath(X,X,[X]).
findPath(X,X2,[X|R]) :-
		X < X2, Z is X+1, findPath(Z,X2,R).
		
%It makes a list of the two list
findPathSecond([X1|[X2|_]],[Y1|[Y2|_]],R) :-
	findPath(X1,Y2,R1), 
	findPath(X2,Y2,R2),	
	append([R1],[R2],R).

%not in used, but useful to have. Similar to the following one.
makePairsX(0,Y,[]).
makePairsX(X,Y,R) :-
	A is X-1, makePairsX(A,Y,Z), append(Z,[[X,Y]],R).

%look for all the locations of the maze in a column
makePairsY(X,0,[]).
makePairsY(X,Y,R) :-
	A is Y-1, makePairsY(X,A,Z), append(Z,[[X,Y]],R).

%produce all the locations of the maze
makeTree(0,Y,R).
makeTree(X,Y,R) :-
	makePairsY(X,Y,Z), A is X-1, makeTree(A,Y,B), append(B,Z,R).

	









































