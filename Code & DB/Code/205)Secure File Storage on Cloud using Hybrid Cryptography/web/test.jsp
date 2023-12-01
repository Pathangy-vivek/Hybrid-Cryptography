

<%@page import="action.DESDecryption"%>
<%

String data = "CQTz0BeMgUA=";
String dkey = "DESKey@fffe79ce";
   
       
    
    String decryptedtext = new DESDecryption().decrypt(data, dkey);
    
   out.println("Decryption---------"+decryptedtext);






%>