import java.util.*;

public class Evaluation1SK {

 static HashMap<Integer, String> errorMessage = new HashMap<>(); // error messages
 static HashMap<Character, Character> pair = new HashMap<>(); // (-) {-}
 static String[] Statement = new String[5]; //limited to 5 spaces only
 
 public static void main(String[] args){
      loadErrorMessage();                   //loads all error messages into @errorMessage
      loadPair();                           //loads all pairs into @pair
      loadStatement();                      // loads all statements into @Statement
      evaluateStatement();                  // evaluates all statements in @Statement
  }
   
	public static void loadErrorMessage(){          //some predetermined outcomes
		errorMessage.put(1, "Syntax Error: Incomplete Expression: Unpaired )");	
        errorMessage.put(2, "Syntax Error: ')' expected");
        errorMessage.put(3, "Syntax Error: '}' expected");
        errorMessage.put(4, "Syntax Error: '(' expected");
        errorMessage.put(5, "Syntax Error: '{' expected");
        errorMessage.put(6, "Syntax Error: Invalid Expression Statement");
	}
   
   public static void loadPair(){	            //setting value to the keys
      pair.put('(', ')');
      pair.put('{', '}');
   }

   public static void loadStatement() {         //a few test statements
     Statement[0] = "()()()(){)";
     Statement[1] = "}{}{}";
     Statement[2] = "({({})){)";
     Statement[3] = "(({{}{}){})";
     Statement[4] = "()()(){}(}(}";
   }

   public static void evaluateStatement() {     //the meat and potatoes

     int count = -1;    //use this to determine validate our empty stack

       for (int i = 0; i < Statement.length; i++){  // number of statements to be evaluated

           System.out.println(Statement[i]);        //print the statement and create a new stack
           Stack211 st = new Stack211();

           for (int j = 0; j < Statement[i].length(); j++) { //each character in the statement
               char c = Statement[i].charAt(j); //setting the character to @param c

               if (c == '(' || c == '{') { //if the char is either '(' or '{' then push to stack and increase count by 1
                   st.push(c);
                   count++;
               }

               if (c == ')') { //if stack is empty, throw an error and break
                   if (st.isEmpty()) {
                       printError(j, 6);
                       break;
                   } else { // otherwise, pop the character and compare to it's keyed value
                       char p = st.pop();
                       if (pair.get(p) != c) { //if it doesn't match, throw an error
                           printError(j, 3);
                           break;
                       }
                       count--;
                   }
               }

               if (c == '}') { //if stack is empty, throw an error
                   if (st.isEmpty()) {
                       printError(j, 6);
                       break;
                   } else { //otherwise pop the character and compare to it's keyed values
                       char p = st.pop();
                       if (pair.get(p) != c) { //if it doesn't match, throw an error"
                           printError(j, 2);
                           break;
                       }
                       count--;
                   }
               }
           }
       }
   }

	public static void printError(int location, int errorNo){
        for (int i = 0; i < location; i++) { //fill each position in the string with a space to identify location
            System.out.print(" ");
        }
        System.out.println("^"); //print '^' in the correct location
        System.out.print(errorMessage.get(errorNo)); //print error message
        System.out.println(); //create space for next statement
        System.out.println(); //create space for next statement
	}
}

