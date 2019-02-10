import java.util.*;
import java.text.DecimalFormat;
import java.math.RoundingMode;

public class KOREA extends Burger211 {
   private String ad = "Join us for 50% off the entire menu!"; 
   private final double EXCHANGERATE = 1076.15;
   private final double DISCOUNT = 0.5;
   private ArrayList<Double> converted = new ArrayList<>();
   private String b1Info, b2Info, b3Info;
   private static DecimalFormat df2 = new DecimalFormat(".##");
   
   public void KOREA() {
   }
   
   public ArrayList<Double> convertWon() {
      for (int i = 0; i < price.size(); i++) {
         converted.add(price.get(i) * EXCHANGERATE);
      }
      return converted;
   }  
        
   public void printMenu(String franchise) {
      convertWon();
      b1Info = name.get(0) + " / " + "Originally: " + df2.format(converted.get(0)) + " Won" + ", NOW: " + df2.format(converted.get(0) * DISCOUNT) + " / " + cal.get(0) + " KCal";
      b2Info = name.get(1) + " / " + "Originally: " + df2.format(converted.get(1)) + " Won" + ", NOW: " + df2.format(converted.get(1) * DISCOUNT) +  " / " + cal.get(1) + " KCal";
      b3Info = name.get(2) + " / " + "Originally: " + df2.format(converted.get(2)) + " Won" + ", NOW: " + df2.format(converted.get(2) * DISCOUNT) + " / " + cal.get(2) + " KCal"; 
      System.out.println(franchise);
      System.out.println(ad);
      System.out.println(b1Info);
      System.out.println(b2Info);
      System.out.println(b3Info);
   }
}