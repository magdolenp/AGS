package myLib;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Iterator;

import jason.asSyntax.*;
import jason.environment.grid.Location;
import jason.asSemantics.*;
import jason.bb.*;

import java.util.ArrayList;
import java.util.List;

import myLib.pathfinding.AStar;

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
        List<int[]> blocked = new ArrayList<>();
        int aux, auy;

        eX = Integer.parseInt(args[0].toString());  // End X
        eY = Integer.parseInt(args[1].toString());  // End Y

        while (i.hasNext()) {
            Literal element = (Literal) i.next();
            if (element.getFunctor().equals("right"))  // Grid size X
                sizeX = Integer.parseInt(element.getTerm(0).toString());

            if (element.getFunctor().equals("down"))  // Grid size Y
                sizeY = Integer.parseInt(element.getTerm(0).toString());

            if (element.getFunctor().equals("pos")) {  // Start X & Y
                sX = Integer.parseInt(element.getTerm(0).toString());
                sY = Integer.parseInt(element.getTerm(1).toString());
            }

            if (element.getFunctor().equals("map")) {  // Add list of obstacles
                if (element.getTerm(2).toString().equals("obstacle")) {
                    aux = Integer.parseInt(element.getTerm(0).toString());
                    auy = Integer.parseInt(element.getTerm(1).toString());
                    int[] cell = {aux, auy};
                    blocked.add(cell);
                }
            }
        }

        System.out.println(" >> A STAR <<");
        System.out.println(sX);
        System.out.println(sY);
        System.out.println(eX);
        System.out.println(eY);
        System.out.println(sizeX);
        System.out.println(sizeY);
        for (int k = 0; k < blocked.size(); k++) {
            System.out.println("BLOCKED" + blocked.get(k));        
        }

        // start X, start Y, end X, end Y, map size X, map size Y
        AStar aStar = new AStar();
        String direction = aStar.run(sX, sY, eX, eY, sizeX, sizeY, blocked);
        Atom result = new Atom(direction);
        un.unifies(result, args[2]);

        return (Object) true;
    }
}