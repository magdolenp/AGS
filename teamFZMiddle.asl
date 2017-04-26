+!remMap(X,Y,Item): map(X,Y,Item) <- .abolish(map(X,Y,Item)).
+!remMap(_,_,_).


+step(X) <- do(skip); do(skip). 


