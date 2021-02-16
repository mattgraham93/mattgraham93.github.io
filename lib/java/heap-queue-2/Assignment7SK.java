// This client program tests our priority queue of integers
// by adding and removing several elements from it.

public class Assignment7SK {
    public static void main(String[] args) {
    
        HeapIntPriorityQueue pq = new HeapIntPriorityQueue();
        
        pq.add(7);
        System.out.println("add 7: " + pq);
        pq.add(2);
        System.out.println("add 2: " + pq);
        pq.add(5);
        System.out.println("add 5: " + pq);
        pq.add(1);
        System.out.println("add 1: " + pq);
        
        System.out.print("remove " + pq.remove() +": ");
        System.out.println(pq);
        System.out.print("remove " + pq.remove()+": ");
        System.out.println(pq);
        System.out.print("remove " + pq.remove()+": ");
        System.out.println(pq);
        System.out.print("remove " + pq.remove()+": ");
        System.out.println(pq);
    }
}
/* expected output(inClass practice 05/29/2018)
add 7: [7]
add 2: [2, 7]
add 5: [2, 7, 5]
add 1: [1, 2, 5, 7]
remove 1: [2, 7, 5]
remove 2: [5, 7]
remove 5: [7]
remove 7: []
*/

/* Sample output (Assignment 7)
1 Add 78: [78]
2 Add 54: [54, 78]
3 Remove 54: [78]
4 Add 39: [39, 78]
5 Remove 39: [78]
6 Remove 78: [ ]
7 Add 94: [94]
¡¦
30 Add [6]: [6, 13, 8, 29, 26, 27, 24, 54, 36, 70, 39, 54, 45, 62, 31]

*/