import java.util.*;
import java.io.*;

public class myWord {
   
   static String answer = "";
   static String question = "";
   
   public static void main(String[] args) throws FileNotFoundException {
      Scanner cons = new Scanner(System.in);
      
      Word211 word = new Word211();
      word.readFile("FRUIT.txt");
      
      HashMap<String, String> hm = word.getNextWord();
      
      for (String q : hm.keySet()) {
         question = q;
         answer = hm.get(question);
      }

      System.out.println("Please unscramble this word");
      System.out.println(question);



      //game allows a total of three attempts, I tried to have it start again, but I couldn't get it to work.
      double startTime = System.currentTimeMillis();
      String userAnswer = cons.next();
      int count = 0;

      while (count < 2 && !userAnswer.equalsIgnoreCase(answer)) {
          System.out.println("Wrong! Please try again.");
          count++;
          userAnswer = cons.next();
      }

      if (count >= 2) {
          System.out.println("Too many tries! Sorry.");
      }

      if (userAnswer.equalsIgnoreCase(answer)) {
          System.out.println("You're right. Good job!");
      }
      
      double endTime = System.currentTimeMillis();
      double totalTime = endTime - startTime;
      
      System.out.println("Response Time: " + totalTime/1000.0 + "sec");
   }
}