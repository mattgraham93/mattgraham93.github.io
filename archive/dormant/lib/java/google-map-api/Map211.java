// CS211, spring Quarter 2018
import java.io.*;
import java.net.URL;
import javax.swing.*;

public class Map211{

    Map211(String title,int width, int height, String latitude, String longitude,int zoom, int scale, String mapType, String mark, String outFile) {
  // example of marks="&markers=color:green%7Clabel:P%7C47.5853514523,-122.1482843411"; // Bellevue College
  // no space is allowed in the marks string
  
        JFrame map211 = new JFrame(title);
        map211.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        map211.setSize(width, height);
        map211.setLocationRelativeTo(null);
        map211.setVisible(true);

      try {           
        String imageUrl = "https://maps.googleapis.com/maps/api/staticmap?center=";
        imageUrl+= latitude+ ","+ longitude+ "&zoom=" + zoom + "&size=" + width + "x" + height+"&scale="+zoom+"&maptype="+mapType+mark;
        
        URL url = new URL(imageUrl);
        InputStream is = url.openStream();
        OutputStream os = new FileOutputStream(outFile);
        byte[] b = new byte[2048];
        
        int length;
         while ((length = is.read(b)) != -1) {
            os.write(b, 0, length);
         }
         is.close();
         os.close();
      } catch (IOException e) {
         e.printStackTrace();
         System.exit(1);
      }
  
      ImageIcon imageIcon = new ImageIcon((new ImageIcon(outFile)).getImage().getScaledInstance(width, height,java.awt.Image.SCALE_SMOOTH));  
      map211.add(new JLabel(imageIcon));
      map211.setVisible(true);
      map211.pack();   
  } 
}