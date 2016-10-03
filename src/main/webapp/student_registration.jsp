<%@ page import="java.sql.*" %>
<%@ page import="java.util.ResourceBundle" %>

 
<% 
    String firstName = request.getParameter("firstname"); 
    String lastName = request.getParameter("lastname"); 
    String email = request.getParameter("email"); 
    String address = request.getParameter("address");
    String gpa = request.getParameter("gpa");
    Class.forName("com.mysql.jdbc.Driver"); 
    ResourceBundle resource = ResourceBundle.getBundle("mysql");
    Connection con = DriverManager.getConnection("jdbc:mysql://"+ resource.getString("mysql_endpoint") +"/" + resource.getString("database"), resource.getString("username"), resource.getString("password")); 
    Statement st = con.createStatement(); 
    int i = st.executeUpdate("insert into student( firstname, lastname, email, address,gpa)"
            + " values ('" + firstName + "','" + lastName + "','" + email + "','" + address + "'," + gpa + ")"); 
    
        response.sendRedirect("index.jsp"); 
    st.close();
    con.close();
    %>
   
  