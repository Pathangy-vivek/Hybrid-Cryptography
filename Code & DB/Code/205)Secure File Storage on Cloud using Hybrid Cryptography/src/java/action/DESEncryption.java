/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
 
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
 
import com.sun.mail.util.BASE64DecoderStream;
import com.sun.mail.util.BASE64EncoderStream;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import javax.crypto.spec.SecretKeySpec;
 
public class DESEncryption {
 
    private static Cipher ecipher;
    private static Cipher dcipher;
 
    private static SecretKey key;
    
    
    
    
    
     public String encrypt(String text, SecretKey secretkey) {
         String cipherText = null;
         try {
          
 
            ecipher = Cipher.getInstance("DES");
           
 
            // initialize the ciphers with the given key
 
  ecipher.init(Cipher.ENCRYPT_MODE, secretkey);
  
  byte[] utf8 = text.getBytes("UTF8");
  
 
byte[] enc = ecipher.doFinal(utf8);
 
// encode to base64
 
enc = BASE64EncoderStream.encode(enc);
         
        
 cipherText = new String(enc);
  
 
  } catch (Exception e) {
            System.out.println(e);
        
     }
       
     return cipherText;     
}
     
     
      public String dec(String text, String secretkey) {
         String cipherText = null;
         try {
             
             
              byte[] bs = Base64.decode(secretkey);
            SecretKey sec = new SecretKeySpec(bs, "DES");
          
               dcipher = Cipher.getInstance("DES");
               dcipher.init(Cipher.DECRYPT_MODE, sec);
              byte[] dec = BASE64DecoderStream.decode(text.getBytes());
 
byte[] utf8 = dcipher.doFinal(dec);
 
// create new string based on the specified charset
 
return new String(utf8, "UTF8");
 
  }
 
  catch (Exception e) {
 
    e.printStackTrace();
 
  }
 
  return null;
 
    }
             
  
 
 
}