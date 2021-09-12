<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Question Form</title>
	</head>
	<body>
		<div>
			<h3>Question Form</h3>
		</div>
		
		<div>
			<form action="Question.jsp" method="post" id = "qform">
				<textarea id="question" class = "text" name="question" rows="8" cols="75" >Enter question here...
  				</textarea>
  				<br><br>
  			<input type="submit" value="Submit Question" class = "submitButton">
			</form>			
		</div>
		
		<br>
		
		<div>
		<form method = "post" action = "Forum.jsp">
			<input type = "submit" value = "Back to Forum">
		</form>
		</div>
	</body>
</html>