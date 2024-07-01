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
<title>All Books</title>
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
AdminService aserv= new AdminServiceImpl();
List<Books> books=aserv.readAllBooks();
%>
	<div class="container-read-all">
		<h2>Books</h2>
		<table>
			<tr>
				<th>Book ID</th>
				<th>Name</th>
				<th>Author</th>
				<th>Edition</th>
				<th>Department</th>
				<th>Quantity</th>
			</tr>
		<%
		for(Books book: books){
			%>
			<tr> 
				<td><%=book.getBookId() %> </td>
				<td><%=book.getName() %> </td>
				<td><%=book.getAuthor() %> </td>
				<td><%=book.getEdition() %> </td>
				<td><%=book.getDepartment() %> </td>
				<td><%=book.getQuantity() %> </td>
			</tr>
		<%
			}
		%>
		</table>
		
		<%
    	String user = (String) session.getAttribute("user");
		if(user.equals("admin")){
			 %>
			 <button type="button" onclick="location.href='AdminDashboard.jsp'">Back
			to Dashboard</button>
			<%
		}
		if(user.equals("student")){
			 %>
			 <button type="button" onclick="location.href='StudentDashboard.jsp'">Back
			to Dashboard</button>
			<%
		} 
        %>
		
	</div>
</body>
</html>