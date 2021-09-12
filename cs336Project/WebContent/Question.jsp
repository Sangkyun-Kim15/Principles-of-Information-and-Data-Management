<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Create Question</title>
	</head>
	<body>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String question = request.getParameter("question");
				String username = String.valueOf(session.getAttribute("user"));
			    
				Statement stmt = con.createStatement();
				String query = "insert into Transit.messages(username_customer, question, response) values('" + username + "','" + question + "','" + "" + "')";
			    stmt.executeUpdate(query);
			    
			} catch (Exception e) {
				out.print(e);
			}
		    
			response.sendRedirect("Forum.jsp");
		%>
	</body>
</html>