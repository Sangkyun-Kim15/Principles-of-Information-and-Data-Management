<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336Project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Customer Account</title>
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
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM employees e WHERE e.username = '"
					+ request.getParameter("id") + "'";
			ResultSet result = stmt.executeQuery(query);

			while (result.next()) {
		%>
		<form method="post" action="updateCustomerRep.jsp?id=<%= request.getParameter("id") %>" name="sform" onsubmit="return checkInputData();">
			<input type="text" id="username" name="username" value='<%=result.getString("username")%>' class="form-control" placeholder="username" >
			<input type="text" id="password" name="password" value='<%=result.getString("password")%>' class="form-control" placeholder="password" >
			<input type="text" id="firstname" name="firstname" value='<%=result.getString("first_name")%>' class="form-control" placeholder="first_name" >
			<input type="text" id="lastname" name="lastname" value='<%=result.getString("last_name")%>' class="form-control" placeholder="last_name" >
			<input type="text" id="ssn" name="ssn" value='<%=result.getString("ssn")%>' class="form-control" placeholder="ssn" >
			<input type="hidden" name="role" value="<%=result.getString("role")%>">
			<button type="submit" class="btn btn-primary">update</button>
		</form>
		<%
			}
				db.closeConnection(con);
		
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>