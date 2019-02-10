public class Stack211 {
    public int stackTop; //keep track of the top of the stack
    public char[] ch = new char[40]; //new char array for our use in this implementation

    public Stack211() { //constructor, sets @param stackTop to -1
        stackTop = -1;
    }

    public void push(char c) { //increases @stackTop by +1, puts char in @ch in position at stackTop.
        stackTop++;
        ch[stackTop] = c;
    }

    public char pop() { //removes top element of @ch, returns char to method
        char c = ch[stackTop];
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
