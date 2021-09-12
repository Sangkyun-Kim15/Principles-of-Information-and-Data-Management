<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<link href="<%=request.getContextPath()%>/css/aLink.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../../menuBar.jsp" />
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();

			String originalId = request.getParameter("id");
			String userid = request.getParameter("username");
			String pwd = request.getParameter("password");
			String firstname = request.getParameter("firstname");
			String lastname = request.getParameter("lastname");
			String ssn = request.getParameter("ssn");
			String role = request.getParameter("role");

			Statement stmt = con.createStatement();
			String query = "UPDATE Transit.employees SET username = '"
					+ userid + "', password = '" + pwd + "',first_name = '"
					+ firstname + "', last_name = '" + lastname
					+ "', ssn = '" + ssn + "', role = '" + role
					+ "' WHERE username = '" + originalId + "'";
			stmt.executeUpdate(query);

		} catch (Exception e) {
			out.print(e);
		}

		response.sendRedirect("selectCustomerRep.jsp");
	%>
</body>
</html>