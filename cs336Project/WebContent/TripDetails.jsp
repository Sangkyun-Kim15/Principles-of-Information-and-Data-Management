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
		<title>Train Lines</title>
	</head>
	
	<body>
		<center><h1>Let's Make A Reservation!</h1></center>
		<br>
		<div>
			<br>
			<h3>Before you get started, check out our train lines.</h3>
			<table>
				<caption align=top><b>NYC North Jersey Commuter Line</b></caption>
				<tr>
					<th>Stop</th>
					<th>Station</th>
					<th>City</th>
				</tr>
				<tr>
					<td>1</td>
					<td>New York Penn</td>
					<td>New York, NY</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Jersey City Central</td>
					<td>Jersey City, NJ</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Newark Metro</td>
					<td>Newark, NJ</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Metuchen Metro Park</td>
					<td>Metuchen, NJ</td>
				</tr>
				<tr>
					<td>5</td>
					<td>New Brunswick Station</td>
					<td>New Brunswick, NJ</td>
				</tr>
				<tr>
					<td>6</td>
					<td>Princeton Junction</td>
					<td>Princeton, NJ</td>
				</tr>
				<tr>
					<td>7</td>
					<td>Trenton Central</td>
					<td>Trenton, NJ</td>
				</tr>
			</table>
			<table>
				<caption align=top><b>NJ PA Express</b></caption>
				<tr>
					<th>Stop</th>
					<th>Station</th>
					<th>City</th>
				</tr>
				<tr>
					<td>1</td>
					<td>Trenton Central</td>
					<td>Trenton, NJ</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Camden Central</td>
					<td>Camden, NJ</td>
				</tr><tr>
					<td>3</td>
					<td>Philly Metro</td>
					<td>Philadelphia, PA</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Hershey Park</td>
					<td>Hershey, PA</td>
				</tr>
				<tr>
					<td>5</td>
					<td>Altoona Station</td>
					<td>Altoona, PA</td>
				</tr>
				<tr>
					<td>6</td>
					<td>Pitt Transit</td>
					<td>Pittsburgh, PA</td>
				</tr>
			</table>
			<table>
				<caption align=top><b>Passack Valley Line</b></caption>
				<tr>
					<th>Stop</th>
					<th>Station</th>
					<th>City</th>
				</tr>
				<tr>
					<td>1</td>
					<td>Hoboken</td>
					<td>Hoboken, NJ</td>
				</tr>
				<tr>
					<td>2</td>
					<td>River Edge</td>
					<td>River Edge, NJ</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Oradel</td>
					<td>Oradel, NJ</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Emerson</td>
					<td>Emerson, NJ</td>
				</tr>
				<tr>
					<td>5</td>
					<td>Westwood</td>
					<td>Westwood, NJ</td>
				</tr>
				<tr>
					<td>6</td>
					<td>Hillside</td>
					<td>Hillside, NJ</td>
				</tr>
				<tr>
					<td>7</td>
					<td>Spring Valley</td>
					<td>Spring Valley, NJ</td>
				</tr>
			</table>	
			<table>
				<caption align=top><b>Main Line</b></caption>
				<tr>
					<th>Stop</th>
					<th>Station</th>
					<th>City</th>
				</tr>
				<tr>
					<td>1</td>
					<td>Hoboken</td>
					<td>Hoboken, NJ</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Kingsland</td>
					<td>Kingsland, NJ</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Delawanna</td>
					<td>Delawanna, NJ</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Paterson</td>
					<td>Paterson, NJ</td>
				</tr>
				<tr>
					<td>5</td>
					<td>Glen Rock</td>
					<td>Glen Rock, NJ</td>
				</tr>
				<tr>
					<td>6</td>
					<td>Ridgewood</td>
					<td>Ridgewood, NJ</td>
				</tr>
				<tr>
					<td>7</td>
					<td>Suffern</td>
					<td>Suffern, NJ</td>
				</tr>
			</table>
				<table>
				<caption align=top><b>Raritan Valley Line</b></caption>
				<tr>
					<th>Stop</th>
					<th>Station</th>
					<th>City</th>
				</tr>
				<tr>
					<td>1</td>
					<td>Union</td>
					<td>Union, NJ</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Cranford</td>
					<td>Cranford, NJ</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Westfield</td>
					<td>Westfield, NJ</td>
				</tr>
				<tr>
					<td>4</td>
					<td>Fanwood</td>
					<td>Fanwood, NJ</td>
				</tr>
				<tr>
					<td>5</td>
					<td>Lebanon</td>
					<td>Lebanon, NJ</td>
				</tr>
				<tr>
					<td>6</td>
					<td>High Bridge</td>
					<td>High Bridge, NJ</td>
				</tr>
			</table>	
			
		</div>
		<div>
			<h4>Select the details of your trip</h4>
			<%//if round trip, fill this form
			if(request.getParameter("trip_type").equals("round")){ %>
				<form method = "post" action = "RoundResults.jsp">
					Starting Station: <input name="origin" type="text"/>
					<br>
					Ending Station: <input name="destination" type="text"/>
					<br>
					Start Date (YYYY-MM-DD): <input name="start_date" type="text"/>
					<br>
					Return Date (YYYY-MM-DD): <input name="return_date" type="text"/>
					<br>
					<input type = "submit" value = "Find Trains">
				</form>
			<% } //if oneway trip, fill this form
			else { %>
					<form method = "post" action = "OneWayResults.jsp">
						<br>
						Starting Station: <input name="origin" type="text"/>
						<br>
						Ending Station: <input name="destination" type="text"/>
						<br>
						Date (YYYY-MM-DD): <input name="start_date" type="text"/>
						<br>
						<input type = "submit" value = "Find Trains">
					</form>
			<%}%>
		</div>
	</body>