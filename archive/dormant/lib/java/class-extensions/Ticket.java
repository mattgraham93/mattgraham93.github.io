import java.util.*;

public class Ticket {
   int ticketNum = 0;
   double price;
   
   public void Ticket(int ticketNum) {
      this.ticketNum = ticketNum;
      getPrice();
   }

   
   public double getPrice() {
      Scanner scan = new Scanner(System.in);
      System.out.println("Please enter ticket price: ");
      price = scan.nextDouble();
      return price;
   }
   
   public String toString() {
      return "Number: " + this.ticketNum + ", Price:" + this.price;
   }
}