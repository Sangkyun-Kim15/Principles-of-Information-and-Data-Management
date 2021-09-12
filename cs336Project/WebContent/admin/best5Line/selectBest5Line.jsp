<%@page import="java.time.Year"%>
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

			String selectYear = request.getParameter("year");
			String selectMonth = request.getParameter("month");
			Double totalFare = 0.0;

			Statement stmt = con.createStatement();
			String query = "SELECT t.line_name, year(r.reservation_date) year, month(r.reservation_date) month ,count(*) cnt FROM reservations r, trainSchedule t WHERE (t.scheduleID = r.initial_scheduleID or t.scheduleID = r.return_scheduleID) and (year(r.reservation_date) = '"
					+ selectYear
					+ "' and month(r.reservation_date) = '"
					+ selectMonth
					+ "') group by t.line_name order by cnt desc LIMIT 5";
			ResultSet result = stmt.executeQuery(query);
	%>
	<table class="type11">
		<thead>
	     	<tr>
	        	<th scope="cols">Line</th>
	            <th scope="cols">Amount of reservation</th>
	    	</tr>
      	</thead>
		<tbody>
		<%
			while (result.next()) {
		%>
		<tr>
			<td><%=result.getString("line_name")%></td>
			<td><%=result.getString("cnt")%></td>
		</tr>
		<%
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