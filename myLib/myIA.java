package myLib;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Iterator;

import jason.asSyntax.*;
import jason.environment.grid.Location;
import jason.asSemantics.*;
import jason.bb.*;

import static myLib.pathfinding.AStar.run;

public class myIA extends DefaultInternalAction {

    // private Logger logger = Logger.getLogger("jasonTeamSimLocal.mas2j." + MiningPlanet.class.getName());

   public Object execute(TransitionSystem ts,
                         Unifier un,
                         Term[] args)
                 throws Exception {

		  Agent a = ts.getAg();
		  BeliefBase bb = a.getBB();
		  Iterator i = bb.iterator();

		  int sX = 0, sY = 0, eX = 0, eY = 0, sizeX = 1, sizeY = 1;

		  System.out.println(args[0]);
		  eX = Integer.parseInt(args[0].toString());
		  System.out.println(args[1]);
		  eY = Integer.parseInt(args[1].toString());

		  while(i.hasNext()) {
			  Literal element = (Literal) i.next();
			  if (element.getFunctor().equals("right")) {
				  sizeX = Integer.parseInt(element.getTerm(0).toString());
				  System.out.print(element.getTerm(0).toString()+" ");
			  }
			  if (element.getFunctor().equals("down")) {
				  sizeY = Integer.parseInt(element.getTerm(0).toString());
				  System.out.print(element.getTerm(0).toString()+" ");
			  }
			  if (element.getFunctor().equals("pos")) {
				  sX = Integer.parseInt(element.getTerm(0).toString());
				  sY = Integer.parseInt(element.getTerm(1).toString());
				  System.out.print(element.getTerm(0).toString()+" ");
				  System.out.print(element.getTerm(1).toString()+" ");				  
			  }
			  if (element.getFunctor().equals("map")) {
				  if (element.getTerm(2).toString().equals("obstacle")) {
					  System.out.print(element.getTerm(0).toString()+" ");
					  System.out.print(element.getTerm(1).toString()+" ");				  
				  }
			  }
			  System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
		  }
		  
		  // start X, start Y, end X, end Y, map size X, map size Y
		  String direction = run(sX, sY, eX, eY, sizeX, sizeY);
		  Atom result = new Atom(direction);
		  un.unifies(result, args[2]);

          return (Object) true;
   }
}