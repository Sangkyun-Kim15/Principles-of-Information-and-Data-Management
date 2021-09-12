<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<link href="<%=request.getContextPath()%>/css/aLink.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/admin_table.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../../menuBar.jsp" />
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM employees e WHERE e.username = '"
					+ request.getParameter("id") + "'";
			ResultSet result = stmt.executeQuery(query);
	%>
	<table class="type11">
		<thead>
	     	<tr>
	        	<th scope="cols">Username</th>
	        	<th scope="cols">Password</th>
	            <th scope="cols">First name</th>
	            <th scope="cols">Last name</th>
	            <th scope="cols">SSN</th>
	            <th scope="cols">Role</th>
	    	</tr>
      	</thead>
		<tbody>
		<%
			while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("username")%></td>
			<td><%=result.getString("password")%></td>
			<td><%=result.getString("first_name")%></td>
			<td><%=result.getString("last_name")%></td>
			<td><%=result.getString("ssn")%></td>
			<td><%=result.getString("role")%></td>
		</tr>
		
		<%
			}
				db.closeConnection(con);
		%>
		</tbody>
	</table>
	<h1 style="margin-left: auto; margin-right: auto; text-align: center;"><a href="<%=request.getContextPath()%>/admin/custRep/updateCustomerRepForm.jsp?id=<%= request.getParameter("id") %>">edit</a></h1>
	<h1 style="margin-left: auto; margin-right: auto; text-align: center;"><a href="<%=request.getContextPath()%>/admin/custRep/deleteCustomerRep.jsp?id=<%= request.getParameter("id") %>">delete</a></h1>
	<%
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>