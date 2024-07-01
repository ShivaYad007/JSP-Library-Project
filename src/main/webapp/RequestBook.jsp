<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Request Book</title>
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
        <h2>Request Book</h2>
        <form action="RequestBookResult.jsp" method="post">
            <label for="bid">Book Id:</label>
            <input type="number" id="bid" name="bid" required>
            <button type="submit">Request</button>
            <button type="button" class="btn-dashboard" onclick="location.href='StudentDashboard.jsp'">Back to Dashboard</button>
        </form>
    </div>
</body>
</html>