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
		<title>Manage Reservation</title>
	</head>
	<body>
	<h3>Manage Reservation</h3>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			int reservation_number = Integer.parseInt(request.getParameter("reservation_number"));
			
			Statement stmt = con.createStatement();
			String query = "select * from reservations where reservations.reservation_number = " + reservation_number;
			ResultSet rs = stmt.executeQuery(query);
			
			rs.next();
			String reservation_type = rs.getString("reservation_type");
			String initial_depart = rs.getString("initial_depart");
			String initial_arrive = rs.getString("initial_arrive");
			String return_depart = null;
			String return_arrive = null;
			String passenger = rs.getString("passenger");
			String reservation_date = rs.getString("reservation_date");
			int origin = rs.getInt("origin");
			int destination = rs.getInt("destination");
			float fare = rs.getFloat("total_fare");
			String passenger_type = rs.getString("passenger_type");
			
			if (reservation_type.equals("Round")){
				return_depart = rs.getString("return_depart");
				return_arrive = rs.getString("return_arrive");
			}
			
			Statement stmt2 = con.createStatement();
			String query2 = "select s.name from stations s where s.stationID = " + origin;
			ResultSet rs2 = stmt2.executeQuery(query2);
			rs2.next();
			String origin_station = rs2.getString("name");
			
			Statement stmt3 = con.createStatement();
			String query3 = "select s.name from stations s where s.stationID = " + destination;
			ResultSet rs3 = stmt3.executeQuery(query3);
			rs3.next();
			String destination_station = rs3.getString("name");
			
			if (reservation_type.equals("Round")){%>
				
				<table>
					<tr>
						<td><b>Reservation No.:</b></td>
						<td><%=reservation_number %></td>
					</tr>
					<tr>
						<td><b>Trip Type</b></td>
						<td><%=reservation_type %></td>
					</tr>
					<tr>
						<td><b>Initial Departure</b></td>
						<td><%=origin_station %> at <%=initial_depart %></td>
					</tr>
					<tr>
						<td><b>Initial Arrival</b></td>
						<td><%=destination_station %> at <%=initial_arrive %></td>
					</tr>
					<tr>
						<td><b>Return Departure</b></td>
						<td><%=destination_station %> at <%=return_depart %></td>
					</tr>
					<tr>
						<td><b>Return Arrival</b></td>
						<td><%=origin_station %> at <%=return_arrive %></td>
					</tr>
					<tr>
						<td><b>Passenger</b></td>
						<td><%=passenger %> (<%=passenger_type %>)</td>
					</tr>
					<tr>
						<td><b>Fare</b></td>
						<td><%=String.format("%.2f", fare) %></td>
					</tr>
					<tr>
						<td><b>Reservation Date</b></td>
						<td><%=reservation_date %></td>
					</tr>
				</table>
			<%}
			else{%>
					<table>
					<tr>
						<td><b>Reservation No.:</b></td>
						<td><%=reservation_number %></td>
					</tr>
					<tr>
						<td><b>Trip Type</b></td>
						<td><%=reservation_type %></td>
					</tr>
					<tr>
						<td><b>Departure</b></td>
						<td><%=origin_station %> at <%=initial_depart %></td>
					</tr>
					<tr>
						<td><b>Arrival</b></td>
						<td><%=destination_station %> at <%=initial_arrive %></td>
					</tr>
					<tr>
						<td><b>Passenger</b></td>
						<td><%=passenger %> (<%=passenger_type %>)</td>
					</tr>
					<tr>
						<td><b>Fare</b></td>
						<td><%=String.format("%.2f", fare) %></td>
					</tr>
					<tr>
						<td><b>Reservation Date</b></td>
						<td><%=reservation_date %></td>
					</tr>
					
				</table>
				<%}%>
				<br>
				<form method = "get" action="DeleteReservation.jsp">
					<input type="submit" value="Delete Reservation">
					<input type="hidden" name=reservation_number value=<%=reservation_number %>>
				</form>
	<%
			con.close();
	} catch (Exception e){
		out.print(e);
		e.printStackTrace();
	}
	%>