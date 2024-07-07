<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Student Account</title>
<link rel="style.css" />
<style type="text/css">
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.container-create {
	width: 50%;
	max-width: 500px;
	margin: 0 auto;
	padding: 20px;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

form {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	align-items: center;
}

.form-group {
	width: 100%;
	margin-bottom: 15px;
}

.form-group.half-width {
	width: 48%;
}

label {
	margin-bottom: 5px;
	font-weight: bold;
	display: block;
}

input[type="text"], input[type="email"], input[type="password"], input[type="number"],select
	{
	width: 94%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
select{
width: 104%;
}
button {
	width: 100%;
	padding: 10px 15px;
	font-size: 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background-color: #86C86A;
}

option {
	font-size: 18px;
	background-color: #ffffff;
}

option:before {
	content: ">";
	font-size: 20px;
	display: none;
	padding-right: 10px;
	padding-left: 5px;
	color: #fff;
}

option:hover:before {
	display: inline;
}
</style>
<script>

</script>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-create">
		<h2>Create Student Library Account</h2>
		<form id="form-create" action="CreateStudent.jsp" method="post">
			<div class="form-group half-width">
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div class="form-group half-width">
				<label for="rollno">Roll Number:</label> <input type="text"
					id="rollno" name="rollno" required>
			</div>
			<div class="form-group half-width">
				<label for="phno">Phone Number:</label> <input type="number"
					id="phno" name="phno" required>
			</div>
			<div class="form-group half-width">
				<label for="department">Department:</label>
				 <select id="department"
					name="department">
					<option>CE</option>
					<option>CSE</option>
					<option>ECE</option>
					<option>EEE</option>
					<option>ME</option>
				</select>
			</div>
			<div class="form-group half-width">
				<label for="gmail">Gmail:</label> <input type="email" id="gmail"
					name="gmail" required>
			</div>
			<div class="form-group half-width">
				<label for="username">Username:</label> <input type="text"
					id="username" name="username" required>
			</div>
			<div class="form-group half-width">
				<label for="password">Password:</label> <input type="password"
					id="password" name="password" required>
			</div>
			<div class="form-group half-width">
				<label for="year_of_joining">Year of Joining:</label>
				 <select id="year_of_joining"
					name="year_of_joining">
					<option>2020</option>
					<option>2021</option>
					<option>2022</option>
					<option>2023</option>
					<option>2024</option>
					<option>2025</option>
					<option>2026</option>
					<option>2027</option>
					<option>2028</option>
					<option>2029</option>
					<option>2030</option>
				</select>
			</div>
			<div class="form-group half-width">
				<label for="year_of_ending">Year of Ending:</label>
				 <select id="year_of_ending"
					name="year_of_ending">
				
					<option>2024</option>
					<option>2025</option>
					<option>2026</option>
					<option>2027</option>
					<option>2028</option>
					<option>2029</option>
					<option>2030</option>
					<option>2031</option>
					<option>2032</option>
					<option>2033</option>
					<option>2034</option>
				</select>
				
			</div>
			<button type="submit">Create Account</button>

			<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
				to Dashboard</button>
		</form>
		         <%
            	  
           if (request.getMethod().equalsIgnoreCase("POST")) {
            	  
            String name=request.getParameter("name");
              String rollno=request.getParameter("rollno");
              long phno = Long.parseLong(request.getParameter("phno"));
              String department=request.getParameter("department");
              String gmail=request.getParameter("gmail");
              String username=request.getParameter("username");
              String password=request.getParameter("password");
              int yearOfJoining = Integer.parseInt(request.getParameter("year_of_joining"));
              int yearOfEnding = Integer.parseInt(request.getParameter("year_of_ending"));
              Student student = new Student();
            	  
              student.setName(name);
              student.setRollno(rollno);
              student.setPhno(phno);
              student.setDepartment(department);
              student.setGmail(gmail);
              student.setUsername(username);
              student.setPassword(password);
              student.setYearOfJoining(yearOfJoining);
              student.setYearOfEnding(yearOfEnding);

              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.createStudent(student);
              } catch (ClassNotFoundException | SQLException | CommonException e) {
                  message =  e.getMessage();
              }
              out.println("<p style=\"text-align:center\">" + message + "</p>");
              }
            %>
	</div>
</body>
</html>