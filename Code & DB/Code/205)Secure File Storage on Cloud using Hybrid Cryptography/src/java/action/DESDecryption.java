/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.security.spec.AlgorithmParameterSpec;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Decoder;

/**
 *
 * @author dell
 */
public class DESDecryption {
    
     private static Cipher decrypt;
    private static final byte[] initialization_vector = { 22, 33, 11, 44, 55, 99, 66, 77 };
     public String decrypt(String data, String dkey) {
        String decryptedtext = null;
        try {

             //converting string to secretkey
            byte[] bs = Base64.decode(dkey);
            SecretKey sec = new SecretKeySpec(bs, "DES");
            System.out.println("converted string to seretkey:" + sec);

            System.out.println("secret key:" + sec);
             AlgorithmParameterSpec alogrithm_specs = new IvParameterSpec(
                    initialization_vector);
            
            // set decryption mode
            decrypt = Cipher.getInstance("DES/CBC/PKCS5Padding");
            decrypt.init(Cipher.DECRYPT_MODE, sec, alogrithm_specs);
            
            
           

            byte[] byteCipherText = new BASE64Decoder().decodeBuffer(data); //encrypting data 

            
            byte[] byteDecryptedText = decrypt.doFinal(byteCipherText);
            decryptedtext = new String(byteDecryptedText);

            System.out.println("Decrypted Text:" + decryptedtext);
        } catch (Exception e) {
            System.out.println(e);
        }
        return decryptedtext;
    }

    
}
