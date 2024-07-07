<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Book</title>
 <style>
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
      input[type="number"] {
            width: 92%;
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
        @media (min-width: 600px) {
            .form-group.half-width {
                width: 48%;
            }
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include> 
 <div class="container-update">
        <h2>Update Book</h2>
        <form action="UpdateBookQuantity.jsp" method="post">
           
            <div class="form-group half-width">
                <label for="bid">Book Id:</label>
                <input type="number" id="bid" name="bid" required>
            </div>
           
            <div class="form-group half-width">
                <label for="qty">Quantity:</label>
                <input type="number" id="qty" name="qty" required>
            </div>
          
            <button type="submit">Update</button>
            
            <button type="button" onclick="location.href='AdminDashboard.jsp'">Back to Dashboard</button>
            <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
            int bid=Integer.parseInt(request.getParameter("bid")); 
            int qty=Integer.parseInt(request.getParameter("qty"));
           
              String message = null;
              try {
                  AdminService adminService = new AdminServiceImpl();
                  message = adminService.updateBookQuantity(bid, qty);
              } catch (ClassNotFoundException | SQLException | CommonException e) {
                  message = e.getMessage();
              }
              out.println("<p style=\"text-align:center\">"+ message + "</p>");
              }
           
            %>
        </form>
    </div>
</body>
</html>