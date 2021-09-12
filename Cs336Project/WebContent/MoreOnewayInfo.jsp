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
		<title>OneWay Trip Results</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Query Inputs from Request
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			int scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
			String line = request.getParameter("line");
			float fare = Float.parseFloat(request.getParameter("adjusted_fare"));
			String start_date = request.getParameter("start_date");
			String departure_time = request.getParameter("departure_time");
			String arrival_time = request.getParameter("arrival_time");
			
			//counting stuff
			Statement stmt0 = con.createStatement();
			String query0 = "set @row_number3 = 0";
			stmt0.executeQuery(query0);
			//Query database for info about specific train schedule
			Statement stmt1 = con.createStatement();
			String query1 = "select ts.scheduleID scheduleID, ts.line_name line, (@row_number3 := @row_number3 + 1) as stop_num, s.name station, sa.arrival_time arrives, sa.departure_time departs from trainSchedule ts, stops_at sa, stations s where ts.scheduleID = sa.scheduleID and sa.stationID = s.stationID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time";
			ResultSet rs1 = stmt1.executeQuery(query1);
		%>
			<h3><%=line %> <%=scheduleID %></h3>
			<table>
				<tr>
					<th>Stop No.</th>
					<th>Station</th>
					<th>Arrives</th>
					<th>Departs</th>
				</tr>
		<%
			while(rs1.next()){
				int stop_num = rs1.getInt("stop_num");
				String station = rs1.getString("station");
				String arrives = rs1.getString("arrives");
				String departs = rs1.getString("departs");
				if(station.equals(origin) || station.equals(destination)){
		%>
					<tr>
						<td><b><%=stop_num %></b></td>
						<td><b><%=station %></b></td>
						<td><b><%=arrives %></b></td>
						<td><b><%=departs %></b></td>
					</tr>
		<%			
				}
				else{
		%>
					<tr>
						<td><%=stop_num %></td>
						<td><%=station %></td>
						<td><%=arrives %></td>
						<td><%=departs %></td>
					</tr>
		<%
				}
			}
		%>		
			</table>
			<br>
			Fare from <%=origin%> to <%=destination%>: $<%=String.format("%.2f", fare)%>
			<br>
			<form method="post" action=MakeOneWayReservation.jsp>
				<input type = "hidden" name = "scheduleID" value = <%=scheduleID%>>
				<input type = "hidden" name = "origin" value = "<%=origin%>">
				<input type = "hidden" name = "destination" value = "<%=destination%>">
				<input type = "hidden" name = "date" value = "<%=start_date%>">
				<input type = "hidden" name = "departure_time" value = "<%=departure_time%>">
				<input type = "hidden" name = "arrival_time" value = "<%=arrival_time%>">
				<input type = "hidden" name = "line_name" value = "<%=line%>">
				<input type = "hidden" name = "fare" value = <%=fare %>>
				<input type = "submit" value = "Make Reservation">
			</form>
			<br>
			<form method="get" action="OneWayResults.jsp">
				<input type = "submit" value="Go Back">
				<input type = "hidden" name = "origin" value = "<%=origin%>">
				<input type = "hidden" name = "destination" value = "<%=destination%>">
				<input type = "hidden" name = "start_date" value = "<%=start_date%>">
			</form>
		<%
			con.close();
			} catch(Exception e){
				out.print(e);
				e.printStackTrace();
			}
		%>
		</body>
	</html>