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
			String start_date = request.getParameter("start_date");
			String return_date = request.getParameter("return_date");
			String initial_departure = request.getParameter("initial_departure");
			String initial_arrival = request.getParameter("initial_arrival");
			String return_departure = request.getParameter("return_departure");
			String return_arrival = request.getParameter("return_arrival");
			int initial_id = Integer.parseInt(request.getParameter("initial_id"));
			int return_id = Integer.parseInt(request.getParameter("return_id"));
			float fare = Float.parseFloat(request.getParameter("fare"));
			String line_name = request.getParameter("line_name");
			String passenger = request.getParameter("passenger");
			String passenger_type = request.getParameter("passenger_type");
		%>
		
			<h4>Trip Details</h4>
			Line: <%=line_name %> <br>
			Initial Trip Departure: <%=start_date %> from <%=origin %> at <%=initial_departure.substring(0, 5) %> <br>
			Initial Trip Arrival: <%=start_date %> at <%=destination %> at <%=initial_arrival.substring(0, 5) %> <br>
			Return Trip Departure: <%=return_date %> at <%=destination %> at <%=return_departure.substring(0, 5) %> <br>
			Return Trip Arrival: <%=return_date %> at <%=origin %> at <%=return_arrival.substring(0, 5) %> <br>
			Passenger: <%=passenger %> (<%=passenger_type %>)<br>
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
			initial_departure = start_date + " " + initial_departure;
			initial_arrival = start_date + " " + initial_arrival;
			return_departure = return_date + " " + return_departure;
			return_arrival = return_date + " " + return_arrival;
			
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
			String query2 = "insert into reservations values (" + reservation_number + ", 'Round', '" + session.getAttribute("user") + "', '" + initial_departure + "', '" + initial_arrival + "', '" + return_departure + "', '" + return_arrival + "', '" + passenger + "', '" + today + "', " +  origin_station + ", " + destination_station + ", " + fare + ", " + initial_id + ", " + return_id + ", '" + passenger_type + "')";
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