<%--
  Created by IntelliJ IDEA.
  User: Saken
  Date: 21.06.2016
  Time: 22:10
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<% Class.forName("org.postgresql.Driver"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.css.map" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap.css.map" rel="stylesheet" media="screen">
    <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" media="screen">
</head>
<body>
<%!
    public class PostgreSqlDelete{
        Connection c = null;
        PreparedStatement delBD = null;
        ResultSet resultSet = null;

        public PostgreSqlDelete(int id){
            try {
                Class.forName("org.postgresql.Driver");
                c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "123456");
                delBD = c.prepareStatement("DELETE FROM postgres.public.test WHERE id = ?");
                delBD.setInt(1,id);
                delBD.executeUpdate();
            }catch (Exception e ){
                e.printStackTrace();
            }


        }

    }

    public class PostgreSqlSelect{
        Connection c = null;
        ResultSet resultSet = null;
        PreparedStatement seleDB = null;

        public PostgreSqlSelect(int id) {

            try {
                c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
                        "postgres", "123456");

                seleDB = c.prepareStatement("SELECT *FROM postgres.public.test WHERE id = ?");
                seleDB.setInt(1,id);
            }catch (Exception e ){
                e.printStackTrace();

            }
        }
        public ResultSet getPostgreSqlSelect(){
            try {
                resultSet=seleDB.executeQuery();
            }catch (Exception e){
                e.printStackTrace();

            }
            return resultSet;
        }


    }
%>
<%
    String strID = new String();
    strID = request.getParameter("id");
    Integer id;
    id = Integer.parseInt(strID);

    PostgreSqlSelect selpos = new PostgreSqlSelect(id);

    ResultSet selposs = selpos.getPostgreSqlSelect();

    if(request.getParameter("del")!=null){

        PostgreSqlDelete delpos = new PostgreSqlDelete(id);}
    if(request.getParameter("selt")!=null) {
    response.sendRedirect("index.jsp");
    }
%>
<h1><%= request.getParameter("id")%></h1>
<form method="post"  >
<table class="table table-striped">
<thead>
<tr>
    <th>Id:</th>
    <th>Name:</th>
    <th>Surname:</th>
    <th>Phone</th>
    <th>Address</th>
    <th>Email</th>
</tr>
</thead>
    <tbody>
    <% while (selposs.next()){%>
    <tr>
        <td><%= selposs.getInt("id")%></td>
        <td><%= selposs.getString("name")%></td>
        <td><%= selposs.getString("surname")%></td>
        <td><%= selposs.getString("phone")%></td>
        <td><%= selposs.getString("adress")%></td>
        <td><%= selposs.getString("email")%></td>
    </tr>
    <%}%>
    </tbody>
</table>
    <input type ="submit" value="Delete" name ="del"/>
    <input type ="submit" value="Select" name ="selt"/>
</form>

</body>
</html>
