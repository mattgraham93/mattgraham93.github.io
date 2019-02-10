/*
Matt Graham         980492151
5/17/18             Late Submission
This program attempts and fails to arrange a statement into postfix and evaluate the postfix expression.
The goal was to read the statement as a string, arrange it's operands in order of importance, and finally,
use the new postfix statement string with the operands to perform math. Each time I would introduce '(', ')', '{', '}',
I would never be able to get the postfix expression as I was about to do without introducing that variable. I am choosing
to submit this as incomplete as I've worked on this since last week and it is now two days late. I ran out of time
attempting to fix my car after work, I am embarrassed to submit something so incomplete.
 */

import java.util.*;

public class Evaluation2K {

    static String[] Statement = {"(1 + 2) * 3 + 4"};
    static HashMap<Integer, String> errorMessage = new HashMap<>();
    static HashMap<Character, Character> pair = new HashMap<>();
    static ArrayList<Character> operands = new ArrayList<>();
    static String post = "";
    static int value;

    public static void main (String[] args) {
//        loadErrorMessage();
//        loadPair();
//        validatePair();
        loadOperands();
        postFixStatement();
    }

//    public static void loadErrorMessage(){          //some predetermined outcomes
//        errorMessage.put(1, "Syntax Error: Incomplete Expression: Unpaired )");
//        errorMessage.put(2, "Syntax Error: ')' expected");
//        errorMessage.put(3, "Syntax Error: '}' expected");
//        errorMessage.put(4, "Syntax Error: '(' expected");
//        errorMessage.put(5, "Syntax Error: '{' expected");
//        errorMessage.put(6, "Syntax Error: Invalid Expression Statement");
//    }

//    public static void loadPair(){	            //setting value to the keys
//        pair.put('(', ')');
//        pair.put('{', '}');
//    }
/*
This method is fairly self explanatory, it adds each acceptable operand into the ArrayList: operands. This will be used
throughout the program.
 */
    public static void loadOperands() {
        operands.add('+');
        operands.add('-');
        operands.add('*');
        operands.add('/');
        operands.add('(');
        operands.add('{');
        operands.add(')');
        operands.add('}');
    }
/*
This is imported from the previous assignment, I wanted to use it to ensure that the user has inputted a correct statement.
 */
//    public static void validatePair() {
//
//        for (int i = 0; i < Statement.length; i++){  // number of statements to be evaluated
//
//            System.out.println(Statement[i]);        //print the statement and create a new stack
//            Stack211g<Character> st = new Stack211g<>();
//
//            for (int j = 0; j < Statement[i].length(); j++) { //each character in the statement
//                char c = Statement[i].charAt(j); //setting the character to @param c
//
//                if (c == '(' || c == '{') { //if the char is either '(' or '{' then push to stack and increase count by 1
//                    st.push(c);
//                }
//
//                if (c == ')') { //if stack is empty, throw an error and break
//                    if (st.isEmpty()) {
//                        printError(j, 6);
//                        break;
//                    } else { // otherwise, pop the character and compare to it's keyed value
//                        char p = st.pop();
//                        if (pair.get(p) != c) { //if it doesn't match, throw an error
//                            printError(j, 3);
//                            break;
//                        }
//                    }
//                }
//
//                if (c == '}') { //if stack is empty, throw an error
//                    if (st.isEmpty()) {
//                        printError(j, 6);
//                        break;
//                    } else { //otherwise pop the character and compare to it's keyed values
//                        char p = st.pop();
//                        if (pair.get(p) != c) { //if it doesn't match, throw an error"
//                            printError(j, 2);
//                            break;
//                        }
//                    }
//                }
//                if (!st.isEmpty()) {
//                    printError(j, 1);
//                }
//            }
//        }
//    }
/*
postFixStatement is a method that will evaluate the statement given by the user and create a postfix statement.
Through this operation, it calls two other methods that will help it evaluate the postfix statement as well as return
the sum to the console. This will also print out the original statement, as well as print the postfix statement before
returning the sum to the user.
 */
    public static void postFixStatement() {

        for (int i = 0; i < Statement.length; i++) {             // number of statements to be evaluated

            System.out.println(Statement[i]);                   //print the statement and create a new stack
            Stack211g<Character> postFixStack = new Stack211g<>();

            for (int j = 0; j < Statement[i].length(); j++) {   //each character in the statement
                char c = Statement[i].charAt(j);                //setting the character to @param c

                if (c >= '0' && c <= '9') {
                    post += c + " ";
                }

                if (operands.contains(c)) {
                    if (postFixStack.isEmpty()) {
                        postFixStack.push(c);
                    } else {
                        checkChar(c, postFixStack);
                    }

                }
            }

            while (!postFixStack.isEmpty()) {
                post += postFixStack.pop();
            }

            System.out.println(post);

            evaluatePostFix(post);
        }
    }
/*
checkChar is a method called from each operand in the statement that the user has submitted. This was my attempt at using
another method to help solve a problem through recursion, needless to say, it is not fully thought-out. I'm going to keep
attempting to fix this in my free time.
 */
    public static void checkChar(char c, Stack211g<Character> postFixStack) {

        char check = ' ';

        if (!postFixStack.isEmpty()) {
            check = postFixStack.pop();
        }

        if (c == '(' || c == '{') {
            postFixStack.push(c);
        }

        if (c == '*' || c == '/') {
            postFixStack.push(check);
            postFixStack.push(c);
        }

        if (c == '+' || c == '-') {
            if (check == '*' || check == '/') {
                post += postFixStack.pop() + " " + check + " ";
                postFixStack.push(c);
            } else {
                postFixStack.push(check);
                postFixStack.push(c);
            }
        }

        if (c == ')' || c == '}') {
            if (check == '(' || check == '{') {
                postFixStack.push(check);
            } else {
                while (!postFixStack.isEmpty()) {
                    post += check + " ";
                    check += postFixStack.pop();
                    checkChar(check, postFixStack);
                }
            }
        }
    }
/*
A fairly straight-forward method. This is passed the string from postFixStatement and receives @post.
Once @s is obtained from postFixStatement, it will be cycled through, character by character. If the
character is an integer, it gets pushed to a new integer stack after being converted to an integer.
When we find an operand, we pop the top two numbers and move forward.
 */
    public static void evaluatePostFix(String s) {
        Stack211g<Integer> sum = new Stack211g<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            if (operands.contains(c)) {
                int num2 = sum.pop();
                int num1 = sum.pop();
                int total = 0;

                if (c == '+') {
                    total = num1 + num2;
                    sum.push(total);
                }
                if (c == '-') {
                    total = num1 - num2;
                    sum.push(total);
                }
                if (c == '*') {
                    total = num1 * num2;
                    sum.push(total);
                }
                if (c == '/') {
                    total = num1 / num2;
                    sum.push(total);
                }
            } else {
                sum.push(c - ' ');
            }
        }

    }

    /*
    This was also imported from the previous assignment. My goal was to continue filling this with more errors if I was able to
    design something that worked.
     */
//    public static void printError(int location, int errorNo){
//        for (int i = 0; i < location; i++) { //fill each position in the string with a space to identify location
//            System.out.print(" ");
//        }
//        System.out.println("^"); //print '^' in the correct location
//        System.out.print(errorMessage.get(errorNo)); //print error message
//        System.out.println(); //create space for next statement
//        System.out.println(); //create space for next statement
//    }

}
