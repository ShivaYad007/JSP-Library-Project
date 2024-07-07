<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Book</title>
<style>
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.container-delete {
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

input[type="number"] {
	width: 76%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-bottom: 20px;
}

button {
	width: 80%;
	padding: 10px 15px;
	font-size: 16px;
	background-color: #F22134;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 10px;
}

button:hover {
	background-color: #d9534f;
}

.btn-dashboard {
	background-color: #4CAF50;
}

.btn-dashboard:hover {
	background-color: #86C86A;
}
</style>
</head>
<body>
	<jsp:include page="/Header.jsp"></jsp:include>
	<div class="container-delete">
		<h2>Delete Book</h2>
		<form action="DeleteBook.jsp" method="post">
			<label for="bid">Book Id:</label> <input type="number" id="bid"
				name="bid" required>
			<button type="submit">Delete</button>
			<button type="button" class="btn-dashboard"
				onclick="location.href='AdminDashboard.jsp'">Back to
				Dashboard</button>
		</form>
		<%
          if (request.getMethod().equalsIgnoreCase("POST")) {
            int bid=Integer.parseInt(request.getParameter("bid")); 
           
              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.deleteBookById(bid);
              } catch (ClassNotFoundException | SQLException | CommonException e) {
                  message = e.getMessage();
              }
              out.println("<p style=\"text-align:center\">"+ message + "</p>");
              }
           
            %>
	</div>
</body>
</html>