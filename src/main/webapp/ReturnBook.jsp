<%@page import="com.ncet.lib.utils.BookReturnedMail"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="com.ncet.lib.utils.BookIssuedMail"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Book</title>
<style>
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
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

input[type="number"], select {
	width: 92%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

input[type="date"] {
	width: 92%;
	padding: 9px;
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

		<h2>Return Book</h2>
		<form action="ReturnBook.jsp" method="post">

			<div class="form-group half-width">
				<label for="tid">Transaction Id:</label> <input type="number"
					id="tid" name="tid" required>
			</div>

			<div class="form-group half-width">
				<label for="remarks">Remarks:</label> <select name="remarks"
					id="remarks">
					<option value="RETURNED" selected>RETURNED</option>
				</select>
			</div>

			<button type="submit">Return Book</button>

			<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
				to Dashboard</button>
				
		</form>
				<%
		    if (request.getMethod().equalsIgnoreCase("POST")) {
            int tid=Integer.parseInt(request.getParameter("tid")); 
            String remarks=request.getParameter("remarks");
              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.returnBook(tid, remarks);
                  
              	try {
            		Student student= adminService.getStudentByTransId(tid);
                    String emailSubject="Book Returned Successfully";
                    String name=null;
                    if(student!=null){
                    	 name=student.getName();
                    }
                    
                    
                    if(!message.equalsIgnoreCase("Transaction id <b>"+tid+"</b> already Updated") && !message.equalsIgnoreCase("Transaction id <b>"+tid+"</b> not found") )
                    {
                    	BookReturnedMail.sendEmail(student.getGmail(), emailSubject, name, tid);
                    }
                    
            	} catch (ClassNotFoundException | SQLException | CommonException e) {
            		message =e.getMessage();
            	}
          
              } catch (ClassNotFoundException | SQLException | CommonException e) {
                  message = e.getMessage();
              }
              out.println("<p style=\"text-align:center\">"+ message + "</p>");
              } 
           
            %>
	</div>
</body>
</html>