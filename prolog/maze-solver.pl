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

findAWayOut(From,To,Path) :-
	not(lastStop(From,To)),
	moveRight(From,P),
	findAWayOut(P,To,Path), append([],P,Path).

moveRight([X|[Y|_]],Z) :-
	 A is Y+1, not(barrier(X,A)), write('*'), append([],[X,A],Z).
	 
lastStop(X, X2) :- X = X2.

solve(From, To, Path) :-
	write('*'),
	findAWayOut(From,To,Path),
	write('@@@@').
	
% TEST SOME CONCEPTS HERE
findPath(X,X,[X]).
findPath(X,X2,[X|R]) :-
		X < X2, Z is X+1, findPath(Z,X2,R).
		

findPathSecond([X1|[X2|_]],[Y1|[Y2|_]],R) :-
	findPath(X1,Y2,R1), 
	findPath(X2,Y2,R2),	
	append([R1],[R2],R).


makePairsX(0,Y,[]).
makePairsX(X,Y,R) :-
	A is X-1, makePairsX(A,Y,Z), append(Z,[[X,Y]],R).
	
check(X,L) :-
	barrier(X,L), write('Yes - '), write([X,L]), nl.
	
makePairsY(X,0,[]).
makePairsY(X,Y,R) :-
	A is Y-1, makePairsY(X,A,Z), append(Z,[[X,Y]],R).

makeTree(0,Y,R).
makeTree(X,Y,R) :-
	makePairsY(X,Y,Z), write(Z), A is X-1, makeTree(A,Y,B), append(B,Z,R).

	