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

#result {
	display: none;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-search">
		<h2>Search Student Library Account</h2>
		<form action="SearchStudentResult.jsp" method="post">
			<label for="rollno">Student Rollno:</label> <input type="text"
				id="rollno" name="rollno" required>
			<button type="submit">Search</button>
		</form>
		<button type="button" class="btn-dashboard"
			onclick="location.href='AdminDashboard.jsp'">Back to
			Dashboard</button>

	</div>
</body>
</html>