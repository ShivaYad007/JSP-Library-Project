<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Student Account</title>
<style type="text/css">
     
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
        input[type="text"] {
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
   <jsp:include page="Header.jsp"></jsp:include> 
    <div class="container-delete">
        <h2>Delete Student Library Account</h2>
        <form action="DeleteStudent.jsp" method="post">
            <label for="rollno">Student Rollno:</label>
            <input type="text" id="rollno" name="rollno" required>
            <button type="submit">Delete</button>
            <button type="button" class="btn-dashboard" onclick="location.href='AdminDashboard.jsp'">Back to Dashboard</button>
        </form>
           <%
           if (request.getMethod().equalsIgnoreCase("POST")) {
            String rollno=request.getParameter("rollno"); 
              Student student = new Student();
            	  
              student.setRollno(rollno);

              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.deleteStudent(rollno);
              } catch (ClassNotFoundException | SQLException | CommonException e) {
                  message =  e.getMessage();
              }
              out.println("<p style=\"text-align:center\">"+ message + "</p>");
              }
            %>
    </div>
 
</body>
</html>