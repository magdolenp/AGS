package myLib;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Iterator;

import jason.asSyntax.*;
import jason.environment.grid.Location;
import jason.asSemantics.*;
import jason.bb.*;

public class myIA extends DefaultInternalAction {

    // private Logger logger = Logger.getLogger("jasonTeamSimLocal.mas2j." + MiningPlanet.class.getName());

   public Object execute(TransitionSystem ts,
                         Unifier un,
                         Term[] args)
                 throws Exception {

		  Agent a = ts.getAg();
		  BeliefBase bb = a.getBB();
		  Iterator i = bb.iterator();
		  
		  while(i.hasNext()) {
			  Literal element = (Literal) i.next();
			  if (element.getFunctor().equals("map")) {
				  System.out.print(element.getTerm(0).toString()+" ");
				  System.out.print(element.getTerm(1).toString()+" ");
				  System.out.println(element.getTerm(2).toString());
			  }
		  }
		  
          return (Object) true;
   }
}