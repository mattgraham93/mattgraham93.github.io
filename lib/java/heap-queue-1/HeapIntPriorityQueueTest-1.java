import java.util.Arrays;
import java.util.NoSuchElementException;
// Implements a priority queue of integers using a
// min-heap represented as an array.
public class HeapIntPriorityQueueTest {
    private int[] elementData;
    private int size;
    // Constructs an empty queue.
    public HeapIntPriorityQueueTest() {
        elementData = new int[10];
        size = 0;
    }
    // Adds the given element to this queue.
    public void add(int value) {
// resize if necessary
        if (size + 1 >= elementData.length) {
            elementData = Arrays.copyOf(elementData, elementData.length *
                    2);
        }
// insert as new rightmost leaf
        elementData[size + 1] = value;
// "bubble up" toward root as necessary to fix ordering
        int index = size + 1;
        boolean found = false;   // have we found the proper place yet?
        while (!found && hasParent(index)) {
            int parent = parent(index);
            if (elementData[index] < elementData[parent]) {
                swap(elementData, index, parent(index));
                index = parent(index);
            } else {
                found = true;  // found proper location; stop the loop
            }
        }
        size++;
    }

    // Returns true if there are no elements in this queue.
    public boolean isEmpty() {
        return size == 0;
    }
    // Returns the minimum value in the queue without modifying the queue.
// If the queue is empty, throws a NoSuchElementException.
    public int peek() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        return elementData[1];
    }
    // Removes and returns the minimum value in the queue.
// If the queue is empty, throws a NoSuchElementException.
    public int remove() {
        int result = peek();
// move rightmost leaf to become new root
        elementData[1] = elementData[size];
        size--;
// "bubble down" root as necessary to fix ordering
        int index = 1;
        boolean found = false;   // have we found the proper place yet?
        while (!found && hasLeftChild(index)) {
            int lChild = leftChild(index);          //get left child index
            int rChild = rightChild(index);         //get right child index

            if (elementData[lChild] <= elementData[rChild]) {       //if data in left child is less than data in right child
                int childResult = elementData[lChild];              //set @childResult to data in @lChild
                if (result <= childResult) {
                    swap(elementData, index, lChild);               //if the result is less than the child result, swap.
                }
            } else {
                found = true;
            }
        }

        return result;
    }
    // Returns the number of elements in the queue.
    public int size() {
        return size;
    }
// Returns a string representation of this queue, such as "[10, 20, 30]";
    // The elements are not guaranteed to be listed in sorted order.
    public String toString() {
        String result = "[";
        if (!isEmpty()) {
            result += elementData[1];
            for (int i = 2; i <= size; i++) {
                result += ", " + elementData[i];
            }
        }
        return result + "]";
    }
    // helpers for navigating indexes up/down the tree
    private int parent(int index) {
        return index / 2;
    }
    // returns index of left child of given index
    private int leftChild(int index) {
        return index * 2;
    }
    // returns index of right child of given index
    private int rightChild(int index) {
        return index * 2 + 1;
    }
    // returns true if the node at the given index has a parent (is not the root)
    private boolean hasParent(int index) {
        return index > 1;
    }
// returns true if the node at the given index has a non-empty left child
    private boolean hasLeftChild(int index) {
        return leftChild(index) <= size;
    }
// returns true if the node at the given index has a non-empty right child
    private boolean hasRightChild(int index) {
        return rightChild(index) <= size;
    }
    // switches the values at the two given indexes of the given array
    private void swap(int[] a, int index1, int index2) {
        int temp = a[index1];
        a[index1] = a[index2];
        a[index2] = temp;
    }
}