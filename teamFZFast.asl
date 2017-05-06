//+step(_): true <-do(skip);do(skip);do(skip).
+step(0) 
<-
	?grid_size(A,B);
	for ( .range(I, 0, A-1)) {
		for ( .range(J, 0, B-1)) {
			+unvisited(I, J);
		}
	};
	+right(A);
	+down(B);
	+r;
	do(skip);
	do(skip);
	do(skip).

+step(I): 
	needHelp(X, Y) & 
	depot(X, Y)
<-
	!clearHelp(X, Y);
	+step(I).

+step(I): 
	needHelp(X,Y) & 
	ally(X,Y) & 
	pos(X,Y) &
	moves_per_round(Moves) &
	friend(A) &
	friend(B) &
	A \== B
<-
	.send(A, achieve, clearHelpShoes(_,_));
	.send(B, achieve, clearHelpShoes(_,_));
	!updateMap;
	for( .range(Iter, 1, Moves)){
		do(skip);
	}.

// there is only one need help
+step(I): 
	needHelp(X,Y) &
	moves_per_round(Moves) &
	friend(A) &
	friend(B) &
	A \== B
<-
	.send(A, achieve, clearHelpShoes(_,_));
	.send(B, achieve, clearHelpShoes(_,_));
	!updateMap;
	for( .range(Iter, 1, Moves)){
		!atomStep(X,Y);
		!updateMap;
	}.

// there are two need helps
+step(I): 
	needHelp(X1,Y1) &
	needHelp(X2,Y2) &
	(X1 \== X2 | Y1 \== Y2) &
	pos(X,Y) &
	moves_per_round(Moves) &
	friend(A) &
	friend(B) &
	A \== B
<-
	.send(A, achieve, clearHelpShoes(_,_));
	.send(B, achieve, clearHelpShoes(_,_));

	dist(X, Y, X1, Y1, D1);
	dist(X, Y, X2, Y2, D2);

	!updateMap;
	for( .range(Iter, 1, Moves)){
		if(D1 < D2){
			!atomStep(X1,Y1);	
		}
		else {
			!atomStep(X2,Y2);	
		};
		!updateMap;
	}.

+!dist(X1,Y1, X2,Y2, D): 
	true 
<-
	D = math.sqrt((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2)).

+step(I): 
	map(Item_X, Item_Y, shoes) &
	pos(X, Y) & 
	moves_per_round(3)
<-
	!move_to(Item_X, Item_Y).

+step(I): 
	moves_per_round(Moves)
<-
	!updateMap;
	for( .range(Iter, 1, Moves)){
		if(unvisited(_,_)){
			?unvisited(X,Y);
			!atomStep(X,Y);
			!updateMap;			
		}
		else{
			do(skip);
		}
	}.


+step(I): 
	moves_per_round(Moves) 
<-
	for( .range(Iter, 1, Moves)){
		do(skip);
	}.


+!remMap(X,Y,Item): 
	map(X,Y,Item) 
<-
	.abolish(map(X,Y,Item)).

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
	map(X,Y, gold) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	.abolish(map(X,Y, gold));
	.send(A, achieve, remMap(X,Y, gold));
	.send(B, achieve, remMap(X,Y, gold)).

+!updateGold(_,_).


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
	map(X,Y, wood) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	.abolish(map(X,Y, wood));
	.send(A, achieve, remMap(X,Y, wood));
	.send(B, achieve, remMap(X,Y, wood)).

+!updateWood(_,_).


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


+!updateShoes(X,Y):
	shoes(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	+map(X,Y, shoes);
	.send(A, tell, map(X,Y, shoes));
	.send(B, tell, map(X,Y, shoes)).

+!updateShoes(X,Y):
	map(X,Y, shoes) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	.abolish(map(X,Y, shoes));
	.send(A, achieve, remMap(X,Y, shoes));
	.send(B, achieve, remMap(X,Y, shoes)).

+!updateShoes(_,_).

+!updateSpectacles(X,Y):
	spectacles(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	+map(X,Y, spectacles);
	.send(A, tell, map(X,Y, spectacles));
	.send(B, tell, map(X,Y, spectacles)).

+!updateSpectacles(X,Y):
	map(X,Y, spectacles) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	.abolish(map(X,Y, spectacles));
	.send(A, achieve, remMap(X,Y, spectacles));
	.send(B, achieve, remMap(X,Y, spectacles)).

+!updateSpectacles(_,_).

@update[atomic] +!updateMap:
	pos(X,Y) &
	friend(A) &
	friend(B) &
	A \== B 
<-
	for( .range(I,-1,1)){
		for( .range(J,-1,1)){
			!updateGold(X+I,Y+J);
			!updateWood(X+I,Y+J);
			!updateObstacle(X+I,Y+J);
			!updateShoes(X+I,Y+J);
			!updateSpectacles(X+I,Y+J);
			-unvisited(X+I,Y+J);
			.send(A, achieve, visited(X+I,Y+J));
			.send(B, achieve, visited(X+I,Y+J));
		}
	}.


+!visited(X, Y):
	true
<-
	.abolish(unvisited(X, Y)).


+!atomStep(X,Y): 
	pos(X,Y)
<-
	do(skip).
	

@label2[atomic] +!atomStep(X,Y): 
	true 
<-
	myLib.myIA(X, Y, R);
	if (R == skip) { 
		-unvisited(X,Y); 
	};
	do(R).


+!clearHelp(_, _): 
	true 
<-
	.abolish(needHelp(_,_)).


+gold(X,Y): 
	true
<-
	+map(X,Y,gold);
	!inform(X,Y,gold).  


+wood(X,Y): 
	true
<-
	+map(X,Y,wood);
	!inform(X,Y,wood).

+spectacles(X,Y): 
	true
<-
	+map(X,Y,spectacles);
	!inform(X,Y,spectacles).


+obstacle(X,Y): 
	true
<-
	+map(X,Y,obstacle);
	!inform(X,Y,obstacle).

+shoes(X,Y): 
	true
<-
	+map(X,Y,shoes).


+!inform(X, Y, Item):
	friend(A) &
	friend(B) &
	A \== B
<-
	.send(A, tell, map(X,Y,Item));
	.send(B, tell, map(X,Y,Item)).


@pickmovefast[atomic] +!move_to(Item_X,Item_Y):
	pos(X,Y) &
	ally(X,Y) &
	X == Item_X &
	Y == Item_Y	&
	friend(A) &
	friend(B) &
	A \== B 
<-
	do(pick);
	.send(A, achieve, clearHelpShoes(_,_));
	.send(B, achieve, clearHelpShoes(_,_)).

@skipmovefast[atomic] +!move_to(Item_X, Item_Y):
	pos(X,Y) &
	// ally(X,Y) &
	X == Item_X &
	Y == Item_Y	&
	friend(A) &
	friend(B) &
	A \== B 
<-
	.send(A, tell, needHelpShoes(X,Y));
	.send(B, tell, needHelpShoes(X,Y));
	do(skip);
	do(skip);
	do(skip).

@atmt2[atomic] +!move_to(Item_X, Item_Y):
	true
<-
	myLib.myIA(Item_X, Item_Y, R1);
	do(R1);
	!updateMap;
	
	?pos(X1, Y1);
	if(X1 == Item_X & Y1 == Item_Y){
		do(skip);
	} 
	else {
		myLib.myIA(Item_X, Item_Y, R2);
		do(R2);
		!updateMap;
	}
	
	?pos(X2, Y2);
	if(X2 == Item_X & Y2 == Item_Y){
		do(skip);
	} 
	else {
		myLib.myIA(Item_X, Item_Y, R3);
		do(R3);
		!updateMap;
	}.
