import java.util.*;
import java.text.DecimalFormat;
import java.math.RoundingMode;
   
public class JAPAN extends Burger211 {
   private String ad = "Come here and have our sweet meat!";   
   private final double EXCHANGERATE = 108.97;
   private final double DISCOUNT = 0.0;
   private ArrayList<Double> converted = new ArrayList<>();
   private String b1Info, b2Info, b3Info;
   private static DecimalFormat df2 = new DecimalFormat(".##");
   
   public void JAPAN() {
   }
   
   public ArrayList<Double> convertYen() {
      for (int i = 0; i < price.size(); i++) {
         converted.add(price.get(i) * EXCHANGERATE);
      }
      return converted;
   } 
   public void printMenu(String franchise) {
      convertYen();
      b1Info = name.get(0) + " / " + df2.format(converted.get(0)) + " Yen" + " / " + cal.get(0) + " KCal";
      b2Info = name.get(1) + " / " + df2.format(converted.get(1)) + " Yen" + " / " + cal.get(1) + " KCal";
      b3Info = name.get(2) + " / " + df2.format(converted.get(2)) + " Yen" + " / " + cal.get(2) + " KCal"; 
      System.out.println(franchise);
      System.out.println(ad);
      System.out.println(b1Info);
      System.out.println(b2Info);
      System.out.println(b3Info);
   }
   
}