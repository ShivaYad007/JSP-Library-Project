<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Student Library Account</title>
<style type="text/css">
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
.container-update {
	width: 50%;
	max-width: 600px;
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

input[type="text"], input[type="email"], input[type="password"], input[type="number"]
	{
	width: 94%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
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

@media ( min-width : 600px) {
	.form-group.half-width {
		width: 48%;
	}
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-update">
		<h2>Update Student Library Account</h2>
		<form action="UpdateStudentResult.jsp" method="post">
			<div class="form-group half-width">
				<label for="rollno">Rollno:</label> <input type="text" id="rollno"
					name="rollno" required>
			</div>
			<div class="form-group half-width">
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" required>
			</div>

			<div class="form-group half-width">
				<label for="phno">Phone Number:</label> <input type="number"
					id="phno" name="phno" required>
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

			<button type="submit">Update</button>
			<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
				to Dashboard</button>
		</form>
	</div>
</body>
</html>