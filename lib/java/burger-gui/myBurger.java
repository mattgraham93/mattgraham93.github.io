public abstract class myBurger extends Burger211 {
   public static void main(String[] args) {
      Burger211 Bellevue = new USA();
      Bellevue.printMenu("Bellevue");
      
      Burger211 Seoul = new KOREA();
      Seoul.printMenu("Seoul");
      
      Burger211 Tokyo = new JAPAN();
      Tokyo.printMenu("Tokyo");
   }
}