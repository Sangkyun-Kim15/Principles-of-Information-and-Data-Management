<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Results</title>
	</head>
	<body>
		<div>
			<h3>Search Results</h3>
		</div>
		<div>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String search = request.getParameter("search");
			    
				Statement stmt = con.createStatement();
				String query = "SELECT * FROM messages WHERE question like '%" + search + "%'";
				ResultSet result = stmt.executeQuery(query);
				
				%>
				<table>
				    <tbody>
				    <% while (result.next()) {%>
				      <tr>
				        <td>
				          <%=result.getString("username_customer") + " asks:"%>
				        </td>
				      </tr>
				      
				      <tr>
				        <td>
				          <%=result.getString("question")%>
				        </td>
				      </tr>
				      
				      <tr>
				        <td>
				          <%=result.getString("response")%>
				        </td>
				      </tr>
				      
				      <% if(result.getString("username_rep") != null) {%>
				      <tr>
				        <td>
				          <%="Answered by " + result.getString("username_rep")%>
				        </td>
				      </tr>
				      <%}%>
				      
				      <tr><td>&nbsp;</td></tr>
				    <%}%>
				</tbody>
				</table>
			    
			<% } catch (Exception e) {
				out.print(e);
			}
		%>
		</div>
		<div>
		<form method = "post" action = "Forum.jsp">
			<input type = "submit" value = "Back to Forum">
		</form>
		</div>		
		
	</body>
</html>