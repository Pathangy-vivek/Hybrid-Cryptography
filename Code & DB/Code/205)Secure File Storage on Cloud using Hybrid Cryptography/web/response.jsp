<%@page import="action.Mail"%>
<%@page import="java.sql.*"%>
<%@page import="action.Dbconnection"%>
<%@page session="true" %>

<%   
String filename = request.getParameter("filename");
String owner = request.getParameter("owner");
String email = request.getParameter("email");

String skey3 = null;
String skey1 = null;
String skey2 = null;
String p1 = null;
String p2 = null;
String p3 = null;

try{
    int j =0;
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
              
              
              
            
            
            
      PreparedStatement ps=con.prepareStatement("update request set status= 'yes', s1='"+skey1+"', s2='"+skey2+"', s3='"+skey3+"', p1='"+p1+"', p2='"+p2+"', p3='"+p3+"' where filename='"+filename+"'and email='"+email+"' and owner = '"+owner+"'");      
    int i =  ps.executeUpdate();
      
            
         if(i>0){
             
              out.println("Success");
             
         }
         
         
            
            
            
       
              Mail m = new Mail();
          String msg ="File Name:"+filename+"\n cloud-a decryption key :"+rs1.getString("skey")+"  cloud-b decryption key : "+rs1.getString("skey1")+" cloud-c decryption key : "+rs1.getString("skey2")+"" ;     
          m.secretMail(msg,filename,email);
          response.sendRedirect("vuserreq.jsp?msg=success");
          
        
           }
      
      
         else{
             
             
             out.println("failed");
         }
       
       
    
      
     
    
} catch (Exception ex) {
out.println(ex);
   }
   %>
