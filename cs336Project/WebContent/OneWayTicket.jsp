<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*, java.util.Date"%>
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
	<h1>Reservation Confirmed</h1>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Inputs from Request
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String start_date = request.getParameter("date");
			int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
			String passenger = request.getParameter("passenger");
			String departure_time = request.getParameter("departure_time");
			String arrival_time = request.getParameter("arrival_time");
			String line_name = request.getParameter("line_name");	
			float fare = Float.parseFloat(request.getParameter("fare"));
			String passenger_type = request.getParameter("passenger_type");
		%>
		
			Trip Date: <%=start_date %> <br>
			Line: <%=line_name %> <br>
			Departure: <%=origin%> at <%=departure_time%> <br>
			Arrival: <%=destination%> at <%=arrival_time%> <br>
			Passenger: <%=passenger %> (<%=passenger_type %>) <br>
			<%
			if(passenger_type.equals("Child")){
				fare *= 0.75;
			}
			else if(passenger_type.equals("Senior")){
				fare *= 0.65;
			}
			else if(passenger_type.equals("Disabled")){
				fare *= 0.5;
			}
			%>
			Fare: $<%=String.format("%.2f", fare)%>
			
		
		<%//Get the highest reservation number and increment it
			// That will be our new reservation number
			Statement stmt = con.createStatement();
			String query = "select max(reservation_number) as reservation_number from reservations";
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			int reservation_number = rs.getInt("reservation_number") + 1;
			
			//concatenate the dates
			departure_time = start_date + " " + departure_time + ":00";
			arrival_time = start_date + " " + arrival_time + ":00";
			
			//get today's date
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date curr_date = new Date();
			String today = df.format(curr_date);
			
			//Get the stationID for the origin and destination stations
			Statement st3 = con.createStatement();
			String query3 = "select stationID from stations where stations.name = '" + origin + "'";
			ResultSet rs3 = st3.executeQuery(query3);
			rs3.next();
			String origin_station = rs3.getString("stationID");
			
			Statement st4 = con.createStatement();
			String query4 = "select stationID from stations where stations.name = '" + destination + "'";
			ResultSet rs4 = st4.executeQuery(query4);
			rs4.next();
			String destination_station = rs4.getString("stationID");
			
			//insert reservation into database
			Statement stmt2 = con.createStatement();
			String query2 = "insert into reservations values (" + reservation_number + ", 'One Way', '" + session.getAttribute("user") + "', '" + departure_time + "', '" + arrival_time + "', NULL, NULL, '" + passenger + "', '" + today + "' , " +  origin_station + ", " + destination_station + ", " + fare + ", " + scheduleID + ", NULL, '" + passenger_type + "')";
			stmt2.execute(query2);
		%>
		<%
			con.close();
		%>
		<form method="get" action="index.jsp">
			<input type="submit" value="Home">
		</form>
		<%}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		} %>
	</body>
</html>