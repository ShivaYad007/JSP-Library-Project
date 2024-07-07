<%@page import="com.ncet.lib.entity.Books"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Book</title>
<style type="text/css">
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.container-create {
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

input[type="text"], input[type="number"], select {
	width: 94%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

select {
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
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-create">
		<h2>Create Book</h2>
		<form action="CreateBook.jsp" method="post">
			<div class="form-group half-width">
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div class="form-group half-width">
				<label for="author">Author:</label> <input type="text" id="author"
					name="author" required>
			</div>
			<div class="form-group half-width">
				<label for="edition">Edition:</label> <input type="number"
					id="edition" name="edition" required>
			</div>
			<div class="form-group half-width">
				<label for="department">Department:</label> <select id="department"
					name="department">
					<option>CE</option>
					<option>CSE</option>
					<option>ECE</option>
					<option>EEE</option>
					<option>ME</option>
				</select>
			</div>
			<div class="form-group half-width">
				<label for="qty">Quantity:</label> <input type="number" id="qty"
					name="qty" required>
			</div>

			<button type="submit">Create Book</button>
			<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
				to Dashboard</button>
		</form>
		<%
			if (request.getMethod().equalsIgnoreCase("POST")) {
             
              String name=request.getParameter("name");
              String author=request.getParameter("author");
              String edition = request.getParameter("edition");
              String department=request.getParameter("department");
              int qty=Integer.parseInt(request.getParameter("qty"));

              Books book=new Books();
              book.setName(name);
              book.setAuthor(author);
              book.setEdition(edition);
              book.setDepartment(department);
              book.setQuantity(qty);
              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.createBook(book);
              } catch (ClassNotFoundException | SQLException e) {
                  message =  e.getMessage();
              }
              out.println("<p style=\"text-align:center\">" + message + "</p>");
              }
            %>
	</div>
</body>
</html>