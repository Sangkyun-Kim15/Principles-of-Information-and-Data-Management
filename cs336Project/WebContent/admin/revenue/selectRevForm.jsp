<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<link href="<%=request.getContextPath()%>/css/aLink.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../../menuBar.jsp" />
	<h1 style="margin-left: auto; margin-right: auto; text-align: center;"><a href="<%=request.getContextPath() %>/admin/revenue/selectRevByLine.jsp">Revenue per line</a></h1>
	<h1 style="margin-left: auto; margin-right: auto; text-align: center;"><a href="<%=request.getContextPath() %>/admin/revenue/selectRevByuser.jsp">Revenue per user</a></h1>
</body>
</html>