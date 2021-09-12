<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Transit Login</title>
	</head>
	
	<body>
	<jsp:include page="menuBar.jsp" />
		<div>
			<p>Welcome to the Transit System</p>
		</div>
		<c:choose>
		<c:when test="${empty sessionScope.user}">
			<div>
				<form method = "post" action = "Login.jsp">
					Select User Type:
					<select name = "user_type" size = 1>
						<option value = "Customer">Customer</option>
						<option value = "Employee">Employee</option>
					</select> &nbsp;
					<br>
					Username:<input name = "username" type = "text"/>
					<br>
					Password: <input name = "password" type = "password"/>
					<br> <input type="submit" value="Submit">
				</form>
			</div>
			<br>
			OR
			<br>
			<form method = "post" action = "SignUpForm.jsp">
				<input type = "submit" value = "Create New Account">
			</form>
			<br>
		</c:when>
		<c:otherwise>
			<br>
			<br>
			<form method = "get" action = "TripDetails.jsp">
				Type of Trip: <select name="trip_type" size=1>
					<option value="round">Round-Trip</option>
					<option value="oneway">One-Way</option>
				</select>&nbsp;<input type = "submit" value = "Browse Schedules">
			</form>
			<br>
			<form method = "get" action = "ManageReservations.jsp">
				<input type = "submit" value = "Manage Reservations">
			</form>
		</c:otherwise>
		</c:choose>
		<div>
			<%if(session.getAttribute("user_role") == null){
				session.setAttribute("user_role","none");}%>
			
			<br>
			
			<form method = "post" action = "Forum.jsp">
				<input type = "submit" value = "Go to Forum">
			</form>
			
			<br>
			
			<% if(session.getAttribute("user_role").equals("CustomerRep")){%>
				<form method = "post" action = "CRControlPanel.jsp">
					<input type = "submit" value = "Go to Customer Rep Control Panel">
				</form>
			<%
			   } 
			%>		
			
		</div>
	</body>
	
</html>