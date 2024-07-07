<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.entity.Books"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="java.util.List"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Students</title>
<style>
.container-read-all {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
	text-align: center;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 12px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
#col-name{
width: 180px;
}

button {
	padding: 10px 20px;
	font-size: 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	display: block;
	margin: 0 auto;
}

button:hover {
	background-color: #86C86A;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-read-all">
		<h2>Student Library Accounts</h2>
		<table>
			<tr>
				<th>SID</th>
				<th id="col-name">Name</th>
				<th>Roll Number</th>
				<th>Phone Number</th>
				<th>Department</th>
				<th>Gmail</th>
				<th>Username</th>
				<th>Password</th>
				<th>Year of Joining</th>
				<th>Year of Ending</th>
			</tr>
			<%
			try{
    AdminService aserv=new AdminServiceImpl();
    List<Student> students=aserv.readAllStudents();
    for(Student student: students){
    %>
			<tr>
			    <td><%=student.getSId() %></td>
				<td><%=student.getName() %></td>
				<td><%=student.getRollno() %></td>
				<td><%=student.getPhno() %></td>
				<td><%=student.getDepartment() %></td>
				<td><%=student.getGmail() %></td>
				<td><%=student.getUsername() %></td>
				<td><%=student.getPassword() %></td>
				<td><%=student.getYearOfJoining() %></td>
				<td><%=student.getYearOfEnding() %></td>
			</tr>
			<%
			}
}
catch(SQLException | CommonException | ClassNotFoundException e){
	 out.println("<p style=\"text-align:center\">" + e.getMessage() + "</p>");
}
		%>
		</table>
		<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
			to Dashboard</button>
	</div>
</body>
</html>