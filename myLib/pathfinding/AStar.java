package myLib.pathfinding;

import java.util.*;

/**
 * A* algorithm humble implementation
 * Blocked Nodes are just null Node values in grid
 */
public class AStar {
    private static final int COST = 10;

    /**
     * Single node/cell of grid representation
     */
    static class Node{
        int heuristicCost = 0;  // Heuristic cost
        int finalCost = 0;      // G + H
        int x, y;
        Node parent;

        Node(int y, int x) {
            this.x = x;
            this.y = y;
        }

        @Override
        public String toString(){
            return "["+this.x+", "+this.y+"]";
        }
    }

    private static Node[][] grid;
    private static int startX, startY;
    private static int endY, endX;

    private static PriorityQueue<Node> open;  //  Set of nodes to be evaluated
    private static boolean closed[][];        // Set of nodes already evaluated


    /**
     * Set unreachable node
     */
    private static void setBlocked(int y, int x) {
        grid[y][x] = null;  // Unreachable node
    }


    /**
     * Set coordinates of starting node
     */
    private static void setStartNode(int y, int x) {
        startY = y;
        startX = x;
    }


    /**
     * Set coordinates of destination node
     */
    private static void setEndNode(int y, int x){
        endY = y;
        endX = x;
    }


    /**
     * Recalculate price if possible
     */
    private static void checkAndUpdateCost(Node current, Node next, int cost){
        if (next != null && !closed[next.y][next.x]) {     // Not blocked & yet checked
            int auxFinalCost = next.heuristicCost + cost;

            boolean inOpen = open.contains(next);
            if (!inOpen || auxFinalCost < next.finalCost) {
                next.finalCost = auxFinalCost;
                next.parent = current;
                if (!inOpen)
                    open.add(next);
            }
        }
    }


    /**
     * A Star calculation
     */
    private static void search(){
        open.add(grid[startY][startX]);  // Add the start location to open list.
        Node current;

        while (true) {
            current = open.poll();
            if (current == null)
                break;
            closed[current.y][current.x] = true;
            if (current.equals(grid[endY][endX]))
                return;

            Node t;
            if (current.y-1 >= 0) {  // LEFT
                t = grid[current.y-1][current.x];
                checkAndUpdateCost(current, t, current.finalCost + COST);
            }

            if (current.y+1 < grid.length) {  // RIGHT
                t = grid[current.y+1][current.x];
                checkAndUpdateCost(current, t, current.finalCost + COST);
            }

            if (current.x-1 >= 0) {  // UP
                t = grid[current.y][current.x-1];
                checkAndUpdateCost(current, t, current.finalCost + COST);
            }

            if (current.x+1 < grid[0].length) {  // DOWN
                t = grid[current.y][current.x+1];
                checkAndUpdateCost(current, t, current.finalCost + COST);
            }
        }
    }


    /**
     * Run A star
     * @param sX - starting point X
     * @param sY - starting point Y
     * @param eX - destination point X
     * @param eY - destination point Y
     */
    public static String run(int sX, int sY, int eX, int eY, int sizeX, int sizeY, List<int[]> blocked) {
        grid = new Node[sizeY][sizeX];  // Create grid
        setStartNode(sY, sX);           // Set start position
        setEndNode(eY, eX);             // Set End Location
        closed = new boolean[sizeY][sizeX];

        open = new PriorityQueue<>((Object o1, Object o2) -> {
            Node c1 = (Node)o1;
            Node c2 = (Node)o2;

            return c1.finalCost < c2.finalCost?-1:
                    c1.finalCost > c2.finalCost?1:0;
        });

        for (int i=0; i<sizeY; i++) {  // Set up matrix
            for (int j=0; j<sizeX; j++) {
                grid[i][j] = new Node(i, j);
                grid[i][j].heuristicCost = Math.abs(i-endY) + Math.abs(j-endX);
            }
        }

        grid[sY][sX].finalCost = 0;

        for (int[] elem : blocked) {  // Set blocked nodes
            if (elem.length == 2) {
                setBlocked(elem[1], elem[0]);
            }
        }

        //Display initial map
        /*
        System.out.println("Grid: ");
        for(int i=0; i<sizeY; i++){
            for(int j=0; j<sizeX; j++){
                if (i==sY && j==sX) System.out.print("SO  "); //Source
                else if (i==eY && j==eX) System.out.print("DE  ");  //Destination
                else if (grid[i][j] != null) System.out.printf("%-3d ", 0);
                else System.out.print("BL  ");
            }
            System.out.println();
        }
        System.out.println();*/

        search();
        /*
        System.out.println("\nScores for Nodes: ");  // Display scores
        for (int i=0; i<sizeY; i++) {
            for (int j=0; j<sizeX; j++){
                if (grid[i][j]!=null) System.out.printf("%-3d ", grid[i][j].finalCost);
                else System.out.print("X   ");
            }
            System.out.println();
        }
        System.out.println();
        */
        String direction = "skip";  // No path found
        if (closed[endY][endX]) {  // Trace back the path
            Node current = grid[endY][endX];

            if (current.parent != null) {
                while ((current.parent).parent != null) {
                    current = current.parent;
                }
            }

            //System.out.println(" -> " + current);
            // Check direction
            if (current.x > startX)
                direction = "right";
            else if (current.x < startX)
                direction = "left";
            else if (current.y > startY)
                direction = "down";
            else
                direction = "up";
        }
        return direction;
    }
}
