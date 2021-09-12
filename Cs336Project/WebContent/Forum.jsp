<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Transit Forum</title>
	</head>
	<body>
		<div>
			<h3>Transit Forum</h3>
		</div>
		
		<div>
			<!-- Check/set up user type to determine which options are available to user -->
			<%if(session.getAttribute("user_type") == null){
				session.setAttribute("user_type","none");}%>
				
			<form method = "post" action = "SearchResults.jsp">
				Search: <input name = "search" type = "text"/>

				<input type="submit" value="Go">
			</form>						
			
			<br>
				
			<% if(session.getAttribute("user_type").equals("Customer")){%>
				<form method = "post" action = "QuestionForm.jsp">
					<input type = "submit" value = "Ask a Question">
				</form>
				<%}%>
				
			<% if(session.getAttribute("user_type").equals("Employee")){%>
				<form method = "post" action = "ResponseForm.jsp">
					<input type = "submit" value = "Answer Questions">
				</form>
				<%}%>

		</div>
		
		<br>
		
		<div>
			<!-- Connect to database and print all questions -->
			<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
					
				Statement stmt = con.createStatement();
				String query = "SELECT * FROM messages";
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
				<% }catch (Exception e) {
					out.print(e);
				} %>
		
		</div>
		
		<br>
		
		<div>
			<form method = "post" action = "index.jsp">
				<input type = "submit" value = "Back to Home">
			</form>
		</div>
	</body>
</html>