/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;
 import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
/**
 *
 * @author user
 */
public class RSAEncryptio {
    
    
   
  public static byte[] encrypt(PrivateKey privateKey, String message) throws Exception {
       Cipher cipher = null;
        try {
       cipher = Cipher.getInstance("RSA");  
        cipher.init(Cipher.ENCRYPT_MODE, privateKey);  
        }
         catch (Exception e) {
            System.out.println(e);
        
     }
         
        return cipher.doFinal(message.getBytes());  
  }
  
  
  public static byte[] dec(PublicKey publicKey, byte [] encrypted) throws Exception{
     
       Cipher cipher = null;
      try {
          
      cipher = Cipher.getInstance("RSA");  
        cipher.init(Cipher.DECRYPT_MODE, publicKey);
      }
       catch (Exception e) {
            System.out.println(e);
        
     }
      return cipher.doFinal(encrypted);
  }
    
   
    public static KeyPair buildKeyPair() throws NoSuchAlgorithmException {
        final int keySize = 2048;
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(keySize);      
        return keyPairGenerator.genKeyPair();
    }

  
}

