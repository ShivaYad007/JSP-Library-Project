<%@page import="com.ncet.lib.entity.Admin"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        AdminService adminService = new AdminServiceImpl();
        Admin admin = adminService.adminLogin(username, password);

        if (admin != null) {
            // Authentication successful
            session.setAttribute("admin", admin);
            response.sendRedirect("AdminDashboard.jsp");
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid username or password");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<style type="text/css">
.container-form {
  max-width: 400px;
  margin: 50px auto;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  background-color: #EAEBEA;
}
.container-form input[type="text"],
input[type="password"] {
  width: 95%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  margin-bottom: 15px;
}
.container-form input[type="submit"]:hover{
background-color: #86C86A;
}
</style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>
  <main>
    <div class="container-form">
    <h1>Admin Login</h1>
    <form action="AdminLogin.jsp" method="post"> <label for="username">Username:</label>
      <input type="text" id="username" name="username" required="required">
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required="required">
      <br>
      <input type="submit" value="Login">
      
      <a href="Home.jsp">Back to Home Page</a>  </form>
        <% if (request.getAttribute("errorMessage") != null) { %>
          <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
      <% } %>
  </div>
  </main>
</body>
</html>