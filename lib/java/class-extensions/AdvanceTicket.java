public class AdvanceTicket extends Ticket {

   private double price;
   private int numDays;
   
   public void AdvanceTicket(int ticketNum, int numDays) {
      this.ticketNum = ticketNum;
      this.numDays = numDays;
      
      if (this.numDays >= 10) {
         this.price = 30.0;
         ticketNum++;
      } else {
         this.price = 40.0;
         ticketNum++;
      }  
   }
}