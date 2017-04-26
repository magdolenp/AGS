
+!remMap(X,Y,Item): map(X,Y,Item) <- .abolish(map(X,Y,Item)).
+!remMap(_,_,_).

+!updateGold(X,Y):
	gold(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	+map(X,Y, gold);
	.send(A, tell, map(X,Y, gold));
	.send(B, tell, map(X,Y, gold)).

+!updateGold(X,Y):
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	.abolish(map(X,Y, gold));
	.send(A, achieve, remMap(X,Y, gold));
	.send(B, achieve, remMap(X,Y, gold)).

+!updateWood(X,Y):
	wood(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	+map(X,Y, wood);
	.send(A, tell, map(X,Y, wood));
	.send(B, tell, map(X,Y, wood)).

+!updateWood(X,Y):
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	.abolish(map(X,Y, wood));
	.send(A, achieve, remMap(X,Y, wood));
	.send(B, achieve, remMap(X,Y, wood)).

+!updateObstacle(X,Y):
	obstacle(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
	<- 
	+map(X,Y, obstacle);
	.send(A, tell, map(X,Y, obstacle));
	.send(B, tell, map(X,Y, obstacle)).

+!updateObstacle(_,_).

+!updateMap: pos(X,Y)
<-
	for( .range(I,-1,1)){
		for( .range(J,-1,1)){
			!updateGold(X+I,Y+J);
			!updateWood(X+I,Y+J);
			!updateObstacle(X+I,Y+J);
		}
	}.



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
	!updateMap;
	!atomStep(X,Y);
	!updateMap;
	!atomStep(X,Y);
	!updateMap.

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


+!go: r & pos(A,B) & right(C) & A<C-1 <- 
do(right);
!updateMap;
do(right);
!updateMap;
do(right);
!updateMap.
+!go: r <- -r;
			   +left;
			   do(up);
			   !updateMap;
			   do(left);
			   !updateMap;
			   do(left);
			   !updateMap.	
			   
+!go: left & pos(A,B) & A>0 <- do(left);
								!updateMap;
							   do(left);
							   !updateMap;
							   do(left);
							   !updateMap.	
+!go: left <-  -left;
			   +r;
			   do(up);
			   !updateMap;
			   do(right);
			   !updateMap;
			   do(right);
			   !updateMap.

