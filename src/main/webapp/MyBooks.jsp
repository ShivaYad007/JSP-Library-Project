<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="com.ncet.lib.utils.MyBooks"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="com.ncet.lib.serviceImpl.StudentServiceImpl"%>
<%@page import="com.ncet.lib.service.StudentService"%>
<%@page import="java.util.List"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.entity.Books"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Books</title>
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
<body>
<%
String message = null;
try {
	 
Student student = (Student) session.getAttribute("student");
StudentService sserv=new StudentServiceImpl();
List<MyBooks> myBooks=sserv.myBooks(student.getRollno());
%>
	<div class="container-read-all">
		<h2>My Books</h2>
		<table>
			<tr>
				<th>Name</th>
				<th>Author</th>
				<th>Edition</th>
				<th>Issued On</th>
				<th>End On</th>
				<th>Remarks</th>
			</tr>
		<%
		for(MyBooks book: myBooks){
			%>
			<tr> 
			<td><%=book.getName()%></td>
			<td><%=book.getAuthor()%></td>
			<td><%=book.getEdition()%></td>
			<td><%=book.getIssuedOn()%></td>
			<td><%=book.getEndOn()%></td>
			<td><%=book.getRemarks()%></td>
			</tr>
		<%
			}
		%>
		</table>
			<%
			}
             catch (ClassNotFoundException | SQLException | CommonException e) {
                  message = e.getMessage();
                  out.println("<p style=\"text-align:center\">" + message + "</p>");
              }
            %>
   <button type="button" onclick="location.href='StudentDashboard.jsp'">Back
			to Dashboard</button>
	</div>
</body>
</html>