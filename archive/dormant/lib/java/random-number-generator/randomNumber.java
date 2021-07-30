// Random Number Example
import java.util.*;

public class randomNumber {
   public static void main(String[] args) { 
      Random rand = new Random();
      int random1 = rand.nextInt(10);
      System.out.println(random1);
      int random2 = rand.nextInt(8) + 23;
      System.out.println(random2);
   }
   
   public char nextCh() {
      int n = nextInt(26) + 65;
      return (char)n;
   }
}