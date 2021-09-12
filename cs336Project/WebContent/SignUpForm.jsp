<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Customer Account</title>
<script type="text/javascript">
	// function for checking invalid input data on the form
	function checkInputData() {
		var f = document.sform;
		
		if(f.username.value.trim().length == 0) {
			alert("insert username");
			return false;
		}
		if(f.password.value.trim().length == 0) {
			alert("insert password");
			return false;
		}
		if(f.firstname.value.trim().length == 0) {
			alert("insert firstname");
			return false;
		}
		if(f.lastname.value.trim().length == 0) {
			alert("insert lastname");
			return false;
		}
		if(f.username.value.trim().length == 0) {
			alert("insert username");
			return false;
		}
		if(f.email.value.trim().length == 0) {
			alert("insert email");
			return false;
		}
		if(f.email.value.indexof("@") == -1) {
			alert("Invalid email form");
			return false;
		}
		if(f.age.value.trim().length == 0) {
			alert("insert age");
			return false;
		}
		return true;
	}f
</script>
</head>
	<body>
		<h3><strong>Sign up</strong></h3>
		<form action="SignUp.jsp" method="post" name="sform" onsubmit="return checkInputData();">
			Username: <input type="text" name="username"/><br/>
			Password: <input type="password" name="password" id="password"/><br/>
			First name: <input type="text" name="firstname" id="firstname"/><br/>
			Last name: <input type="text" name="lastname" id="lastname"/><br/>
			Email:<input type="text" name="email" id="email"/><br/>
			Age:<input type="text" name="age" id="age" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"/><br/>
			<input type="submit" name="submit"/><br/>
		</form>
		<br>
		<form method = "post" action = "index.jsp">
			<input type = "submit" value = "Back to Home">
		</form>
	</body>
</html>