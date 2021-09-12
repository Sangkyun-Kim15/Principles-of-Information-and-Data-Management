<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
			double best = -1;
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String query = "SELECT c.username, c.first_name, c.last_name, sum(r.total_fare) total_revenue FROM reservations r,  customers c WHERE c.username = r.username group by c.username order by total_revenue desc";
			ResultSet result = stmt.executeQuery(query);
	%>
	<table class="type11">
		<thead>
	     	<tr>
	            <th scope="cols">Username</th>
	            <th scope="cols">First name</th>
	            <th scope="cols">Last name</th>
	            <th scope="cols">Revenue</th>
	    	</tr>
      	</thead>
      	<tbody>
		<%
			while (result.next()) {
				if(best == -1) {
					%>
					<tr>
						<td><%=result.getString("username")%></td>
						<td><%=result.getString("first_name")%></td>
						<td><%=result.getString("last_name")%></td>
						<td><%=result.getString("total_revenue")%></td>
					</tr>
					<%
					best = result.getDouble("total_revenue");
				} else {
					if(best <= result.getDouble("total_revenue")) {
						%>
						<tr>
							<td><%=result.getString("username")%></td>
							<td><%=result.getString("first_name")%></td>
							<td><%=result.getString("last_name")%></td>
							<td><%=result.getString("total_revenue")%></td>
						</tr>
						<%
					best = result.getDouble("total_revenue");
					} else {
						//do nothing
					}
				}
	
			}
				db.closeConnection(con);
		%>
		</tbody>
	</table>
	<%
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>