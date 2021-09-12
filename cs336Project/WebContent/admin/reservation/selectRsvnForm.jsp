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
<script>
function checkInputData() {
	var f = document.sform;
	
	if(f.custName.value.trim().length == 0) {
		alert("insert name");
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
			String query = "SELECT t.line_name FROM trainSchedule t group by t.line_name";
			ResultSet result = stmt.executeQuery(query);
	%>
	<form action="selectRsvnByLine.jsp">
		<select name="line">
		<%
			while (result.next()) {
				
		%>
				<option value="<%=result.getString("line_name")%>"><%=result.getString("line_name")%></option>		
		<%
			}
				db.closeConnection(con);
		%>
		</select>
		<input type="submit" name="submit" />
	</form>
	<form action="selectRsvnByuser.jsp"  method="post" name="sform" onsubmit="return checkInputData();">
		<input type="text" id="custName" name="custName"/>
		<input type="submit" name="submit" />
	</form>
	<%
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>