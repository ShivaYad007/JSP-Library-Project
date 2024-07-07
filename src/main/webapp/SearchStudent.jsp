<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Student</title>
<style>
.container-search {
	width: 50%;
	max-width: 600px;
	margin: 0 auto;
	padding: 20px;
	text-align: center;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

label {
	margin-bottom: 10px;
	font-weight: bold;
	display: block;
}

input[type="text"] {
	width: 76%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-bottom: 20px;
}

button, .container-search a {
	width: 80%;
	padding: 10px 15px;
	font-size: 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 10px;
}

.container-search a {
	width: 74%;
	text-decoration: none;
}

button:hover, .container-search a:hover {
	background-color: #86C86A;
}

.btn-dashboard {
	background-color: #4CAF50;
}

.btn-dashboard:hover {
	background-color: #86C86A;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

table {
	width: 80%;
	border-collapse: collapse;
	margin-bottom: 20px;
	margin-left: auto;
	margin-right: auto;
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


</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-search">
		<h2>Search Student Library Account</h2>
		<form action="SearchStudent.jsp" method="post">
			<label for="rollno">Student Rollno:</label> <input type="text"
				id="rollno" name="rollno" required>
			<button type="submit">Search</button>
		</form>
		<button type="button" class="btn-dashboard"
			onclick="location.href='AdminDashboard.jsp'">Back to
			Dashboard</button>

	</div>
		<table>
			<tr>
				<th>Student ID</th>
				<th>Name</th>
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
			if (request.getParameter("rollno") != null) {
				String rollno = request.getParameter("rollno");
				Student student = new Student();

				String message = null;
				try {
					AdminService adminService = new AdminServiceImpl();
					student = adminService.searchStudent(rollno);
			%>
			<tr>
				<td><%=student.getSId()%></td>
				<td><%=student.getName()%></td>
				<td><%=student.getRollno()%></td>
				<td><%=student.getPhno()%></td>
				<td><%=student.getDepartment()%></td>
				<td><%=student.getGmail()%></td>
				<td><%=student.getUsername()%></td>
				<td><%=student.getPassword()%></td>
				<td><%=student.getYearOfJoining()%></td>
				<td><%=student.getYearOfEnding()%></td>
			</tr>
			<%
			} catch (ClassNotFoundException | SQLException | CommonException e) {
			message = e.getMessage();
			out.println("<p style=\"text-align:center\">" + message + "</p>");
			}
			}
			%>
		</table>


</body>
</html>