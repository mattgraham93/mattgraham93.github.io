import java.util.*;
import java.io.*;

public class Word211 {
   
   public static ArrayList<String> words = new ArrayList<>();
   
   public void readFile(String fileName) throws FileNotFoundException {
      
      File inputFile = new File(fileName);
      Scanner readFile = new Scanner(inputFile);
      
      while (readFile.hasNextLine()) {
         String s = readFile.next();
         words.add(s);
      }
   }
   
   //return question and answer
   public static HashMap<String, String> getNextWord() {
      Random rnd = new Random();
      int index = rnd.nextInt(words.size());
      String answer = words.get(index);
      
      List<String> temp = Arrays.asList(answer.split(""));
      Collections.shuffle(temp);
      String question = "";
      
      for (int i = 0; i < temp.size(); i++) {
         question += temp.get(i);
      }
      
      HashMap<String, String> hm = new HashMap<>();
      hm.put(question, answer);
      return hm;
   }
}
   