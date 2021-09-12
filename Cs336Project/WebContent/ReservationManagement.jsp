<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Reservation Management</title>
	</head>
	<body>
		<div>
			<h3>Reservation Management</h3>
		</div>	
		
		<div>
			<h4>Get Reservations</h4>
			
			<!-- Connect to database and print all train schedules -->
			<%
			try {
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
					
				Statement stmt = con.createStatement();
				String query = "SELECT distinct line_name FROM trainSchedule";
				ResultSet result = stmt.executeQuery(query);%>


				<form method = "post" action = "ReservationSearch.jsp">
					Select Line:
					
					<select name = "line" size = 1>
						<%while (result.next()){ %>
							<option><%=result.getString("line_name")%></option>
						<%}%>
					</select>
					
					<br>
					Select Date:					
					
					<select name = "rsyear" size = 1>
						<option>2020</option>
					</select>
					
					<select name = "rsmonth" size = 1>
						<option>01</option>
						<option>02</option>
						<option>03</option>
						<option>04</option>
						<option>05</option>
						<option>06</option>
						<option>07</option>
						<option>08</option>
						<option>09</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
					</select>
					
					<select name = "rsday" size = 1>
						<option>01</option>
						<option>02</option>
						<option>03</option>
						<option>04</option>
						<option>05</option>
						<option>06</option>
						<option>07</option>
						<option>08</option>
						<option>09</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
						<option>13</option>
						<option>14</option>
						<option>15</option>
						<option>16</option>
						<option>17</option>
						<option>18</option>
						<option>19</option>
						<option>20</option>
						<option>21</option>
						<option>22</option>
						<option>23</option>
						<option>24</option>
						<option>25</option>
						<option>26</option>
						<option>27</option>
						<option>28</option>
						<option>29</option>
						<option>30</option>
						<option>31</option>
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