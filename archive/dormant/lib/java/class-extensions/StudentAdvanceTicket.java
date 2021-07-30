public class StudentAdvanceTicket extends AdvanceTicket {
   private double price;
   private int numDays;
   private String id = "(ID Required)";
   
   public void StudentAdvanceTicket(int ticketNum, int numDays) {
      this.ticketNum = ticketNum;
      this.numDays = numDays;
      
      if (this.numDays >= 10) {
         this.price = 15.0;
         ticketNum++;
      } else {
         this.price = 20.0;
         ticketNum++;
      }
   }
   
   public String toString() {
      return "Number: " + this.ticketNum + ", Price:" + this.price + " " + id;
   }
}