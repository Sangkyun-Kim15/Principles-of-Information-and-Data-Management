<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
	<%
	    String userid = request.getParameter("username");   
	    String pwd = request.getParameter("password");
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ce4fgf0b9skk.us-east-2.rds.amazonaws.com:3306/TrainReservation","admin", "adminadmin");
	    Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from TrainReservation.user where username='" + userid + "' and password='" + pwd + "'");
	    if (rs.next()) {
	        session.setAttribute("user", userid); // the username will be stored in the session
	        out.println("welcome " + userid);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("success.jsp");
	    } else {
	        out.println("Invalid password <a href='login.jsp'>try again</a>");
	    }
	%>
</body>
</html>