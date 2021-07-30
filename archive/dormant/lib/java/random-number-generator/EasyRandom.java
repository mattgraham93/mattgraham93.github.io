/* 
Matt Graham
580492151
4/10/2018
*/

/*
This program is a subclass of the Random class in the Math class. 
The goal is to take two integers and return to the user the following:
nextInt, nextEven, nextOdd, nextChar, and nextSequence.
*/


import java.util.*;

public class EasyRandom extends Random {

   public int nextInt(int l, int h) {  //@l = lowest integer inputted by the user: @h = highest integer inputted by the user.
      return nextInt(l) + h;
   }
   
   public int nextEven(int h) {
      int result = nextInt(h);
      if (result % 2 == 0) {
         return result;
      } else {
         nextEven(h);
      }
      return result;
   }
   
   public int nextEven(int l, int h) {
      int result = nextInt(h) + l;
      if (result % 2 == 0) {
         return result;
      } else {
         nextEven(l, h);
      }
      return result;
   }
   
   public int nextOdd(int h) {
      int result = nextInt(h);
      if (result % 2 == 1) {
         return result;
      } else {
         nextOdd(h);
      }
      return result;
   }
   
   public int nextOdd(int l, int h) {
      int result = nextInt(h) + l;
      if (result % 2 == 1) {
         return result;
      } else {
         nextEven(l, h);
      }
      return result;
   } 
   
   public char nextChar() {
      int result = nextInt(26) + 65;
      return (char)result;
   }
   
   public char nextChar(char h) {
      int result = nextInt(26 + h) + 65;
      return (char)result;
   }
   
   public char nextChar(char l, char h) {
      int result = nextChar(h) + l;
      return (char)result;
   }
   
   public int nextSequence(int l, int h) {
      int result = nextInt(h) + l;
      boolean flag = false;
      
      if (h % 2 == 0) {
         flag = true;
      } 
      
      if (flag == true) {
         nextEven(l, h);
      } else {
         nextOdd(l, h);
         flag = false;
      }
      return result;
   }
}