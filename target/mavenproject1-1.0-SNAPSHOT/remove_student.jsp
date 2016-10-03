<%-- 
    Document   : remove_student.jsp
    Created on : Oct 3, 2016, 12:13:59 AM
    Author     : pooja
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ResourceBundle" %>

 
<% 


   Class.forName("com.mysql.jdbc.Driver"); 
    ResourceBundle resource = ResourceBundle.getBundle("mysql");
    Connection con = DriverManager.getConnection("jdbc:mysql://"+ resource.getString("mysql_endpoint") +"/" + resource.getString("database"), resource.getString("username"), resource.getString("password")); 
    Statement st = con.createStatement(); 
   
 String id = request.getParameter("id");
   String sql = "DELETE FROM student WHERE id = ?";

PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(id));

ps.executeUpdate();
 st.close();
    con.close();
%>