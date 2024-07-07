<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="java.util.List"%>
<%@page import="com.ncet.lib.entity.Books"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Book by Name and Author</title>
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
        button,.container-search a {
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
        .container-search a{
        width:74%;
        text-decoration: none;
        }
        button:hover,.container-search a:hover {
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
        #col-bid {
	width: 20px;
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
        <h2>Search Book by Name and Author</h2>
        <form action="SearchBookByNameAndAuthor.jsp" method="post">
            <label for="name">Book Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
             <button type="submit">Search</button>
        </form>
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
            <table>
		<tr>
			<th id="col-bid">BID</th>
			<th>Name</th>
			<th>Author</th>
			<th>Edition</th>
			<th>Department</th>
			<th>Quantity</th>
		</tr>
		
		<%
		if (request.getMethod().equalsIgnoreCase("POST")) {
            String name=request.getParameter("name"); 
            String author=request.getParameter("author"); 
            	  
              String message = null;
              try {
                  AdminService adminserv = new AdminServiceImpl();
                  List<Books> books=adminserv.searchBookByNameAndAuthor(name, author);
                  %>
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
