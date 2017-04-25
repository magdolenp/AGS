
+step(0) <- .println("START");
			?grid_size(A,B);
			+right(A);
			+down(B);
			+right;
			do(skip).

+!findClosest(CurrMin, Min, MinX, MinY): map(X,Y,_) & not (tested(X,Y)) <-
	+tested(X,Y);
	?pos(MyX,MyY);
	!dist(MyX, MyY, X,Y, CalcMin);
	.print("At: ",  X, ":", Y, " Dist: ", CalcMin);
	/*CalcMin = Y;*/
	!findClosest(CalcMin, NewMin, NMX, NMY);
	if (NewMin < CalcMin) {Min = NewMin; MinX = NMX; MinY = NMY}
	else {Min = CalcMin; MinX = X; MinY = Y}.
	
+!findClosest(CurrMin, Min, MinX, MinY): true <- Min = CurrMin; MinX = -1; MinY = -1; .abolish(tested(_,_)).

+!dist(X1,Y1, X2,Y2, D): true <-
	D = math.sqrt((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)).



+!updateGold(X,Y): gold(X,Y) <- +map(X,Y, gold).
+!updateGold(X,Y): true <- -map(X,Y, gold).

+!updateWood(X,Y): wood(X,Y) <- +map(X,Y, wood).
+!updateWood(X,Y): true <- -map(X,Y, wood).

+!updateMap(X,Y): true
<-
	for( .range(I,-3,3)){
		for( .range(J,-3,3)){
			!updateGold(X+I,Y+J);
			!updateWood(X+I,Y+J);
		}
	}.

+step(I): pos(X,Y)
<-
	!updateMap(X,Y);
	!findClosest(9999, M, Item_X, Item_Y);
	if (Item_X > -1 & Item_Y > -1) {!move_to(Item_X, Item_Y)}
	else{!go}.
	//findClosest;
	//move_to.
	

+step(I): moves_per_round(1) 
<- 
	!go.


+gold(X,Y): true
<- 
	+map(X,Y,gold);
	!inform(X,Y,gold).  

+wood(X,Y): true
<- 
	+map(X,Y,wood);
	!inform(X,Y,wood).

// +spectacles(X,Y): 
// 	+map(X,Y,spectacles).


// +obstacle(X,Y): 
// 	+map(X,Y,obstacle);
// 	!inform(X,Y,obstacle).

// +shoes(X,Y): 
// 	+map(X,Y,shoes);
// 	!inform(X,Y,shoes).


+!inform(X, Y, Item):
	friend(A) &
	friend(B) &
	A \== B
<-
	.send(A, tell, map(X,Y,Item));
	.send(B, tell, map(X,Y,Item)).


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
	Y == Item_Y	&
	friend(A) &
	friend(B) &
	A \== B 
<-
	.send(A, tell, needHelp(X,Y));
	.send(B, tell, needHelp(X,Y));
	do(pick).


+!go: right & pos(A,B) & right(C) & A<C-1 <- do(right).

+!go: left & pos(A,B) & A>0 <- do(left).

+!go: left <-  -left;
			   +down(6);
			   do(down).
+!go: right <- -right;
			   +down(6);
			   do(down).


+!go: down(1) & pos(A,B) & A==0 <- -down(1);+right;do(down).
+!go: down(1) & pos(A,B) & right(C) & A==C-1 <- -down(1);+left;do(down).
			   
+!go: down(X) & X\==1 <- .println(X);-down(X);+down(X-1);do(down).

