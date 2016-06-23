<%--
  Created by IntelliJ IDEA.
  User: Saken
  Date: 20.06.2016
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="javax.servlet.*"%>
<% Class.forName("org.postgresql.Driver"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Just Site number 2</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.css.map" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap.css.map" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" media="screen">
</head>
<body>
<%!
    public class PostgreSQLJDBC {

        Connection c = null;
        PreparedStatement insertBD = null;
        ResultSet resultSet = null;

        public PostgreSQLJDBC(){
            try{
                Class.forName("org.postgresql.Driver");
                c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres", "123456");
                insertBD = c.prepareStatement("INSERT INTO postgres.public.test(id,name,surname,phone,adress,email) VALUES(?,?,?,?,?,?)");
            }catch (Exception e){
                e.printStackTrace();
            }


        }
      public  int setPostgreSQLJDBC(int id,String name,String surname,String phone,String adress,String email){
        int result =0;
          try {
              insertBD.setInt(1, id);
              insertBD.setString(2, name);
              insertBD.setString(3, surname);
              insertBD.setString(4, phone);
              insertBD.setString(5, adress);
              insertBD.setString(6, email);
              result=insertBD.executeUpdate();
          }catch (Exception e){
              e.printStackTrace();
          }
    return result;
      }

    }
%>
<% int result =0;
if(request.getParameter("select") != null){
    response.sendRedirect("index.jsp");
    System.out.println("select");
}


    if(request.getParameter("creat") !=null) {
        Integer firstid = 1;
        String firstid1 = new String();
        String firstname = new String();
        String firstsurname = new String();
        String firstphone = new String();
        String firstadress = new String();
        String firstemail = new String();
        if(request.getParameter("id") !=null){
            firstid1 = request.getParameter("id");
            firstid =Integer.parseInt(firstid1);
        }
        if(request.getParameter("name") !=null){
            System.out.println("name aloooo");
        firstname = request.getParameter("name");
        }
        if(request.getParameter("surname") !=null){
        firstsurname = request.getParameter("surname");
        }
        if(request.getParameter("phone") !=null){
        firstphone = request.getParameter("phone");
        }
        if(request.getParameter("adress") !=null){
        firstadress = request.getParameter("adress");
        }
        if(request.getParameter("email") !=null){
        firstemail = request.getParameter("email");
        }
        PostgreSQLJDBC pos = new PostgreSQLJDBC();
        result = pos.setPostgreSQLJDBC(firstid,firstname,firstsurname,firstphone,firstadress,firstemail);
    }



%>

<form name =frmtel action="creat.jsp" method="post">
    <table class="table table-striped">
        <tr>
            <td> Id:</td>
            <td><input type="text" name="id"></td>
        </tr>
        <tr>
            <td> Name:</td>
            <td><input type="text" name="name"></td>
        </tr>
        <tr>
            <td>Surname:</td>
            <td><input type="text" name="surname"></td>
        </tr>
        <tr>
            <td> Phone:</td>
            <td><input type="text" name="phone"></td>
        </tr>
        <tr>
            <td>Adress:</td>
            <td><input type="text" name="adress"></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><input type="text" name="email"></td>
        </tr>

    </table>

    <input type="reset" value="Reset" name="reset" />
    <input type="submit" value="Creat" name="creat" />
    <input type="submit" value="Select" name="select" />
</form>
</body>
</html>
