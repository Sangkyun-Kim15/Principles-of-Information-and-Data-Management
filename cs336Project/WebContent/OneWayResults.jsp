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
			String start_date = request.getParameter("start_date");
			
			//Query database for initial trip
			Statement stmt1 = con.createStatement();
			String query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time";
			ResultSet rs1 = stmt1.executeQuery(query1);
			
			
		%>
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
				int stops = end_num - start_num;
				
		%>
				<tr>
					<td><%=line_name%></td>
					<td><%=departure_time%></td>
					<td><%=arrival_time%></td>
					<td>$<%=String.format("%.2f", fare)%></td>
					<td>
						<form method="post" action="MakeOneWayReservation.jsp">
							<input type = "hidden" name = "scheduleID" value = <%=scheduleID%>>
							<input type = "hidden" name = "origin" value = "<%=origin%>">
							<input type = "hidden" name = "destination" value = "<%=destination%>">
							<input type = "hidden" name = "date" value = "<%=start_date%>">
							<input type = "hidden" name = "departure_time" value = "<%=departure_time%>">
							<input type = "hidden" name = "arrival_time" value = "<%=arrival_time%>">
							<input type = "hidden" name = "line_name" value = "<%=line_name%>">
							<input type = "hidden" name = "fare" value = <%=fare %>>
							<input type = "submit" value = "Make Reservation">
						</form>
					</td>
					<td>
						<form method="post" action="MoreOnewayInfo.jsp">
							<input type= "submit" value="More Info">
							<input type = "hidden" name="scheduleID" value=<%=scheduleID %>>
							<input type = "hidden" name="origin" value="<%=origin %>">
							<input type = "hidden" name="destination" value="<%=destination %>">
							<input type = "hidden" name="adjusted_fare" value=<%=fare %>>
							<input type = "hidden" name="line" value="<%=line_name %>">
							<input type = "hidden" name = "start_date" value = "<%=start_date%>">
							<input type = "hidden" name = "departure_time" value = "<%=departure_time%>">
							<input type = "hidden" name = "arrival_time" value = "<%=arrival_time%>">
						</form>
					</td>
				</tr>
		<%
			}
			con.close();
		%>
			</table>
			<br>
			<h4>Refine Search Results</h4>
			<form method="post" action="RefinedOneWay.jsp">
				Departs Before (hh:mm): <input type="text" name="depart_before"> <input type="checkbox" name="refine_db" value="true"> <br>
				 Departs After (hh:mm): <input type="text" name="depart_after">  <input type="checkbox" name="refine_da" value="true"> <br>
				Arrives Before (hh:mm): <input type="text" name="arrive_before"> <input type="checkbox" name="refine_ab" value="true"> <br>
				 Arrives After (hh:mm): <input type="text" name="arrive_after">  <input type="checkbox" name="refine_aa" value="true"> <br>
				            Fare Below: <input type="text" name="fare_below">    <input type="checkbox" name="refine_f" value="true"> <br>
				<input type="submit" value="Find Trains">
				<input type="hidden" name="origin" value="<%=origin %>">
				<input type="hidden" name="destination" value="<%=destination %>">
				<input type="hidden" name="start_date" value="<%=start_date %>">		
			</form>
		<%}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		} %>
	</body>
</html>