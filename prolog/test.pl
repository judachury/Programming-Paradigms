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
mazeSize(5,5).
barrier(3,1).
barrier(3,2).
barrier(3,3).
barrier(3,4).
%barrier(1,8).
%barrier(2,8).
%barrier(2,2).
%barrier(2,4).
%barrier(2,5).
%barrier(3,4).
%barrier(3,7).
%barrier(3,9).
%barrier(4,4).
%barrier(4,7).
%barrier(4,8).
%barrier(4,9).
%barrier(5,2).

move(X,X,Z).
move([FromX|[FromY|_]],[ToX|[ToY|_]],Path) :- move0(FromX,ToX,FromY,ToY,[],P), rev(P,Path).

move0(X,X,X2,Y2,P,P).
move0(FromX,ToX,FromY,ToY,P,R) :- 
	Z is FromX+1, 
	isValid(Z,FromY,P), 
	move0(Z,ToX,FromY,ToY,[[Z,FromY]|P],R).
	
move0(FromX,ToX,FromY,ToY,P,R) :- 
	Z is FromY+1, isValid(FromX,Z,P), move0(FromX,ToX,Z,ToY,[[FromX,Z]|P],R).

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











































