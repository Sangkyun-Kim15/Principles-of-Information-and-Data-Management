<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>TS Management</title>
	</head>
	<body>
		<div>
			<h3>Train Schedule Management</h3>
		</div>	
		
		<div>
			<h4>Get Schedules</h4>
			
			<!-- Connect to database and print all train schedules -->
			<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
					
				Statement stmt = con.createStatement();
				String query = "SELECT * FROM stations";
				ResultSet result = stmt.executeQuery(query);%>

				<form method = "post" action = "StationSchedules.jsp">
					Select Station:
					
					<select name = "direction" size = 1>
							<option><%="Originating from"%></option>
							<option><%="Destined for"%></option>
					</select>
					
					<select name = "station" size = 1>
						<%while (result.next()){ %>
							<option><%=result.getString("name")%></option>
						<%}%>
					</select>
					<input type="submit" value="Go">
				</form>					
				
				<h4>Edit Schedules</h4>

				<%String nq = "SELECT * FROM trainSchedule";
				ResultSet nr = stmt.executeQuery(nq); %>

				<form method = "post" action = "ScheduleEditor.jsp">
					Select Schedule:
					
					<select name = "schedule" size = 1>
						<%while (nr.next()){ %>
							<option><%=nr.getString("scheduleID")%></option>
						<%}%>
					</select>
					<input type="submit" value="Go">
				</form>		
				
				<%}
			catch (Exception e) {
					out.print(e);
				} %>
		
		</div>
		
		<br>
		
		<div>
			<form method = "post" action = "CRControlPanel.jsp">
				<input type = "submit" value = "Back to Control Panel">
			</form>
		</div>		
		
	</body>
</html>