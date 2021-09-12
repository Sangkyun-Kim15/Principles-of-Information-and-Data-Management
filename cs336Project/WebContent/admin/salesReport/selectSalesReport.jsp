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
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			Double totalFare = 0.0;

			Statement stmt = con.createStatement();
			String query = "SELECT  year(reservation_date) y_date, month(reservation_date) m_date, sum(total_fare) revenue FROM reservations group by y_date, m_date";
			ResultSet result = stmt.executeQuery(query);
	%>
	<table class="type11">
		<thead>
	     	<tr>
	        	<th scope="cols">YEAR</th>
	            <th scope="cols">MONTH</th>
	            <th scope="cols">REVENUE</th>
	    	</tr>
      	</thead>
		<tbody>
		<%
			while (result.next()) {
				totalFare += result.getDouble("revenue");
		%>
		<tr>
			<td><%=result.getString("y_date")%></td>
			<td><%=result.getString("m_date")%></td>
			<td><%=result.getDouble("revenue")%></td>
		</tr>
		<%
			}
				db.closeConnection(con);
		%>
		</tbody>
	</table>
	<h1 style="margin-left: auto; margin-right: auto; text-align: center;">Total revenue: <%= totalFare %></h1>
	<%
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>