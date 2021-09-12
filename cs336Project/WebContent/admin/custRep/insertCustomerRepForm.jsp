<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script>
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
	if(f.ssn.value.trim().length == 0) {
		alert("insert ssn");
		return false;
	}
	return true;
}	
</script>
<link href="<%=request.getContextPath()%>/css/aLink.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../../menuBar.jsp" />
	<h3>
		<strong>Add Customer Rep</strong>
	</h3>
	<form action="insertCustomerRep.jsp" method="post" name="sform" onsubmit="return checkInputData();">
		Username: <input type="text" name="username" /><br /> 
		Password: <input type="password" name="password" id="password" /><br /> 
		First name: <input type="text" name="firstname" id="firstname" /><br /> 
		Last name: <input type="text" name="lastname" id="lastname" /><br /> 
		SSN:<input type="text" name="ssn" id="ssn" /><br /> 
		Role: 
			<select name="role" id="role">
			<option value="CustomerRep">CustomerRep</option>
		</select> <input type="submit" name="submit" /><br />
	</form>
</body>
</html>