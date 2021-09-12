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
				
				String r = request.getParameter("response");
				String username = String.valueOf(session.getAttribute("ruc"));
				String question = String.valueOf(session.getAttribute("rq"));
				String rep = String.valueOf(session.getAttribute("user"));
			    
				Statement stmt = con.createStatement();
				String query = "update Transit.messages set response = '" + r + "', username_rep = '" + rep + "' where username_customer = '" + username + "' and question = '" + question + "'";
			    stmt.executeUpdate(query);
			    
			} catch (Exception e) {
				out.print(e);
			}
		    
			response.sendRedirect("ResponseForm.jsp");
		%>
	</body>
</html>