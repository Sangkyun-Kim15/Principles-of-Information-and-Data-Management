<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Transit Home</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String user_type = request.getParameter("user_type");
			String user = request.getParameter("username");
			String password = request.getParameter("password");
			
			//Check if the login credentials are in Employee table
			if(user_type.equals("Employee")){
				Statement stmt = con.createStatement();
				String query = "SELECT * FROM employees e WHERE e.username = '" + user + "'";
				ResultSet result = stmt.executeQuery(query);
				
				if(result.next()){
					if(result.getString("password").equals(password)){
						session.setAttribute("user", user); // the username will be stored in the session
						session.setAttribute("user_type", user_type); // also save the user type
						session.setAttribute("user_role", result.getString("role")); //also save the employee role
						
						out.println("Welcome " + result.getString("first_name"));
						// redirect to the index page after login
						response.addHeader("Refresh", "3; url = index.jsp");
					}
					else{
						out.println("Login Failed, Incorrect Password");
					}
				}
				else{
					out.println("No user with this username exists.");
				}
			}
			
			//Check if login credentials are in customer table
			else{
				Statement stmt = con.createStatement();
				String query = "SELECT * FROM customers c WHERE c.username = '" + user + "'";
				ResultSet result = stmt.executeQuery(query);
				
				if(result.next()){
					if(result.getString("password").equals(password)){
						session.setAttribute("user", user); // the username will be stored in the session
						session.setAttribute("user_type", user_type); // also save the user type
						
						out.println("Welcome " + result.getString("first_name"));
						// redirect to the index page after login
						response.addHeader("Refresh", "3; url = index.jsp");
					}
					else{
						out.println("Login Failed, Incorrect Password");
					}
				}
				else{
					out.println("No user with this username exists.");
				}
			}
			
			con.close();
		%>
		<%}catch (Exception e) {
			out.print(e);
		} %>
	</body>
</html>