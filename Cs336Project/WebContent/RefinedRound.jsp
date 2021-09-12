<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		table, th, td {
  		border: 1px solid black;
  		border-collapse: collapse;
		}
	</style>
	<head>
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
			String return_date = request.getParameter("return_date");
			float far = 0;

			String init_depart_before = request.getParameter("init_depart_before");
			boolean init_refine_db = false;
			if(request.getParameter("init_refine_db") != null){
				init_refine_db = true;
			}
			
			String init_depart_after = request.getParameter("init_depart_after");
			boolean init_refine_da = false;
			if(request.getParameter("init_refine_da") != null){
				init_refine_da = true;
			}
			
			String init_arrive_before = request.getParameter("init_arrive_before");
			boolean init_refine_ab = false;
			if(request.getParameter("init_refine_ab") != null){
				init_refine_ab = true;
			}
			
			String init_arrive_after = request.getParameter("init_arrive_after");
			boolean init_refine_aa = false;
			if(request.getParameter("init_refine_aa") != null){
				init_refine_aa = true;
			}
			
			String ret_depart_before = request.getParameter("ret_depart_before");
			boolean ret_refine_db = false;
			if(request.getParameter("ret_refine_db") != null){
				ret_refine_db = true;
			}
			
			String ret_depart_after = request.getParameter("ret_depart_after");
			boolean ret_refine_da = false;
			if(request.getParameter("ret_refine_da") != null){
				ret_refine_da = true;
			}
			
			String ret_arrive_before = request.getParameter("ret_arrive_before");
			boolean ret_refine_ab = false;
			if(request.getParameter("ret_refine_ab") != null){
				ret_refine_ab = true;
			}
			
			String ret_arrive_after = request.getParameter("ret_arrive_after");
			boolean ret_refine_aa = false;
			if(request.getParameter("ret_refine_aa") != null){
				ret_refine_aa = true;
			}
			
			boolean refine_f = false;
			float fare_below = 0;
			if (request.getParameter("refine_f") != null){
				fare_below = Float.parseFloat(request.getParameter("fare_below"));
				if(request.getParameter("refine_f").equals("true")){
					refine_f = true;
				}
			}
			//Query database for initial trip
			Statement stmt1 = null;
			String query1 = null;
			ResultSet rs1 = null;
			
			//if no filters
			if(!init_refine_db && !init_refine_da && !init_refine_ab && !init_refine_aa){
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by departs before
			if(init_refine_db && !init_refine_da && !init_refine_ab && !init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by departs after
			if(!init_refine_db && init_refine_da && !init_refine_ab && !init_refine_aa){
				init_depart_after = init_depart_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + init_depart_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by arrive before
			if(!init_refine_db && !init_refine_da && init_refine_ab && !init_refine_aa){
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by arrive after
			if(!init_refine_db && !init_refine_da && !init_refine_ab && init_refine_aa){
				init_arrive_after = init_arrive_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) > '" + init_arrive_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart before and depart after
			if(init_refine_db && init_refine_da && !init_refine_ab && !init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_depart_after = init_depart_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t1.departure_time) > '" + init_depart_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart before and arrive before
			if(init_refine_db && !init_refine_da && init_refine_ab && !init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart before and arrive after
			if(init_refine_db && !init_refine_da && !init_refine_ab && init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_arrive_after = init_arrive_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t2.arrival_time) > '" + init_arrive_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart after and arrive before
			if(!init_refine_db && init_refine_da && init_refine_ab && !init_refine_aa){
				init_depart_after = init_depart_after + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + init_depart_after + "' and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart after and arrive after
			if(!init_refine_db && init_refine_da && !init_refine_ab && init_refine_aa){
				init_depart_after = init_depart_after + ":00";
				init_arrive_after = init_arrive_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_after + "' and time(t2.arrival_time) > '" + init_arrive_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by arrive before and arrive after
			if(!init_refine_db && !init_refine_da && init_refine_ab && init_refine_aa){
				init_arrive_before = init_arrive_before + ":00";
				init_arrive_after = init_arrive_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) < '" + init_arrive_before + "' and time(t2.arrival_time) > '" + init_arrive_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart before, depart after, and arrive before
			if(init_refine_db && init_refine_da && init_refine_ab && !init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_depart_after = init_depart_after + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t1.departure_time) > '" + init_depart_after + "' and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			
			//if only filtering by depart before, depart after, and arrive after
			if(init_refine_db && init_refine_da && !init_refine_ab && init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_depart_after = init_depart_after + ":00";
				init_arrive_after= init_arrive_after + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t1.departure_time) > '" + init_depart_after + "' and time(t2.arrival_time) > '" + init_arrive_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart before, arrive after, and arrive before
			if(init_refine_db && !init_refine_da && init_refine_ab && init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_arrive_after = init_arrive_after + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t2.arrival_time) > '" + init_arrive_after + "' and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if only filtering by depart after, arrive after, and arrive before
			if(!init_refine_db && init_refine_da && init_refine_ab && init_refine_aa){
				init_depart_after = init_depart_after + ":00";
				init_arrive_after = init_arrive_after + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + init_depart_after + "' and time(t2.arrival_time) > '" + init_arrive_after + "' and time(t2.arrival_time) < '" + init_arrive_before + "'";
				rs1 = stmt1.executeQuery(query1);
			}
			//if filtering by depart before, depart after, arrive after, and arrive before
			if(init_refine_db && init_refine_da && init_refine_ab && init_refine_aa){
				init_depart_before = init_depart_before + ":00";
				init_depart_after = init_depart_after + ":00";
				init_arrive_after = init_arrive_after + ":00";
				init_arrive_before = init_arrive_before + ":00";
				stmt1 = con.createStatement();
				query1 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + origin + "' and date(sa1.departure_time) = '" + start_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + destination + "' and date(sa2.arrival_time) = '" + start_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + init_depart_before + "' and time(t2.arrival_time) > '" + init_arrive_after + "' and time(t2.arrival_time) < '" + init_arrive_before + "' and time(t1.departure_time) > '" + init_depart_after + "'";
				rs1 = stmt1.executeQuery(query1);
			}
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
				fare *= 2;
				
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
				
				if(fare > fare_below && refine_f){continue;}
				
		%>
				<tr>
					<td><%=line_name%></td>
					<td><%=departure_time%></td>
					<td><%=arrival_time%></td>
					<td>$<%=String.format("%.2f", fare/2)%></td>
					<td>
						<input type="checkbox" name="initial_choice" value=<%=scheduleID%>>
					</td>
				</tr>
		<%
			}
			
		%>
		</table>
		<br>
		<%
		//Query database for initial trip
		Statement stmt12 = null;
		String query12 = null;
		ResultSet rs12 = null;
		
		//if no filters
		if(!ret_refine_db && !ret_refine_da && !ret_refine_ab && !ret_refine_aa){
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by departs before
		if(ret_refine_db && !ret_refine_da && !ret_refine_ab && !ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by departs after
		if(!ret_refine_db && ret_refine_da && !ret_refine_ab && !ret_refine_aa){
			ret_depart_after = ret_depart_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + ret_depart_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by arrive before
		if(!ret_refine_db && !ret_refine_da && ret_refine_ab && !ret_refine_aa){
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by arrive after
		if(!ret_refine_db && !ret_refine_da && !ret_refine_ab && ret_refine_aa){
			ret_arrive_after = ret_arrive_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) > '" + ret_arrive_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart before and depart after
		if(ret_refine_db && ret_refine_da && !ret_refine_ab && !ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_depart_after = ret_depart_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t1.departure_time) > '" + ret_depart_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart before and arrive before
		if(ret_refine_db && !ret_refine_da && ret_refine_ab && !ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart before and arrive after
		if(ret_refine_db && !ret_refine_da && !ret_refine_ab && ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t2.arrival_time) > '" + ret_arrive_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart after and arrive before
		if(!ret_refine_db && ret_refine_da && ret_refine_ab && !ret_refine_aa){
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + ret_depart_after + "' and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query1);
		}
		//if only filtering by depart after and arrive after
		if(!ret_refine_db && ret_refine_da && !ret_refine_ab && ret_refine_aa){
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_after + "' and time(t2.arrival_time) > '" + ret_arrive_after + "'";
			rs12 = stmt12.executeQuery(query1);
		}
		//if only filtering by arrive before and arrive after
		if(!ret_refine_db && !ret_refine_da && ret_refine_ab && ret_refine_aa){
			ret_arrive_before = ret_arrive_before + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t2.arrival_time) < '" + ret_arrive_before + "' and time(t2.arrival_time) > '" + ret_arrive_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart before, depart after, and arrive before
		if(ret_refine_db && ret_refine_da && ret_refine_ab && !ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t1.departure_time) > '" + ret_depart_after + "' and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		
		//if only filtering by depart before, depart after, and arrive after
		if(ret_refine_db && ret_refine_da && !ret_refine_ab && ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_after= ret_arrive_after + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t1.departure_time) > '" + ret_depart_after + "' and time(t2.arrival_time) > '" + ret_arrive_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart before, arrive after, and arrive before
		if(ret_refine_db && !ret_refine_da && ret_refine_ab && ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t2.arrival_time) > '" + ret_arrive_after + "' and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if only filtering by depart after, arrive after, and arrive before
		if(!ret_refine_db && ret_refine_da && ret_refine_ab && ret_refine_aa){
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) > '" + ret_depart_after + "' and time(t2.arrival_time) > '" + ret_arrive_after + "' and time(t2.arrival_time) < '" + ret_arrive_before + "'";
			rs12 = stmt12.executeQuery(query12);
		}
		//if filtering by depart before, depart after, arrive after, and arrive before
		if(ret_refine_db && ret_refine_da && ret_refine_ab && ret_refine_aa){
			ret_depart_before = ret_depart_before + ":00";
			ret_depart_after = ret_depart_after + ":00";
			ret_arrive_after = ret_arrive_after + ":00";
			ret_arrive_before = ret_arrive_before + ":00";
			stmt12 = con.createStatement();
			query12 = "select t1.scheduleID, t1.fare, t1.line_name, time(t1.departure_time) departure_time, time(t2.arrival_time) arrival_time from (select ts1.scheduleID, ts1.fare, ts1.line_name, sa1.departure_time from trainSchedule ts1, stops_at sa1, stations st1 where ts1.scheduleID = sa1.scheduleID and sa1.stationID = st1.stationID and st1.name = '" + destination + "' and date(sa1.departure_time) = '" + return_date + "') t1, (select ts2.scheduleID, ts2.line_name, sa2.arrival_time from trainSchedule ts2, stops_at sa2, stations st2 where ts2.scheduleID = sa2.scheduleID and sa2.stationID = st2.stationID and st2.name = '" + origin + "' and date(sa2.arrival_time) = '" + return_date + "') t2 where t1.scheduleID = t2.scheduleID and t1.departure_time < t2.arrival_time and time(t1.departure_time) < '" + ret_depart_before + "' and time(t2.arrival_time) > '" + ret_arrive_after + "' and time(t2.arrival_time) < '" + ret_arrive_before + "' and time(t1.departure_time) > '" + ret_depart_after + "'";
			rs12 = stmt12.executeQuery(query12);
		}
	%>
		<br>
		<h4>Trains from <%=destination%> to <%=origin%> on <%=start_date.substring(0, 10)%></h4>
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
			fare *= 2;
			
			//session variable to get the stop numbers
			Statement stmt2 = con.createStatement();
			String set1 = "set @row_number1 = 0";
			stmt2.executeQuery(set1);
			
			Statement stmt3 = con.createStatement();
			String query2 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number1:= @row_number1 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + destination + "'";
			ResultSet rs2 = stmt3.executeQuery(query2);
			
			rs2.next();
			int start_num = rs2.getInt("stop_num");
			
			Statement stmt4 = con.createStatement();
			String set2 = "set @row_number2 = 0";
			stmt4.executeQuery(set2);
			
			Statement stmt5 = con.createStatement();
			String query3 = "select t.stop_num from (select st.name, sa.arrival_time, (@row_number2:= @row_number2 + 1) as stop_num from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time) t where t.name = '" + origin + "'";
			ResultSet rs3 = stmt5.executeQuery(query3);
			
			rs3.next();
			int end_num = rs3.getInt("stop_num");
			
			Statement stmt6 = con.createStatement();
			String query4 = "select count(*) total_stops from stations st, stops_at sa, trainSchedule ts where st.stationID = sa.stationID and sa.scheduleID = ts.scheduleID and ts.scheduleID = " + scheduleID + " order by sa.arrival_time";
			ResultSet rs4 = stmt6.executeQuery(query4);
			
			rs4.next();
			int total_stops = rs4.getInt("total_stops");
			
			fare = fare * (end_num - start_num)/(total_stops - 1);
			far = fare/2;
			
			if(fare > fare_below && refine_f){continue;}
			
	%>
			<tr>
				<td><%=line_name%></td>
				<td><%=departure_time%></td>
				<td><%=arrival_time%></td>
				<td>$<%=String.format("%.2f", fare/2)%></td>
				<td>
					<input type="checkbox" name="return_choice" value=<%=scheduleID%>>
				</td>
			</tr>
	<%
		}	
	%>
		</table>
		<input type="hidden" name="start_date" value="<%=start_date %>">
		<input type="hidden" name="return_date" value="<%=return_date %>">
		<input type="hidden" name="origin" value="<%=origin%>">
		<input type="hidden" name="destination" value="<%=destination%>">
		<input type = "hidden" name = "fare" value=<%=far %>>
		<br>
		Select one initial trip and one return trip. Then click here: &nbsp;
		<input type="submit" name="submitted" value="Continue">
		<br>
		Or select one train schedule and click here for more info: &nbsp;
		<input type ="submit" name="submitted" value="More">
	</form>
		<% con.close();
		}catch (Exception e) {
			out.print(e);
			e.printStackTrace();
		} %>
	</body>
</html>