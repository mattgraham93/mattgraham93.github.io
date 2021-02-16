public class WalkupTicket extends Ticket {
   
   private double price = 50.0;
   
   public void WalkupTicket(int ticketNum) {
      this.ticketNum = ticketNum;
      this.price = price;
      ticketNum++;
   }
}