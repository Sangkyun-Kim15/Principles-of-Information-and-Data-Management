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

	<%
		 try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String submitted = request.getParameter("submitted");
			if (submitted.equals("More")){%>
			<h3>More Info</h3>
			<% 
				String start_date = request.getParameter("start_date");
				String return_date = request.getParameter("return_date");
				String origin = request.getParameter("origin");
				String destination = request.getParameter("destination");
				float fare = Float.parseFloat(request.getParameter("fare"));
				if(request.getParameter("initial_choice") != null){
					int initial_id = Integer.parseInt(request.getParameter("initial_choice"));
					Statement stmt1 = con.createStatement();
					
					String query1 = "select time(sa.departure_time) departure_time, ts.line_name from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + initial_id + " and st.name = '" + origin + "' and date(sa.departure_time) = '"+ start_date + "'";
					ResultSet rs1 = stmt1.executeQuery(query1);
					rs1.next();
					String initial_departure = rs1.getString("departure_time");
					String line_name = rs1.getString("line_name");
					
					Statement stmt2 = con.createStatement();
					String query2 = "select time(sa.arrival_time) arrival_time from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + initial_id + " and st.name = '" + destination + "' and date(sa.arrival_time) = '"+ start_date + "'";
					ResultSet rs2 = stmt2.executeQuery(query2);
					rs2.next();
					String initial_arrival = rs2.getString("arrival_time");
					
					//counting stuff
					Statement stmt0 = con.createStatement();
					String query0 = "set @row_number3 = 0";
					stmt0.executeQuery(query0);
					//Query database for info about specific train schedule
					Statement stmt3 = con.createStatement();
					String query3 = "select ts.scheduleID scheduleID, ts.line_name line, (@row_number3 := @row_number3 + 1) as stop_num, s.name station, sa.arrival_time arrives, sa.departure_time departs from trainSchedule ts, stops_at sa, stations s where ts.scheduleID = sa.scheduleID and sa.stationID = s.stationID and ts.scheduleID = " + initial_id + " order by sa.arrival_time";
					ResultSet rs3 = stmt3.executeQuery(query3);%>
					<h3><%=line_name %> <%=initial_id %></h3>
					<table>
						<tr>
							<th>Stop No.</th>
							<th>Station</th>
							<th>Arrives</th>
							<th>Departs</th>
						</tr>
				<%
					while(rs3.next()){
						int stop_num = rs3.getInt("stop_num");
						String station = rs3.getString("station");
						String arrives = rs3.getString("arrives");
						String departs = rs3.getString("departs");
						if(station.equals(origin) || station.equals(destination)){
				%>
							<tr>
								<td><b><%=stop_num %></b></td>
								<td><b><%=station %></b></td>
								<%if(arrives != null){ %>
								<td><b><%=arrives %></b></td>
								<%} else {%>
								<td></td>
								<%} %>
								<%if(departs != null){ %>
								<td><b><%=departs %></b></td>
								<%} else {%>
								<td></td>
								<%} %>
							</tr>
				<%			
						}
						else{
				%>
							<tr>
								<td><%=stop_num %></td>
								<td><%=station %></td>
								<%if(arrives != null){ %>
								<td><%=arrives %></td>
								<%} else {%>
								<td></td>
								<%} %>
								<%if(departs != null){ %>
								<td><%=departs %></td>
								<%} else {%>
								<td></td>
								<%} %>
							</tr>
				<%
						}
					}
				%>		
					</table>
					<br>
					Fare from <%=origin%> to <%=destination%>: $<%=String.format("%.2f", fare)%>
		<% 
				}
				
				else if(request.getParameter("return_choice") != null){
					int return_id = Integer.parseInt(request.getParameter("return_choice"));
					Statement stmt1 = con.createStatement();
					
					String query1 = "select time(sa.departure_time) departure_time, ts.line_name from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + return_id + " and st.name = '" + destination + "' and date(sa.departure_time) = '"+ return_date + "'";
					ResultSet rs1 = stmt1.executeQuery(query1);
					rs1.next();
					String return_departure = rs1.getString("departure_time");
					String line_name = rs1.getString("line_name");
					
					Statement stmt2 = con.createStatement();
					String query2 = "select time(sa.arrival_time) arrival_time from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + return_id + " and st.name = '" + origin + "' and date(sa.arrival_time) = '"+ return_date + "'";
					ResultSet rs2 = stmt2.executeQuery(query2);
					rs2.next();
					String return_arrival = rs2.getString("arrival_time");
					
					//counting stuff
					Statement stmt0 = con.createStatement();
					String query0 = "set @row_number3 = 0";
					stmt0.executeQuery(query0);
					//Query database for info about specific train schedule
					Statement stmt3 = con.createStatement();
					String query3 = "select ts.scheduleID scheduleID, ts.line_name line, (@row_number3 := @row_number3 + 1) as stop_num, s.name station, sa.arrival_time arrives, sa.departure_time departs from trainSchedule ts, stops_at sa, stations s where ts.scheduleID = sa.scheduleID and sa.stationID = s.stationID and ts.scheduleID = " + return_id + " order by sa.arrival_time";
					ResultSet rs3 = stmt3.executeQuery(query3);%>
					<h3><%=line_name %> <%=return_id %></h3>
					<table>
						<tr>
							<th>Stop No.</th>
							<th>Station</th>
							<th>Arrives</th>
							<th>Departs</th>
						</tr>
				<%
					while(rs3.next()){
						int stop_num = rs3.getInt("stop_num");
						String station = rs3.getString("station");
						String arrives = rs3.getString("arrives");
						String departs = rs3.getString("departs");
						if(station.equals(origin) || station.equals(destination)){
							%>
								<tr>
									<td><b><%=stop_num %></b></td>
									<td><b><%=station %></b></td>
									<%if(arrives != null){ %>
									<td><b><%=arrives %></b></td>
									<%} else {%>
									<td></td>
									<%} %>
									<%if(departs != null){ %>
									<td><b><%=departs %></b></td>
									<%} else {%>
									<td></td>
									<%} %>
								</tr>
					<%			
							}
							else{
					%>
								<tr>
									<td><%=stop_num %></td>
									<td><%=station %></td>
									<%if(arrives != null){ %>
									<td><%=arrives %></td>
									<%} else {%>
									<td></td>
									<%} %>
									<%if(departs != null){ %>
									<td><%=departs %></td>
									<%} else {%>
									<td></td>
									<%} %>
								</tr>
					<%
							}
					}
				%>		
					</table>
					<br>
					Fare from <%=destination%> to <%=origin%>: $<%=String.format("%.2f", fare)%>
		<% 
				} %>
				<form method="get" action="RoundResults.jsp">
					<input type="submit" value="Go Back to Search Results">
					<input type="hidden" name="origin" value="<%=origin %>">
					<input type="hidden" name="destination" value="<%=destination %>">
					<input type="hidden" name="start_date" value="<%=start_date %>">
					<input type="hidden" name="return_date" value="<%=return_date %>">
				</form>
			<% }
			else if(submitted.equals("Continue")){%> 
			<h3>Make Reservation</h3>
			<% 	
				int initial_id = Integer.parseInt(request.getParameter("initial_choice"));
				int return_id = Integer.parseInt(request.getParameter("return_choice"));
				String start_date = request.getParameter("start_date");
				String return_date = request.getParameter("return_date");
				String origin = request.getParameter("origin");
				String destination = request.getParameter("destination");
				float fare = Float.parseFloat(request.getParameter("fare"));
				
				Statement stmt1 = con.createStatement();
				String query1 = "select time(sa.departure_time) departure_time, ts.line_name from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + initial_id + " and st.name = '" + origin + "' and date(sa.departure_time) = '"+ start_date + "'";
				ResultSet rs1 = stmt1.executeQuery(query1);
				rs1.next();
				String initial_departure = rs1.getString("departure_time");
				String line_name = rs1.getString("line_name");
				
				Statement stmt2 = con.createStatement();
				String query2 = "select time(sa.arrival_time) arrival_time from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + initial_id + " and st.name = '" + destination + "' and date(sa.arrival_time) = '"+ start_date + "'";
				ResultSet rs2 = stmt2.executeQuery(query2);
				rs2.next();
				String initial_arrival = rs2.getString("arrival_time");
				
				Statement stmt3 = con.createStatement();
				String query3 = "select time(sa.departure_time) departure_time from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + return_id + " and st.name = '" + destination + "' and date(sa.departure_time) = '"+ return_date + "'";
				ResultSet rs3 = stmt3.executeQuery(query3);
				rs3.next();
				String return_departure = rs3.getString("departure_time");
				
				Statement stmt4 = con.createStatement();
				String query4 = "select time(sa.arrival_time) arrival_time from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + return_id + " and st.name = '" + origin + "' and date(sa.arrival_time) = '"+ return_date + "'";
				ResultSet rs4 = stmt2.executeQuery(query4);
				rs4.next();
				String return_arrival = rs4.getString("arrival_time");
				
		%>
		<h4>Trip Details</h4>
		Line: <%=line_name %> <br>
		Initial Trip Departure: <%=start_date %> from <%=origin %> at <%=initial_departure.substring(0, 5) %> <br>
		Initial Trip Arrival: <%=start_date %> at <%=destination %> at <%=initial_arrival.substring(0, 5) %> <br>
		Return Trip Departure: <%=return_date %> at <%=destination %> at <%=return_departure.substring(0, 5) %> <br>
		Return Trip Arrival: <%=return_date %> at <%=origin %> at <%=return_arrival.substring(0, 5) %> <br>
		<br>
		<h4>Pricing</h4>
		<%fare = 2 * fare; %>
		Adult Fare: $<%=String.format("%.2f", fare) %> <br>
		<%float childfare = (float)(fare * 0.75); %>
		Child Fare: $<%=String.format("%.2f", childfare)  %> <br>
		<% float seniorfare = (float)(fare * 0.65);%>
		Senior Fare: $<%=String.format("%.2f", seniorfare) %> <br>
		<% float hanifare = (float)(fare * 0.5); %>
		Disabled Fare: $<%=String.format("%.2f", hanifare) %><br>
		
		<h5>Just Enter a Few More Details</h5>
			<form method="post" action="RoundTicket.jsp">
				Who Is Riding?: 
				<select name = "passenger_type" size=1>
					<option value="Adult">Adult</option>
					<option value="Child">Child</option>
					<option value="Senior">Senior</option>
					<option value="Disabled">Disabled</option>
				</select>
				Passenger Name: <input name="passenger" type="text"/>
				<input type="submit" value="Complete Reservation">
				<input type="hidden" name="initial_id" value=<%=initial_id %>>
				<input type="hidden" name="return_id" value=<%=return_id %>>
				<input type="hidden" name="origin" value="<%=origin %>">
				<input type="hidden" name="destination" value="<%=destination %>">
				<input type="hidden" name="initial_departure" value="<%=initial_departure %>">
				<input type="hidden" name="initial_arrival" value="<%=initial_arrival %>">
				<input type="hidden" name="return_departure" value="<%=return_departure %>">
				<input type="hidden" name="return_arrival" value="<%=return_arrival %>">
				<input type="hidden" name="start_date" value="<%=start_date %>">
				<input type="hidden" name="return_date" value="<%=return_date %>">
				<input type="hidden" name="line_name" value="<%=line_name %>">
				<input type="hidden" name="fare" value=<%=fare %>>
			</form>
	
	<%}}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
	}%>
	</body>
</html>