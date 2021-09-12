<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transit Login</title>
<link href="<%=request.getContextPath()%>/css/menuBar.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/aLink.css" rel="stylesheet" type="text/css">
</head>
<body>
	<nav>
		<div id="nav">
			<ul>
				<c:choose>
					<c:when test="${empty sessionScope.user}">
						<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
					</c:when>
			<c:otherwise>
				<%
					String userRole = (String) session.getAttribute("role");
	
					if (session.getAttribute("user_role").equals("Admin")) {
				%>
						<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/custRep/selectCustomerRep.jsp">CustomerRep List</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/salesReport/selectSalesReport.jsp">SalesReport</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/reservation/selectRsvnForm.jsp">Reservation List</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/revenue/selectRevForm.jsp">Revenue List</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/bestCust/selectBestCust.jsp">Best Customer</a></li>
						<li><a href="<%=request.getContextPath()%>/admin/best5Line/selectBest5LineForm.jsp">Best5 line</a></li>
						<li style="float: right;"><a href="<%=request.getContextPath()%>/Logout.jsp">Logout</a></li>
				<%
					} else if (session.getAttribute("user_role").equals("CustomerRep")) {
				%>
						<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
						<li style="float: right;"><a href="<%=request.getContextPath()%>/Logout.jsp">Logout</a></li>
								
				<%
					// customer
					} else {
				%>
						<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
						<li style="float: right;"><a href="<%=request.getContextPath()%>/Logout.jsp">Logout</a></li>
				<%		
					}
				%>	
			</c:otherwise>
		</c:choose>
			</ul>
		</div>
	</nav>
</body>
</html>