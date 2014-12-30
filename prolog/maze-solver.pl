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
	findAWayOut(From,To,Path).