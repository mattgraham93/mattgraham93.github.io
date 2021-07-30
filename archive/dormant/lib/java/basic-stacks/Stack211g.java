public class Stack211g <T> {

    public int stackTop; //keep track of the top of the stack
    public Object[] myStack = new Object[40]; //new char array for our use in this implementation

    public Stack211g() { //constructor, sets @param stackTop to -1
        stackTop = -1;
    }

    public void push(T c) { //increases @stackTop by +1, puts char in @myStack in position at stackTop.
        stackTop++;
        myStack[stackTop] = c;
    }

    public Object pop() { //removes top element of @myStack, returns Object<T> to method
        Object c = myStack[stackTop];
        stackTop--;
        return c;
    }

    public boolean isEmpty() { //tests to see if the top of the queue is at >0 or -1.
        if (stackTop < 0) {
            return true;
        } else {
            return false;
        }
    }
}