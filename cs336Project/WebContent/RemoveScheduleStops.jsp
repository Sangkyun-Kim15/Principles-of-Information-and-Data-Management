<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Updating Schedule Stops</title>
	</head>
	<body>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String station = request.getParameter("rostation");
				String scheduleID = String.valueOf(session.getAttribute("editingScheduleID"));
				
				Statement stmt = con.createStatement();
				
				String query = "select stationID from stations where name = '" + station + "'";
				ResultSet result = stmt.executeQuery(query);
			    
				int stationID = 0;
				
				if (result.next()){
			    stationID = result.getInt("stationID");}
				
				String q2 = "delete from stops_at where scheduleID = '" + scheduleID + "' and stationID = '" + stationID + "'";
			    stmt.executeUpdate(q2);
			    
			} catch (Exception e) {
				out.print(e);
			}
		    
			response.sendRedirect("TrainScheduleManagement.jsp");
		%>
	</body>
</html>