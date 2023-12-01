<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="java.security.KeyPair"%>
<%@page import="action.RSAEncryptio"%>
<%@page import="java.security.PublicKey"%>
<%@page import="action.decryption"%>
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
   String filename = request.getQueryString();
   Statement st1 = null;
   String owner = session.getAttribute("owner").toString();

String skey3 = null;
String skey1 = null;
String skey2 = null;
String p1 = null;
String p2 = null;
String p3 = null;
String data = null;

    try {
            
      
        Connection con = Dbconnection.getConnection();
        String q = "select * from cloudadata where owner='"+owner+"' and filename='"+filename+"'";
        Statement st = con.createStatement();
        ResultSet rs1 = st.executeQuery(q);
        
        
        
        
        
        if(rs1.next())
        {
           
            skey1 = rs1.getString("skey");
            skey2 = rs1.getString("skey1");
            skey3 = rs1.getString("skey2");
            p1 = rs1.getString("f1");
            p2 = rs1.getString("f2");
            p3 = rs1.getString("f3");
            data = rs1.getString("data");
            
            
            
         
            
            String first = new decryption().decrypt(p1, skey1);    
   //          String second1 = new DESEncryption().encrypt(p2, skey2);
          String second2 =  new decryption().decrypt(p3, skey3);  
            
            
            
            byte[] bs = Base64.decode(skey2);
            SecretKey sec = new SecretKeySpec(bs, "DES");
            
             String des = new DESEncryption().dec(p2, skey2);
            /*
              byte[] bs1 = Base64.decode(skey3);
            SecretKey sec1 = new SecretKeySpec(bs1, "DES");
            
             String des1 = new DESEncryption().dec(p3, skey3);
            */
             
             
             
            System.out.println("dec11111"+first);
            System.out.println("dec22222"+des);
            System.out.println("dec33333"+second2);
            
          String fina = first+des+second2;
            
            System.out.println("Finalllllllll"+fina);
            
            
            
            
            /* RSA Decryption Starts*/
            
            
          
            
            String p = first+second2+des;
            
            
            
            /* END */
            
            
            
            
            
            
            
         //   System.out.println("dec33333"+dec);
            
             response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
            
           
            out.write(p);
            
              
       
            
               
          //response.sendRedirect("download.jsp");
            }
            else 
            {
                response.sendRedirect("download.jsp?dmsg=kerys are not matched");
            }
            
            
        
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>