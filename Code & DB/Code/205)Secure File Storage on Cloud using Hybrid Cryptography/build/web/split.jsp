
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyPair"%>

<%@page import="action.RSAEncryptio"%>
<%@page import="action.DESDecryption"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="action.RSADecryption"%>
<%@page import="action.JavaDESEncryption"%>
<%@page import="revocation.RSAEncryption"%>
<%@page import="action.DESEncryption"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%@page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>
<%@page import="action.encryption"%>
<%@page import="java.sql.*"%>
<%@page import="action.Dbconnection"%>
<%@ page session="true" %>
<%@page import="java.sql.Blob"%>

<%
    String email = request.getParameter("owner");    
    String data = request.getParameter("data");
    String fname = request.getParameter("fname");
    
    String parta = null;  String partb = null; String partc = null;
    
    int size = data.length();
    System.out.println("sizeeeee"+size);
    String blobb = null;
    int a = 0; int b = 0; int c = 0; int d = 0;
   
    try{
        
    int l=data.length();
    int len=data.length()/3;
    int length=data.length()/2;
    
    int s1 = len+len;    
    int k = s1+len;    
    int le = 1;
    
    
   
    String halfString=data.substring(0,len);
    String second = data.substring(len,s1);
    String third = data.substring(s1,l);
   
    System.out.println("First"+halfString);
    System.out.println("second"+second);
    System.out.println("third"+third);
    
    /* FIRST KEY GENERATION*/
                                 KeyGenerator keyGen = KeyGenerator.getInstance("AES");
                                keyGen.init(128);
                               SecretKey secretKey = keyGen.generateKey();
                                System.out.println("secret key:" + secretKey);                            
                                byte[] be = secretKey.getEncoded();
                               String skey = Base64.encode(be);
                               
                               System.out.println("First KEY--------"+skey);
                               
                               /* END */
                               
                               
                               
                               /* SECOND KEY GENERATION*/
                               
                                KeyGenerator keyGen1 = KeyGenerator.getInstance("AES");
                                keyGen1.init(128);
                                SecretKey secretKey1 = keyGen1.generateKey();
                                byte[] be1 = secretKey1.getEncoded();
                                String skey1 = Base64.encode(be1);
                                System.out.println("SECOND KEY---------"+skey1);
                          
                               
                               /* END */
                                
                                
                            
                                
                                
                                /* DES KEY */
                                
                                
                             SecretKey key = KeyGenerator.getInstance("DES").generateKey();
                             
                             System.out.println("DESssssssss"+key);
 
                             byte[] bew = key.getEncoded();//encoding secretkey
                             String skey11 = Base64.encode(bew);
                             
                              System.out.println("DESssssssss2"+skey11);
                                
                                
                              /* END  */
                               
                              
                              
                            /* DES KEY 2*/
                                
                                
                             SecretKey key1 = KeyGenerator.getInstance("DES").generateKey();
                             
                             System.out.println("DESssssssss"+key);
 
                             byte[] bew1 = key.getEncoded();//encoding secretkey
                             String skey3 = Base64.encode(bew1);
                             
                            
                                
                                
                              /* END  */  
                              
                              
                              
                              
                              
                               
                               /* THIRD KEY GENERATION*/
                               
                               KeyGenerator keyGen2 = KeyGenerator.getInstance("AES");
                               keyGen2.init(128);
                               SecretKey secretKey2 = keyGen2.generateKey();
                               byte[] be2 = secretKey2.getEncoded();
                               String skey2 = Base64.encode(be2);
                               System.out.println("THIRD KEY----------"+skey2);
                               
                               
                               /* END */
                             
   /*  eNcryption */ 
                               
    String first = new encryption().encrypt(halfString, secretKey);    
    String second1 =  new encryption().encrypt(third, secretKey1);
    //String second2 =  new encryption().encrypt(third, secretKey2);
    
    
    String des = new DESEncryption().encrypt(second, key);
    System.out.println("DES ENCRYPTion----------"+des);
    /*
    String des1 = new DESEncryption().encrypt(third, key1);
    System.out.println("DES ENCRYPTion----------"+des1);
    */
    
    
    
   
    //rsa encryption  code
    RSAEncryptio rsa = new RSAEncryptio();    
    KeyPair keyPair = rsa.buildKeyPair();     
    PrivateKey privateKey = keyPair.getPrivate();   
    byte[] encrypted =rsa.encrypt(privateKey,third);   
    System.out.println(" rsa encrypted data...."+new String(encrypted));
      
      // String skey3 = Base64.encode(privateKey);
      //rsa decryption code 
      
      PublicKey pubKey = keyPair.getPublic();
      RSAEncryptio rsa1 = new RSAEncryptio();  
      
      byte[] dec = rsa1.dec(pubKey,encrypted);
      
      System.out.println("rsa decrypted data"+new String(dec)); 
       
    
    Connection con=Dbconnection.getConnection();

PreparedStatement ps=con.prepareStatement("insert into cloudadata values(?,?,?,?,?,?,?,?,?)");
ps.setString(1,fname);
ps.setString(2,email);
ps.setString(3,first);
ps.setString(4,skey);
ps.setString(5,des);
ps.setString(6,skey11);
ps.setString(7,second1);
ps.setString(8,skey1);

ps.setString(9,data);


ps.executeUpdate();

    
    
   
    /*  end */
                            
    System.out.println("First----"+first);
    System.out.println("second---"+second);
   // System.out.println("third----"+second2);
    
    
   
response.sendRedirect("ownerviewfiles.jsp?m1=success");
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
    }
    catch(Exception e)
    {
        System.out.println("Error in emplogact"+e.getMessage());
    }
%>