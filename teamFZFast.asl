
 +step(0) <- .println("START");
			?grid_size(A,B);
			+right(A);
			+down(B);
			+right;
			do(skip);
			do(skip);
			do(skip).

+step(X): shoes(A,B) & pos(A,B) <- do(pick).

+step(X): moves_per_round(6) <- !go;!go.


+step(I): needHelp(X,Y)
<-
	.println("ragujemragujemragujemragujemragujemragujemragujemragujemragujemragujemv ");
	!move_to(X,Y);
	!move_to(X,Y);
	!move_to(X,Y).
	//.abolish(needHelp(_,_)).

+step(I): moves_per_round(3) <- !go.
 
 //do(right);do(right);do(right);do(left);do(left);do(left).
 




+!move_to(Item_X,Item_Y):
	pos(X,Y) &
	X < Item_X
<-
	do(right).

+!move_to(Item_X,Item_Y):
	pos(X,Y) &
	X > Item_X
<-
	do(left).

+!move_to(Item_X,Item_Y):
	pos(X,Y) &
	Y < Item_Y
<-
	do(down).

+!move_to(Item_X,Item_Y):
	pos(X,Y) &
	Y > Item_Y
<-
	do(up).

+!move_to(Item_X,Item_Y):
	pos(X,Y) &
	X == Item_X &
	Y == Item_Y
<-
	do(skip).


+!go: right & pos(A,B) & right(C) & A<C-1 <- do(right);do(right);do(right).
+!go: right <- -right;
			   +left;
			   do(up);
			   do(left);
			   do(left).	
			   
+!go: left & pos(A,B) & A>0 <- do(left);
							   do(left);
							   do(left).	
+!go: left <-  -left;
			   +right;
			   do(up);
			   do(right);
			   do(right).

