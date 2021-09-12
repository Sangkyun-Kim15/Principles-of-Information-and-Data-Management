<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<style>
		table, th, td {
  		border: 1px solid black;
  		border-collapse: collapse;
		}
	</style>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Confirm Reservation</title>
	</head>
	<body>
		<h3>Make A Reservation</h3>
		<div>
			<% 
			int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String departure_time = request.getParameter("departure_time");
			String arrival_time = request.getParameter("arrival_time");
			String date = request.getParameter("date");
			String line_name = request.getParameter("line_name");
			float fare = Float.parseFloat(request.getParameter("fare"));
			%>
			Trip Date: <%=date %> <br>
			Line: <%=line_name %> <br>
			Departure: <%=origin%> at <%=departure_time%> <br>
			Arrival: <%=destination%> at <%=arrival_time%> <br>
			<h4>Pricing</h4>
			Adult Fare: $<%=String.format("%.2f", fare)%> <br>
			<% float childfare = (float)(fare * 0.75); %>
			Child Fare: $<%=String.format("%.2f", childfare) %> <br>
			<% float seniorfare = (float)(fare * 0.65);%>
			Senior Fare: $<%=String.format("%.2f", seniorfare) %> <br>
			<% float hanifare = (float)(fare * 0.5); %>
			Disabled Fare: $<%=String.format("%.2f", hanifare) %><br>
					
		</div>
		<h5>Just Enter a Few More Details</h5>
		<form method="post" action="OneWayTicket.jsp">
			Who Is Riding?: 
			<select name = "passenger_type" size=1>
				<option value="Adult">Adult</option>
				<option value="Child">Child</option>
				<option value="Senior">Senior</option>
				<option value="Disabled">Disabled</option>
			</select>
			Passenger Name: <input name="passenger" type="text"/>
			<input type="submit" value="Complete Reservation">
			<input type="hidden" name="scheduleID" value=<%=scheduleID %>>
			<input type="hidden" name="origin" value="<%=origin %>">
			<input type="hidden" name="destination" value="<%=destination %>">
			<input type="hidden" name="departure_time" value="<%=departure_time %>">
			<input type="hidden" name="arrival_time" value="<%=arrival_time %>">
			<input type="hidden" name="date" value="<%=date %>">
			<input type="hidden" name="line_name" value="<%=line_name %>">
			<input type="hidden" name="fare" value=<%=fare %>>
		</form>
	</body>
</html>