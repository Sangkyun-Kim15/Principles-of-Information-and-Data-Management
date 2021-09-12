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
		<title>Delete Reservation</title>
	</head>
	<body>
	
	<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			int reservation_number = Integer.parseInt(request.getParameter("reservation_number"));
			
			
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			Date curr_date = new Date();
			String today = df.format(curr_date);
			
			Statement stmt0 = con.createStatement();
			String query0 = "select initial_depart from reservations where reservation_number = " + reservation_number;
			ResultSet rs0 = stmt0.executeQuery(query0);	
			rs0.next();
			String reservation_depart = rs0.getString("initial_depart");
			
			Statement stmt1 = con.createStatement();
			String q1 = "select count(*) as c from reservations where reservation_number = " + reservation_number + " and initial_depart > '" + today + "'";
			ResultSet rs1 = stmt1.executeQuery(q1);
			rs1.next();
			int c = rs1.getInt("c");
			
			int year = Integer.parseInt(reservation_depart.substring(0, 4));
			int month = Integer.parseInt(reservation_depart.substring(5, 7));
			int day = Integer.parseInt(reservation_depart.substring(8, 10));
			int hh = Integer.parseInt(reservation_depart.substring(11, 13));
			int mm = Integer.parseInt(reservation_depart.substring(14, 16));
			int ss = Integer.parseInt(reservation_depart.substring(17, 19));
			Statement stmt = con.createStatement();
			String query = "delete from reservations where reservations.reservation_number = " + reservation_number + " and initial_depart > '" + today + "'";
			stmt.execute(query);
			
			if(c == 1){%>
			<h3>Successfully Deleted Reservation</h3>
			<%}
			else{
			%>
			<h3>Cannot Delete Past Reservations</h3>
			<%} %>
	<form method="get" action="ManageReservations.jsp">
		<input type="submit" value="Go Back To Manage Reservations">
	</form>
	
	<% con.close();
	} catch (Exception e){
		out.print(e);
		e.printStackTrace();
		}
	%>