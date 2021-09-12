<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>CR Control Panel</title>
	</head>
	<body>
		<div>
			<h3>Customer Representative Control Panel</h3>
		</div>
		
		<div>
			<form method = "post" action = "TrainScheduleManagement.jsp">
				<input type = "submit" value = "Manage Train Schedules">
			</form>
			
			<br>
			
			<form method = "post" action = "ReservationManagement.jsp">
				<input type = "submit" value = "Manage Reservations">
			</form>

		</div>
		
		<br>
		
		<div>
			<form method = "post" action = "index.jsp">
				<input type = "submit" value = "Back to Home">
			</form>
		</div>
		
	</body>
</html>