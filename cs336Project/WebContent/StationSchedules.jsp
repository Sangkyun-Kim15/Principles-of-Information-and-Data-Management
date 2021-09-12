<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=request.getParameter("station")%> Station Schedules</title>
	</head>
	<body>
		<div>
			<h3><%=request.getParameter("station")%> Station Schedules</h3>
		</div>
		<div>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String station = request.getParameter("station");
				String direction = request.getParameter("direction");
				String d = "originates_in";
				String o = "destination";
				
				if(direction.equals("Destined for")){
					d = "destination";
					o = "originates_in";
				}
			    
				Statement stmt = con.createStatement();
				String query = "Select * from (select * from trainSchedule t, (select stationID from stations where name = '" + station + "') a where a.stationID = t." + d + ")c inner join (select stationID,name from stations)d on c." + o + " = d.stationID";
				ResultSet result = stmt.executeQuery(query);
				
				if (!result.isBeforeFirst() ) {    
				    %>No schedules.<% 
				} 
				
				%>
				<table>
				    <tbody>
				    <% while (result.next()) {%>
				      <tr>
				        <td>
				          <%=result.getString("line_name") + " Schedule #" + result.getString("scheduleID")%>
				        </td>
				      </tr>
				      
				      <%if(direction.equals("Destined for")){ %>
				      <tr>
				        <td>
				          <%="Departing from " + result.getString("name") + " Station at " + result.getString("departure_time")%>
				        </td>
				      </tr>					      
				      
				      <tr>
				        <td>
				          <%="Arriving at " + station + " Station at " + result.getString("arrival_time")%>
				        </td>
				      </tr>					      
				      <%} %>
				      
				      <%if(direction.equals("Originating from")){ %>
				      <tr>
				        <td>
				          <%="Departing from " + station + " Station at " + result.getString("departure_time")%>
				        </td>
				      </tr>					      
				      
				      <tr>
				        <td>
				          <%="Arriving at " + result.getString("name") + " Station at " + result.getString("arrival_time")%>
				        </td>
				      </tr>					      
				      <%} %>				      
				      
				      <tr>
				        <td>
				          <%="Estimated Travel Time: " + result.getString("travel_time")%>
				        </td>
				      </tr>				      
				      
				      <tr><td>&nbsp;</td></tr>
				    <%}%>
				</tbody>
				</table>
			    
			<%} catch (Exception e) {
				out.print(e);
			}
		%>
		</div>
		<br>
		<div>
		<form method = "post" action = "TrainScheduleManagement.jsp">
			<input type = "submit" value = "Back to Schedule Management">
		</form>
		</div>		
		
	</body>
</html>