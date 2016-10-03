<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ResourceBundle" %>

<html>
    <head>
      <link rel='stylesheet' href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
      <script type="text/javascript" src="webjars/jquery/2.1.1/jquery.min.js"></script>
      <script type="text/javascript" src="webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <h1 align="center">Student database Mangement</h1>
        
        <br>
        <br>
        <%  
          Class.forName("com.mysql.jdbc.Driver"); 
          ResourceBundle resource = ResourceBundle.getBundle("mysql");
          Connection con = DriverManager.getConnection("jdbc:mysql://"+ resource.getString("mysql_endpoint") +"/" + resource.getString("database"), resource.getString("username"), resource.getString("password")); 
          Statement st = con.createStatement(); 
           String query = "SELECT * FROM student";

            // execute the query, and get a java resultset
            ResultSet rs = st.executeQuery(query);
%>
<table class="table table-striped">
     <thead>
            <tr>
            <th>ID</th>
            <th> First Name</th>
            <th> Last Name</th>
            <th> Email</th>
            <th>Address</th>
            <th>GPA</th>
            
            </tr>
     </thead>
        <%
            // iterate through the java resultset
            while (rs.next())
            {
              int id = rs.getInt("id");
              String firstName = rs.getString("firstname");
              String lastName = rs.getString("lastname");
              String email= rs.getString("email");
              String address= rs.getString("address");
              double gpa = rs.getDouble("gpa");
        %>
       
            <tr>
                
                <td class="idCell"><%= id %></td>
                <td class="fnameCell"><%= firstName %></td>
                <td class="lnameCell"> <%= lastName %></td>
                <td class="emailCell"> <%= email %></td>
                <td class="addCell"><%= address %></td>
                <td class="gpaCell"><%= gpa %></td>
                <td class='deleterow'><div class='glyphicon glyphicon-remove'></div></td>
                <td><div class='glyphicon glyphicon-pencil' onclick="editClick(this)"></div></td>
            
                <input type="hidden" id="reservation_id" name="reservation_id" value="">
            </tr>
    <%                  
        }
        st.close();
        con.close();
    %>
    </table>
    <br>
     <button type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal">Add New Student</button>

     <div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
        <form action="student_registration.jsp" method="post">
      <div class="modal-body">
        <b> First Name </b>
        <input type="text" name='firstname'/><br>
        <b> Last Name </b>
        <input type="text" name='lastname'/><br>
        <b> Email ID </b>
        <input type="text" name='email'/><br>
        <b> Address </b>
        <input type="text" name='address'/><br>
        <b> GPA </b>
        <input type="text" name='gpa'/><br>
      
      </div>
      <div class="modal-footer">
          <input class="btn btn-default" type='submit' value="Add Student"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        
      </div>
          </form>
    </div>

  </div>
        </div>
          <div id="myModal1" class="modal fade" role="dialog">
         <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
        <form action="student_update.jsp" method="post">
      <div class="modal-body">
          <b> ID </b>
          <input id="modalId" type="text" readonly name='studentid'/><br>
        <b> First Name </b>
        <input id="modalFname" type="text" name='firstname'/><br>
        <b> Last Name </b>
        <input id="modalLname" type="text" name='lastname'/><br>
        <b> Email ID </b>
        <input id="modalEmail" type="text" name='email'/><br>
        <b> Address </b>
        <input id="modalAdd" type="text" name='address'/><br>
        <b> GPA </b>
        <input id="modalGpa" type="text" name='gpa'/><br>
      
      </div>
      <div class="modal-footer">
          <input class="btn btn-default" type='submit' value="Update"/>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        
      </div>
          </form>
    </div>

  </div>
        </div>
        </div>
    <script>
        $(".deleterow").on("click", function(){
        console.log("clicked");
        var killrow = $(this).parent('tr');
        var id = $(killrow).find(".idCell").html();
        console.log(id);
        $(killrow).addClass("danger");
        $(killrow).fadeOut(2000, function(){
         $(this).remove();
        $.ajax({
            type : "POST",
            url : "remove_student.jsp",
            data: { 
            'id': id
            },
            success : function(data) {
                console.log("deleted");
                 
            }
        });
     
       });
    });
    function editClick(elem) {

    var id= $(elem).closest("tr").find(".idCell").html();
    var fname= $(elem).closest("tr").find(".fnameCell").html();
    var lname= $(elem).closest("tr").find(".lnameCell").html();
    var email= $(elem).closest("tr").find(".emailCell").html();
    var add= $(elem).closest("tr").find(".addCell").html();
    var gpa= $(elem).closest("tr").find(".gpaCell").html();
    
    console.log(id);
    $("#modalId").val(id);
    $("#modalFname").val(fname);
    $("#modalLname").val(lname);
    $("#modalEmail").val(email);
    $("#modalAdd").val(add);
    $("#modalGpa").val(gpa);
    
    $('#myModal1').modal('toggle');
    }

    </script>
    </body>
</html>
