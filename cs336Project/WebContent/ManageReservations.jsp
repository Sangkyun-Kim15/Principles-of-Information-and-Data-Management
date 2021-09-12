<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.Date, java.text.*"%>
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
		<title>Manage Reservations</title>
	</head>
	<body>
	<h3>Reservation History</h3>
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date curr_date = new Date();
			String today = df.format(curr_date);
			
			//past reservations
			Statement stmt0 = con.createStatement();
			String query0 = "select * from reservations where reservations.username = '" + session.getAttribute("user") + "' and reservations.initial_depart < '" + today + "' order by reservations.reservation_number desc";
			ResultSet rs0 = stmt0.executeQuery(query0);
			//current reservations
			Statement stmt = con.createStatement();
			String query = "select * from reservations where reservations.username = '" + session.getAttribute("user") + "' and reservations.initial_depart >= '" + today + "' order by reservations.reservation_number desc";
			ResultSet rs = stmt.executeQuery(query);
		
	%>
	<form method = "post" action="ReservationInfo.jsp">
		<table>
			<caption>Current Reservations</caption>
			<tr>
				<th>Reservation No.</th>
				<th>Passenger</th>
				<th>Trip</th>
				<th>Depart Date</th>
					
			</tr>
			<% while(rs.next()){
					int reservation_number = rs.getInt("reservation_number");
					String passenger = rs.getString("passenger");
					String depart = rs.getString("initial_depart");
					String reservation_type = rs.getString("reservation_type"); %>
					
			<tr>
				<td><%=reservation_number %></td>
				<td><%=passenger %></td>
				<td><%=reservation_type %></td>
				<td><%=depart %></td>
				<td><input type="radio" name="reservation_number" value=<%=reservation_number%>></td>
					
				<%}%>
		</table>
		<br>
		<table class="type12">
			<caption>Past Reservations</caption>
			<tr>
				<th>Reservation No.</th>
				<th>Passenger</th>
				<th>Trip</th>
				<th>Depart Date</th>
					
			</tr>
			<% while(rs0.next()){
					int reservation_number = rs0.getInt("reservation_number");
					String passenger = rs0.getString("passenger");
					String depart = rs0.getString("initial_depart");
					String reservation_type = rs0.getString("reservation_type"); %>
					
			<tr>
				<td><%=reservation_number %></td>
				<td><%=passenger %></td>
				<td><%=reservation_type %></td>
				<td><%=depart %></td>
				<td><input type="radio" name="reservation_number" value=<%=reservation_number%>></td>
					
				<%}%>
		</table>
		<input type="submit" value="Manage">
	</form>
	<br>
	<form method="get" action="index.jsp">
		<input type="submit" value="Home">
	</form>
	<%con.close(); %>
	
	<%}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		} %>
	</body>
</html>