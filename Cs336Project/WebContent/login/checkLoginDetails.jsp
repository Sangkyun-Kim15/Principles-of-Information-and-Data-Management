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
	    Connection con = DriverManager.getConnection("jdbc:mysql://cs336db.ce4fgf0b9skk.us-east-2.rds.amazonaws.com:3306/Transit","admin", "adminadmin");
	    Statement st = con.createStatement();
	    ResultSet rs_customer;
	    ResultSet re_rep;
	    ResultSet rs_admin;
	    rs_customer = st.executeQuery("select * from Transit.Customer where username='" + userid + "' and password='" + pwd + "'");
	    
	    // customer
	    if (rs_customer.next()) {
	        session.setAttribute("user", userid); // the username will be stored in the session
	        out.println("welcome " + userid);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("success.jsp");
	     // no customer
	    } else {
	    	rs_customer.close();
	    	re_rep = st.executeQuery("select * from Transit.CustomerRep where username='" + userid + "' and password='" + pwd + "'");
	    	// customer_rep
	    	if(re_rep.next()) {
	    		session.setAttribute("user", userid); // the username will be stored in the session
		        out.println("welcome " + userid);
		        out.println("<a href='logout.jsp'>Log out</a>");
		        response.sendRedirect("success.jsp");
		     // no customer, no customer_rep
	    	} else {
	    		re_rep.close();
	    		rs_admin = st.executeQuery("select * from Transit.Admin where username='" + userid + "' and password='" + pwd + "'");
	    		// admin
	    		if(rs_admin.next()) {
	    			session.setAttribute("user", userid); // the username will be stored in the session
			        out.println("welcome " + userid);
			        out.println("<a href='logout.jsp'>Log out</a>");
			        response.sendRedirect("success.jsp");
			    // no customer, no customer_rep, no admin
	    		} else {
			        out.println("Invalid password <a href='login.jsp'>try again</a>");
	    		}
	    	}
	    }
	%>
</body>
</html>