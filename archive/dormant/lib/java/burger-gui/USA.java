public class USA extends Burger211 {

   private String ad = "Come clear your arteries with our delicious, fat-free food!";
   private String b1Info, b2Info, b3Info;
   
   public void USA() {
   }    
        
   public void printMenu(String franchise) {
      b1Info = name.get(0) + " / " + "$" + price.get(0) + " / " + cal.get(0) + " KCal";
      b2Info = name.get(1) + " / " + "$" + price.get(1) + " / " + cal.get(1) + " KCal";
      b3Info = name.get(2) + " / " + "$" + price.get(2) + " / " + cal.get(2) + " KCal";
      System.out.println(franchise); 
      System.out.println(ad);
      System.out.println(b1Info);
      System.out.println(b2Info);
      System.out.println(b3Info);
   }
}