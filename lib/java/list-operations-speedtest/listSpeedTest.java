/*
Matt Graham     5/29/18
This program compares operations performed by a LinkedList and an ArrayList.
 */

import java.util.*;

public class listSpeedTest {

    public static final int COUNTMAX = 6000000;
    static int randHigh = 9999;

    static Random rnd = new Random();

    static LinkedList<Integer> linkedTest = new LinkedList<>();
    static ArrayList<Integer> arrayTest = new ArrayList<>();

    static double startTime;
    static ArrayList<Double> linkedTime = new ArrayList<>();
    static ArrayList<Double> arrayTime = new ArrayList<>();

    public static void main (String[] args) {
        addArrayList();
        addLinkedList();
        getArrayList();
        getLinkedList();
        setArrayList();
        setLinkedList();
        removeLinkedList();
        removeArrayList();
        compareLists();
    }

    // adds COUNTMAX amount of elements to an ArrayList and times it calling two methods.
    //startTime() and endTime()
    public static void addArrayList() {
        int count = 0;          //keeps track of number of elements

        startTime();            //starts time clock

        while (count < COUNTMAX) {          //keep adding random numbers for each count < COUNTMAX
            int num = rnd.nextInt(randHigh);
            arrayTest.add(num);
            count++;
        }

        double totalTime = endTime ();

        arrayTime.add(totalTime);       //adds the amount of time it took to finish task and add it to ArrayList to obtain average at end

        System.out.println(count + " Total elements added to the ArrayList.");
        System.out.println("Time: " + totalTime);
    }

    public static void addLinkedList() {
        int count = 0;

        startTime();

        while (count < COUNTMAX) {
            int num = rnd.nextInt(randHigh);
            linkedTest.add(num);
            count++;
        }

        double totalTime = endTime();

        linkedTime.add(totalTime);              //adds amount of time to complete task to an ArrayList to obtain an average later

        System.out.println(count + " Total elements added to the LinkedList.");
        System.out.println("Time: " + totalTime);
    }
    //gets 1000 elements from arrayTest and returns them to the for-loop
    public static void getArrayList() {
        startTime();

        for (int i = 0; i < 1000; i++) {            //get 1000 integers from arrayTest
            int num = rnd.nextInt(COUNTMAX);
            int j = arrayTest.get(num);
        }

        double totalTime = endTime();
        arrayTime.add(totalTime);       //adds time to arrayTime

        System.out.println("1000 Elements in the ArrayList retrieved in: " + totalTime + "s");
    }

    public static void getLinkedList() {
        startTime();

        for (int i = 0; i < 1000; i++) {        //get 1000 elements from linkedTest
            int num = rnd.nextInt(COUNTMAX);
            int j = linkedTest.get(num);
        }

        double totalTime = endTime();
        linkedTime.add(totalTime);          //adds time to totalTime

        System.out.println("1000 elements in the LinkedList were retrieved in: " + totalTime + "s");
    }
//  sets 1000 elements to a random number at a random position
    public static void setArrayList() {
        startTime();

        for (int i = 0; i < 1000; i++) {
            int index = rnd.nextInt(COUNTMAX);  //random index
            int num = rnd.nextInt(randHigh);    //random number

            arrayTest.set(index, num);          //sets num at index to new num
        }

        double totalTime = endTime();
        arrayTime.add(totalTime);

        System.out.println("1000 elements in the ArrayList have been changed in: " + totalTime + "s");
    }

    public static void setLinkedList() {
        startTime();

        for (int i = 0; i < 1000; i++) {
            int index = rnd.nextInt(COUNTMAX);
            int num = rnd.nextInt(randHigh);

            linkedTest.set(index, num);
        }

        double totalTime = endTime();
        linkedTime.add(totalTime);

        System.out.println("1000 elements in the LinkedList have been changed in: " + totalTime + "s");
    }
//removes 1000 elements from ArrayList
    public static void removeArrayList() {
        startTime();

        for (int i = 0; i < 1000; i++) {
            int index = rnd.nextInt(arrayTest.size());
            arrayTest.remove(index);
        }

        double totalTime = endTime();
        arrayTime.add(totalTime);

        System.out.println("1000 elements removed in the ArrayList in: " + totalTime + "s");
    }

    public static void removeLinkedList() {
        startTime();

        for (int i = 0; i < 1000; i++) {
            int index = rnd.nextInt(linkedTest.size());
            linkedTest.remove(index);
        }

        double totalTime = endTime();
        linkedTime.add(totalTime);

        System.out.println("1000 elements removed in the LinkedList in: " + totalTime + "s");
    }

    public static void startTime() {
        startTime = System.currentTimeMillis();
    }

    public static double endTime() {
        double endTime = System.currentTimeMillis();
        double totalTime = endTime - startTime;
        return totalTime / 1000;
    }

    public static void compareLists() {
        double totalArray = 0;
        double totalLinked = 0;

        for (int i = 0; i < arrayTime.size(); i++) {
            totalArray += arrayTest.get(i);
        }

        for (int i = 0; i < linkedTime.size(); i++) {
            totalLinked += linkedTime.get(i);
        }

        double totalArrAvg = totalArray / arrayTime.size();
        double totalLinAvg = totalLinked / linkedTime.size();
        double diffProportion = totalArrAvg / totalLinAvg;
        double linkedProportion = 1 - diffProportion;

        if (diffProportion > 1) {
            System.out.println("ArrayList was " + diffProportion + " times faster than LinkedList");
        } else {
            System.out.println("LinkedList was " + linkedProportion + " times faster than ArrayList");
        }
    }

}
