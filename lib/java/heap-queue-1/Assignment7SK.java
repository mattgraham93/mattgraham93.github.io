/*
Matt Graham                matt.graham@bellevuecollege.edu
980492151                  25/5/2018

This program creates an Integer PriorityQueue/Heap and for a total of 30 iterations,
add random numbers to the priorityQueue based on a random integer between 0 and 1.
If the initial integer @random is 0, it will add another random number @num. If @random
is 1, it will remove the root node. Each iteration, it will print the PriorityQueue.
 */

import java.util.*;

public class Assignment7SK {
    public static void main(String[] args) {
        Random rnd = new Random();
        HeapIntPriorityQueueTest pq = new HeapIntPriorityQueueTest();

        for (int node = 1; node <= 30; node++) {        //for 30 iterations @nodes
            int random = rnd.nextInt(2);        //a random number between 0 and 1

            if (random == 0) {
                int num = 1 + rnd.nextInt(100);     //any random integer between 1 and 100
                pq.add(num);                            //add to @pq
                System.out.println(pq);                 //print the priority queue
            } else if (random == 1 && !pq.isEmpty()) {
                pq.remove();                            //remove root node
                System.out.println(pq);                 //print @pq
            }
        }

    }
}
