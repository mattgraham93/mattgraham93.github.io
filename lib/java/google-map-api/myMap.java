/* 
Matt Graham
580492151
4/10/2018
*/

/*
This program tests the Map211 constructor file. 
Here, we are using my home in Bothell as our test. 
*/


public class myMap {

   static String title;
   static int width;
   static int height;
   static String mapCenterLat;
   static String mapCenterLon;
   static int zoom;
   static int scale;
   static String type;
   static String mark;
   static String outFile;

   public static void initialValue() {
      title = "Home";
      width = 800;
      height = 600;
      mapCenterLat = "47.746429"; //Bothell home
      mapCenterLon = "-122.181060"; //Bothell home
      zoom = 13;
      scale = 1;
      type = "roadmap";
      mark = "&markers=color:blue%7Clabel:P%7C47.746429,-122.181060";
      outFile = "myMap.jpg";
   }
   
   public static void main (String[] args) {  
      initialValue();   
      new Map211(title, width, height, mapCenterLat, mapCenterLon, zoom, scale, type, mark, outFile);   
   }
}