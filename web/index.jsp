<%--
  Created by IntelliJ IDEA.
  User: Saken
  Date: 20.06.2016jj
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.httpclient.*"%>
<% Class.forName("org.postgresql.Driver"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Just Site number 1</title>
      <link href="bootstrap/css/bootstrap.css" rel="stylesheet" media="screen">
      <link href="bootstrap/css/bootstrap-theme.css" rel="stylesheet" media="screen">
      <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
      <link href="bootstrap/css/bootstrap-theme.css.map" rel="stylesheet" media="screen">
      <link href="bootstrap/css/bootstrap.css.map" rel="stylesheet" media="screen">
      <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" media="screen">

  </head>

  <javascript language="JavaScript" type="text/javascript">

  </javascript>
  <body>

  <h1>Tel Book </h1>
  <%!

      public class PostgreSQLJDBC {

          Connection c = null;
          PreparedStatement stmt = null;
          ResultSet resultSet = null;

          public PostgreSQLJDBC(){
              try{
                  Class.forName("org.postgresql.Driver");
                  c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
                                  "postgres", "123456");
                  stmt = c.prepareStatement("SELECT *FROM postgres.public.test");
              }catch (Exception e){
                  e.printStackTrace();
              }


          }
          public  ResultSet getPostgreSQLJDBC(){
              try {
                  resultSet=stmt.executeQuery();
              }catch (Exception e){
                  e.printStackTrace();

              }
              return resultSet;
          }
      }
  %>
  <%
      PostgreSQLJDBC pos = new PostgreSQLJDBC();
      ResultSet poss = pos.getPostgreSQLJDBC();
  %>

  <table class="table table-hover"  >
      <thead>
      <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Surname</th>
          <th>Phone</th>
          <th>Address</th>
          <th>Email</th>
          <th></th>
          <th></th>
      </tr>
      </thead>
      <tbody class="active">
      <% while(poss.next()){%>

      <tr>
          <td><%= poss.getInt("id")%> </td>
          <td><%= poss.getString("name")%></td>
          <td><%= poss.getString("phone")%></td>
          <td><%= poss.getString("surname")%></td>
          <td><%= poss.getString("adress")%></td>
          <td><%= poss.getString("email")%></td>
          <td><a href="update.jsp?id=<%= poss.getInt("id")%> ">edit</a> </td>
          <td><a href="delete.jsp?id=<%= poss.getInt("id")%> ">delete</a> </td>
      </tr>
      <% }%>
      </tbody>
  </table>

  <div style="margin-left: 50px;">
<input type="submit" value="Creat" name="creat"  class="btn btn-primary btn-md" onclick="location='creat.jsp'"/>
  </div>
  </body>
</html>
