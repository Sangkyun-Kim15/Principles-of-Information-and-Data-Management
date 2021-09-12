<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Customer Account</title>
	</head>
	<body>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String userid = request.getParameter("username"); 
			    String pwd = request.getParameter("password");
			    String firstname = request.getParameter("firstname"); 
			    String lastname = request.getParameter("lastname");
			    String email = request.getParameter("email");
			    String stringAge = request.getParameter("age");
			    int age = Integer.parseInt(stringAge);
			    
			    Statement stmt = con.createStatement();
			    String query = "insert into Transit.customers(username, password, first_name, last_name, email, age) values('" + userid + "','"+pwd+"','"+firstname+"','" + lastname + "','"+email+"','"+age+"')";
			    stmt.executeUpdate(query);
			    
			} catch (Exception e) {
				out.print(e);
			}
		    
			response.sendRedirect("index.jsp");
		%>
	</body>
</html>