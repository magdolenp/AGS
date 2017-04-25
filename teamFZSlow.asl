
+step(0) <- .println("START");
			?grid_size(A,B);
			+right(A);
			+down(B);
			+right;
			do(skip).


+step(X): moves_per_round(1) <- !go.

+!go: spectacles(A,B) & pos(X,Y) <- .println(A, B);
									.println(X,Y).
									//do(skip).

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

