<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=request.getParameter("line")%> Line Customers</title>
	</head>
	<body>
		<div>
			<h3><%=request.getParameter("line")%> Line Customers</h3>
		</div>
		<div>
			<%
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				String line = request.getParameter("line");
				String year = request.getParameter("rsyear");
				String month = request.getParameter("rsmonth");
				String day = request.getParameter("rsday");
			    
				Statement stmt = con.createStatement();
				String query = "select c.username, c.first_name, c.last_name from customers c, (select r.initial_scheduleID, r.return_scheduleID, r.username from reservations r, (select scheduleID  from trainSchedule where line_name = '" + line + "' and departure_time like '" + year + "-" + month + "-" + day + "%') s where r.initial_scheduleID = s.scheduleID or r.return_scheduleID = s.scheduleID) t where c.username = t.username;";
				ResultSet result = stmt.executeQuery(query);
				
				if (!result.isBeforeFirst() ) {    
				    %>No Reservations.<% 
				}
				else{
					%>Customers with <%=year%>/<%=month%>/<%=day%> reservations on the <%=line%> line:<%
				}
				
				%>
				<table>
				    <tbody>
				    <tr><td>&nbsp;</td></tr>
				    <% while (result.next()) {%>
				      <tr>
				        <td>
				          <%=result.getString("first_name") + " " + result.getString("last_name")%>
				        </td>
				      </tr>

				      
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
		<form method = "post" action = "ReservationManagement.jsp">
			<input type = "submit" value = "Back to Reservation Management">
		</form>
		</div>		
		
	</body>
</html>