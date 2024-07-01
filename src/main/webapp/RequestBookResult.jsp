<%@page import="com.ncet.lib.utils.SendMail"%>
<%@page import="com.ncet.lib.exception.CommonException"%>
<%@page import="com.ncet.lib.serviceImpl.StudentServiceImpl"%>
<%@page import="com.ncet.lib.service.StudentService"%>
<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.ncet.lib.service.AdminService"%>
<%@page import="com.ncet.lib.serviceImpl.AdminServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Request Book Result</title>
<style>
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
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
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
        }
       
        button:hover {
            background-color: #86C86A;
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include> 
  <div class="container-delete">
        <h2>Request Book Result</h2>
        <form action="RequestBookResult.jsp" method="post">
            <label for="bid">Book Id:</label>
            <input type="number" id="bid" name="bid" required>
            <button type="submit">Request</button>
        </form>
         <%
              if(request.getParameter("bid")!=null){
            
            Student student = (Student) session.getAttribute("student");
            
            int bid=Integer.parseInt(request.getParameter("bid")); 
            int sid=student.getSId();
           
              String message = null;
              try {
                  StudentService sserv=new StudentServiceImpl();
                  message=sserv.requestBook(bid,sid);
                  String emailSubject="Book Trans Id Genereated";
                  String emailBody="Hello Student,\n"+message+"\nPlease get your book at Library Admin\nKeep Learnig will make shining the world\nThank You !\nNational College of Engineering and Technology";
            	SendMail.sendEmail(student.getGmail(),emailSubject, emailBody);
              } catch (ClassNotFoundException | SQLException |CommonException e) {
                  message = e.getMessage();
              }
              out.println("<p style=\"text-align:center\">"+ message + "</p>");
              }
           
            %>
         <button type="button" class="btn-dashboard" onclick="location.href='StudentDashboard.jsp'">Back to Dashboard</button>
    </div>
</body>
</html>