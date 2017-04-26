
 +step(0) <- .println("START");
			?grid_size(A,B);
			+right(A);
			+down(B);
			+r;
			do(skip);
			do(skip);
			do(skip).

//+step(X): shoes(A,B) & pos(A,B) <- do(pick).

//+step(X): moves_per_round(6) <- !go;!go.

+!atomStep(X,Y): pos(X,Y) <- do(skip).

@label[atomic] +!atomStep(X,Y): true <-
	myLib.myIA(X, Y, R);
	.print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ", X, ":", Y, "  ", R);
	do(R).


+!clearHelp(X,Y): true <-
	.abolish(needHelp(_,_)).

+!clearHelp(_,_).

/*
+!checkPosition(X,Y): 
	pos(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	.abolish(needHelp(X,Y)).

+!checkPosition(_,_).
*/


+step(I): needHelp(X,Y) & ally(X,Y) & pos(X,Y)
<-
	do(drop).


+step(I): needHelp(X,Y)
<-
	.println("ragujemragujemragujemragujemragujemragujemragujemragujemragujemragujemv ");
	!atomStep(X,Y);
	!atomStep(X,Y);
	!atomStep(X,Y).
	//!move_to(X,Y);
	//!move_to(X,Y);
	//!move_to(X,Y);
	//!checkPosition(X,Y).


/*
+do_need_help[source(Agent)]: true
<-
	+needHelp(_,_,Agent).

+dont_need_help[source(Agent)]: true
<-
	.abolish(needHelp(_,_,Agent)).
*/

+step(I): moves_per_round(3) <- 
.println("idem si svoje ...........................................................................");
!go.
 
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


+!go: r & pos(A,B) & right(C) & A<C-1 <- do(right);do(right);do(right).
+!go: r <- -r;
			   +left;
			   do(up);
			   do(left);
			   do(left).	
			   
+!go: left & pos(A,B) & A>0 <- do(left);
							   do(left);
							   do(left).	
+!go: left <-  -left;
			   +r;
			   do(up);
			   do(right);
			   do(right).

