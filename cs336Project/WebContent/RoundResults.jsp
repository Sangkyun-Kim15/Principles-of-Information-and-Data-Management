<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.math.BigDecimal, java.math.RoundingMode" %>

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
		<title>Round Trip Results</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Query Inputs from Request
			String origin = request.getParameter("origin");
			String destination = request.getParameter("destination");
			String start_date = request.getParameter("start_date");
			String return_date = request.getParameter("return_date");
			
			//Query database for initial trip
			Statement stmt1 = con.createStatement();
			String query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time";
			ResultSet rs1 = stmt1.executeQuery(query1);
			
			float far = 0;
			
			
		%>
		<form method="post" action="MakeRoundReservation.jsp">
			<br>
			<h4>Trains from <%=origin%> to <%=destination%> on <%=start_date.substring(0, 10)%></h4>
			<table>
				<tr>
					<th>Line</th>
					<th>Depart</th>
					<th>Arrive</th>
					<th>Fare</th>
				</tr>
		<%
			while(rs1.next()){
				String line_name = rs1.getString("line_name");
				String departure_time = rs1.getString("departure_time").substring(0, 5);
				String arrival_time = rs1.getString("arrival_time").substring(0, 5);
				int scheduleID = rs1.getInt("scheduleID");
				float fare = rs1.getFloat("fare");
				
				//session variable to get the stop numbers
				Statement stmt2 = con.createStatement();
				String set1 = "set @row_number1 = 0";
				stmt2.executeQuery(set1);
				
				Statement stmt3 = con.createStatement();
				String query2 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number1:= @row_number1 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + origin + "'";
				ResultSet rs2 = stmt3.executeQuery(query2);
				
				rs2.next();
				int start_num = rs2.getInt("stop_num");
				
				Statement stmt4 = con.createStatement();
				String set2 = "set @row_number2 = 0";
				stmt4.executeQuery(set2);
				
				Statement stmt5 = con.createStatement();
				String query3 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number2:= @row_number2 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + destination + "'";
				ResultSet rs3 = stmt5.executeQuery(query3);
				
				rs3.next();
				int end_num = rs3.getInt("stop_num");
				
				Statement stmt6 = con.createStatement();
				String query4 = "select count(*) total_stops from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time";
				ResultSet rs4 = stmt6.executeQuery(query4);
				
				rs4.next();
				int total_stops = rs4.getInt("total_stops");
				
				fare = fare * (end_num - start_num)/(total_stops - 1);
		%>
				<tr>
					<td><%=line_name%></td>
					<td><%=departure_time%></td>
					<td><%=arrival_time%></td>
					<td>$<%=String.format("%.2f", fare)%></td>
					<td>
						<input type="checkbox" name="initial_choice" value=<%=scheduleID%>>
					</td>
				</tr>
			
		<%}%>
			</table>
			
		<%
			//Query database for return trip
			Statement stmt12 = con.createStatement();
			String query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time";
			ResultSet rs12 = stmt12.executeQuery(query12);
		%>
		<br>
			<h4>Trains from <%=destination%> to <%=origin%> on <%=return_date.substring(0, 10)%></h4>
			<table>
				<tr>
					<th>Line</th>
					<th>Depart</th>
					<th>Arrive</th>
					<th>Fare</th>
				</tr>
		<%
			while(rs12.next()){
				String line_name = rs12.getString("line_name");
				String departure_time = rs12.getString("departure_time").substring(0, 5);
				String arrival_time = rs12.getString("arrival_time").substring(0, 5);
				int scheduleID = rs12.getInt("scheduleID");
				float fare = rs12.getFloat("fare");
		
				//session variable to get the stop numbers
				Statement stmt22 = con.createStatement();
				String set12 = "set @row_number12 = 0";
				stmt22.executeQuery(set12);
				
				Statement stmt32 = con.createStatement();
				String query22 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number12:= @row_number12 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + destination + "'";
				ResultSet rs22 = stmt32.executeQuery(query22);
				
				rs22.next();
				int start_num = rs22.getInt("stop_num");
				
				Statement stmt42 = con.createStatement();
				String set22 = "set @row_number22 = 0";
				stmt42.executeQuery(set22);
				
				Statement stmt52 = con.createStatement();
				String query32 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number22:= @row_number22 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + origin + "'";
				ResultSet rs32 = stmt52.executeQuery(query32);
				
				rs32.next();
				int end_num = rs32.getInt("stop_num");
				
				Statement stmt62 = con.createStatement();
				String query42 = "select count(*) total_stops from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time";
				ResultSet rs42 = stmt62.executeQuery(query42);
				
				rs42.next();
				int total_stops = rs42.getInt("total_stops");
				
				fare = fare * (end_num - start_num)/(total_stops - 1);
				far = fare;
		%>
				<tr>
					<td><%=line_name%></td>
					<td><%=departure_time%></td>
					<td><%=arrival_time%></td>
					<td>$<%=String.format("%.2f", fare)%></td>
					<td>
						<input type="checkbox" name="return_choice" value=<%=scheduleID%>>
					</td>
				</tr>
			
		<%}%>
			</table>
			<input type="hidden" name="start_date" value="<%=start_date %>">
			<input type="hidden" name="return_date" value="<%=return_date %>">
			<input type="hidden" name="origin" value="<%=origin%>">
			<input type="hidden" name="destination" value="<%=destination%>">
			<input type = "hidden" name = "fare" value=<%=far %>>
			<br>
			Select one initial trip and one return trip. Then click here:
			<input type="submit" name="submitted" value="Continue">
			<br>
			Or select one train schedule and click here for more info:
			<input type ="submit" name="submitted" value="More">
		</form>
		<br>
		<h4>Refine Search Results</h4>
			<form method="post" action="RefinedRound.jsp">
				Initial Departs Before (hh:mm): <input type="text" name="init_depart_before"> <input type="checkbox" name="init_refine_db" value="true"> <br>
				 Initial Departs After (hh:mm): <input type="text" name="init_depart_after">  <input type="checkbox" name="init_refine_da" value="true"> <br>
				Initial Arrives Before (hh:mm): <input type="text" name="init_arrive_before"> <input type="checkbox" name="init_refine_ab" value="true"> <br>
				 Initial Arrives After (hh:mm): <input type="text" name="init_arrive_after">  <input type="checkbox" name="init_refine_aa" value="true"> <br>
				 Return Departs Before (hh:mm): <input type="text" name="ret_depart_before">  <input type="checkbox" name="ret_refine_db" value="true"> <br>
				  Return Departs After (hh:mm): <input type="text" name="ret_depart_after">   <input type="checkbox" name="ret_refine_da" value="true"> <br>
				 Return Arrives Before (hh:mm): <input type="text" name="ret_arrive_before">  <input type="checkbox" name="ret_refine_ab" value="true"> <br>
				  Return Arrives After (hh:mm): <input type="text" name="ret_arrive_after">   <input type="checkbox" name="ret_refine_aa" value="true"> <br>
				                    Fare Below: <input type="text" name="fare_below">         <input type="checkbox" name="refine_f" value="true"> <br>
				<input type="submit" value="Find Trains">
				<input type="hidden" name="origin" value="<%=origin %>">
				<input type="hidden" name="destination" value="<%=destination %>">
				<input type="hidden" name="start_date" value="<%=start_date %>">
				<input type="hidden" name="return_date" value="<%=return_date %>">		
			</form>
		<br>
		<form method="get" action="TripDetails.jsp">
			<input type = "submit" value="Go Back To Browse">
			<input type = "hidden" name = "trip_type" value="round">
		</form>
		<%
			con.close();
		%>
		
		<%}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		} %>
	</body>
</html>