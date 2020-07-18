<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
    if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="l<%=request.getContextPath() %>/login/login.jsp">Please Login</a>
	<%} else {
	%>
	Welcome <%=session.getAttribute("user")%>  //this will display the username that is stored in the session.
	<a href='<%=request.getContextPath() %>/login/logout.jsp'>Log out</a>
	<%
	    }
	%>
</body>
</html>