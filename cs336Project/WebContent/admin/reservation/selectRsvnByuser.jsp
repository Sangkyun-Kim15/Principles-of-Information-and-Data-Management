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
			Statement stmt = con.createStatement();
			String input = request.getParameter("custName");
			String fName, lName;
			String query;
			ResultSet result;

			//first of last name
			if (input.indexOf(" ") == -1) {
				query = "SELECT * FROM trainSchedule t, reservations r, customers c WHERE r.initial_scheduleID = t.scheduleID and r.username = c.username and (c.first_name = '"
						+ input + "' or c.last_name = '" + input + "')";
				// full name
			} else {
				fName = input.substring(0, input.indexOf(" "));
				lName = input.substring(input.indexOf(" ") + 1);
				query = "SELECT * FROM trainSchedule t, reservations r, customers c WHERE r.initial_scheduleID = t.scheduleID and r.username = c.username and (c.first_name = '"
						+ fName + "' and c.last_name = '" + lName + "')";
			}
			result = stmt.executeQuery(query);
	%>
	<table class="type11">
		<thead>
	     	<tr>
	        	<th scope="cols">Reservation number</th>
	            <th scope="cols">ScheduleID</th>
	            <th scope="cols">First name</th>
	            <th scope="cols">Last name</th>
	            <th scope="cols">Reservation date</th>
	            <th scope="cols">Username</th>
	            <th scope="cols">Line</th>
	            <th scope="cols">Total fare</th>
	    	</tr>
      	</thead>
      	<tbody>
		<%
			while (result.next()) {
		%>
		<tr>
			<tr>
			<td><%=result.getString("reservation_number")%></td>
			<td><%=result.getString("scheduleID")%></td>
			<td><%=result.getString("first_name")%></td>
			<td><%=result.getString("last_name")%></td>
			<td><%=result.getString("reservation_date")%></td>
			<td><%=result.getString("username")%></td>
			<td><%=result.getString("line_name")%></td>
			<td><%=result.getString("total_fare")%></td>
		</tr>
		</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<%
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>