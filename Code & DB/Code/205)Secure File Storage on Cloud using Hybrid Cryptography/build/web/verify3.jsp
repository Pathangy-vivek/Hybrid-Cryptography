<%@page import="java.util.Scanner"%>
<%@page import="java.io.File"%>
<%@page import="action.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
     ResultSet rs1 = null;
    String filename = request.getParameter("filename");
   Statement st1 = null;
   
  // HttpSession ses=request.getSession(true);
            //String email=ses.getAttribute("email").toString();
  //String polatt1 = "D:/keypolicy_attri.txt";
    String dkey = request.getParameter("dkey");
    try {
            
      
        con = Dbconnection.getConnection();
        st = con.createStatement();
         st1 = con.createStatement();
        rs = st.executeQuery("select * from cloudadata where filename='" + filename + "' and skey2 = '"+dkey+"'");
           
     //  rs1 =st1.executeQuery("select * from upload where filename='" + filename + "'");
       
        
        if (rs.next()) {
            
            String owner = rs.getString("owner");
            
            session.setAttribute("owner", owner);
            
           
            
               
               response.sendRedirect("download4.jsp?" + filename + " ");
            }
            else 
            {
                response.sendRedirect("download.jsp?dmsg=kerys are not matched");
            }
            
            
        
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>