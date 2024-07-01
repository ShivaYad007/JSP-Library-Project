<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NCET Library Management System</title>
<style type="text/css">

</style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

   <nav class="navbar navbar-main">
    <div class="container">
      <h1>Library Management System</h1>
      <div class="dropdown">
        <button class="btn btn-primary dropdown-toggle">Login</button>
        <div class="dropdown-content">
          <a href="AdminLogin.jsp" class="dropdown-item">Admin</a>
          <a href="StudentLogin.jsp" class="dropdown-item">Student</a>
          
        </div>
      </div>
    </div>
  </nav>

  <main>
    <div class="container">
      <h2>Welcome to National  College Library</h2>
      <p>The library is a treasure trove of knowledge, offering a vast collection of books, journals, and other resources to support your academic journey. Explore a world of information, broaden your horizons, and fuel your intellectual curiosity.</p>
      <ul class="features">
        <li>Extensive collection of books and resources</li>
        <li>Comfortable and conducive study environment</li>
        <li>Online search and reservation system (coming soon)</li>
        <li>Helpful and knowledgeable staff</li>
      </ul>
    </div>
  </main>
  
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>