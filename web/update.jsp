<%--
  Created by IntelliJ IDEA.
  User: Saken
  Date: 21.06.2016
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
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
    public class PostgreSQLSelect{
        Connection c = null;
        PreparedStatement  presel = null;
        ResultSet resultSet = null;

        public PostgreSQLSelect(int id){
            try {
                Class.forName("org.postgresql.Driver");
                c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres","123456");
                presel = c.prepareStatement("SELECT * FROM postgres.public.test WHERE id= ?");
                presel.setInt(1,id);
            }catch (Exception e){
                e.printStackTrace();
            }

        }

        public ResultSet getPostgreSQLSelect(){
            try {
                resultSet =presel.executeQuery();
            }catch (Exception e){
                e.printStackTrace();
            }

            return resultSet;
        }

    }

    public class PostgreUpdate{
        Connection c = null;
        PreparedStatement upst = null;
        ResultSet resultSet = null;
        public PostgreUpdate(int id,String name,String surname,String phone, String address,String email){
            try {
                Class.forName("org.postgresql.Driver");
                c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres","123456");
                upst = c.prepareStatement("UPDATE postgres.public.test Set name = ?, surname = ?, phone = ?, adress = ?, email = ?"+" WHERE id = ?");

                upst.setString(1,name);
                upst.setString(2,surname);
                upst.setString(3,phone);
                upst.setString(4,address);
                upst.setString(5,email);
                upst.setInt(6,id);
                upst.executeUpdate();
            }catch (Exception e){
                e.printStackTrace();
            }

        }
    }
%>
<%
    String name = new String();
    String surname = new String();
    String phone = new String();
    String address = new String();
    String email = new String();

    String strID = new String();
    strID = request.getParameter("id");
    Integer id;
    id = Integer.parseInt(strID);

    if(request.getParameter("update")!=null){
    if(request.getParameter("id")!=null){
        if(request.getParameter("name")!=null){
            name = request.getParameter("name");
            if(request.getParameter("surname")!=null){
                surname = request.getParameter("surname");
                if(request.getParameter("phone")!=null){
                    phone = request.getParameter("phone");
                    if(request.getParameter("address")!=null){
                        address = request.getParameter("address");
                        if(request.getParameter("email")!=null){
                            email = request.getParameter("email");
                            PostgreUpdate uppos = new PostgreUpdate(id,name,surname,phone,address,email);

                        }
                    }
                }
            }
        }
    }

    }
    if(request.getParameter("select")!=null){
        response.sendRedirect("index.jsp");
    }

    PostgreSQLSelect selpos = new PostgreSQLSelect(id);
    ResultSet selposs = selpos.getPostgreSQLSelect();


%>
    <h1><%= request.getParameter("id")%></h1>
    <form method="post">
    <table class="table table-striped">
        <% while (selposs.next()) {%>
        <tr>
            <td>ID:</td>
           <td><input type="text" value="<%= selposs.getInt("id")%>" name="id" readonly/></td>
        </tr>
        <tr>
            <td>Name:</td>
            <td><input type="text" value="<%= selposs.getString("name")%>" name="name"/></td>
        </tr>
        <tr>
            <td>Surname:</td>
            <td><input type="text" value="<%= selposs.getString("surname")%>" name="surname"/></td>
        </tr>
        <tr>
            <td>Phone:</td>
            <td><input type="text" value="<%= selposs.getString("phone")%>" name="phone"/></td>
        </tr>
        <tr>
            <td>Address:</td>
            <td><input type="text" value="<%= selposs.getString("adress")%>" name="address"/></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><input type="text" value="<%= selposs.getString("email")%>" name="email"/></td>
        </tr>
        <%}%>
    </table>
    <input type="submit" value="Update" name = "update"/>
    <input type="submit" value="Select" name = "select"/>

    </form>
</body>
</html>
