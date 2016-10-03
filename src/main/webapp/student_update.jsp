<%-- 
    Document   : student_update
    Created on : Oct 3, 2016, 1:34:59 AM
    Author     : pooja
--%>
 <%@ page import="java.sql.*" %>
<%@ page import="java.util.ResourceBundle" %>

<% 
   Class.forName("com.mysql.jdbc.Driver"); 
    ResourceBundle resource = ResourceBundle.getBundle("mysql");
    Connection con = DriverManager.getConnection("jdbc:mysql://"+ resource.getString("mysql_endpoint") +"/" + resource.getString("database"), resource.getString("username"), resource.getString("password")); 
    Statement st = con.createStatement(); 
   
 String id = request.getParameter("studentid");
 String firstName = request.getParameter("firstname"); 
 String lastName = request.getParameter("lastname"); 
    String email = request.getParameter("email"); 
    String address = request.getParameter("address");
    String gpa = request.getParameter("gpa");
 
   String sql = "UPDATE student set firstname = ?, lastname=? , email=?, address=?, gpa=? WHERE id =?";

  PreparedStatement ps = con.prepareStatement(sql);
  ps.setString(1,firstName);
  ps.setString(2,lastName);
  ps.setString(3,email);
  ps.setString(4,address);
  ps.setDouble(5,Double.parseDouble(gpa)); 
  ps.setInt(6, Integer.parseInt(id));

ps.executeUpdate();
 st.close();
    con.close();
    response.sendRedirect("index.jsp"); 
%>