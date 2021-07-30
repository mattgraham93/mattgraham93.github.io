import java.util.*;

public abstract class Burger211 extends MenuGUI {

   static ArrayList<String> name = new ArrayList<String>();
   static ArrayList<String> topping = new ArrayList<String>();
   static ArrayList<Integer> cal = new ArrayList<Integer>();
   static ArrayList<Double> price = new ArrayList<Double>();
      
   public Burger211() {
      burgerName();
      burgerTopping();
      calVal();
      setPrice();
   }
   
   public void burgerName() {
      name.add("Interitance burger");
      name.add("Override burger");
      name.add("Constructor burger");
   }
   
   public void burgerTopping() {
      topping.add("beef patty, cheddar cheese, lettuce, tomato, onion, ketchup, mustard, mayo");
      topping.add("beef patty, bleu cheese, jalapeno, spicy mayo");
      topping.add("chicken patty, bacon, lettuce, tomato");
   }
   
   public void calVal() {
      cal.add(531);
      cal.add(795);
      cal.add(499);
   }
   
   public void setPrice() {
      price.add(3.59);
      price.add(5.29);
      price.add(4.99);
   }
   
   public abstract void printMenu(String franchise);
}
