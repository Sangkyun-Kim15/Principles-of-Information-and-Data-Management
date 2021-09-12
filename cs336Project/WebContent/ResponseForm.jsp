<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Response Form</title>
	</head>
	<body>
		<div>
			<h3>Response Form</h3>
		</div>
		
		<div>
		<% if(session.getAttribute("user_type").equals("Employee")){
				try {
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					
					Statement stmt = con.createStatement();
					String query = "SELECT username_customer, question, response FROM messages WHERE response = ''";
					ResultSet result = stmt.executeQuery(query);
					
					%>
					<table>
					    <tbody>
					    <% if (result.next()) {
					    session.setAttribute("ruc",result.getString("username_customer"));
					    session.setAttribute("rq",result.getString("question"));
					    %>
					    
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
					      
					      <tr><td></td></tr>
						    
						</tbody>
						</table>
						
						<form action="Response.jsp" method="post" id = "rform">
							<textarea id="response" class = "text" name="response" rows="8" cols="75" >Enter response here...
			  				</textarea>
			  				<br><br>
			  			<input type="submit" value="Submit Response" class = "submitButton">
						</form>							
						<%}
						else{%>
							No more questions.
							<br>
						<%}%>
						
				<% }catch (Exception e) {
					out.print(e);
				} %>
		<%}%>
		</div>
		
		<br>
		
		<div>
			<form method = "post" action = "Forum.jsp">
				<input type = "submit" value = "Back to Forum">
			</form>
		</div>
	</body>
</html>