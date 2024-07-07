<%@page import="com.ncet.lib.entity.Student"%>
<%@page import="com.ncet.lib.entity.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>
<link rel="stylesheet" href="style.css">
<style type="text/css">
.container-dashboard{
height: 480px;
}
.logout {
	background-color: #4CAF50; /* Green */
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin-right: 10px;
	cursor: pointer;
	border-radius: 5px;
}
.container-dashboard .logout:hover {
	background-color: #86C86A;
}
.container-dashboard nav ul li a:hover{
color: #4E7800 
}
</style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

	<div class="container-dashboard">
		<header>
			<h1>Student Dashboard</h1>
			<%
			Student student = (Student) session.getAttribute("student");
			session.setAttribute("user", "student");
			%>
			<p>
				<%
				
				out.println("Welcome <b>" + student.getName() + "</b>");
				%>
				
			</p>
			<a class="logout" href="Home.jsp">Logout</a>
		</header>

		<nav >
			<ul>
			
				<li><a href="ReadAllBooks.jsp">
						All Books</a></li>
				<li><a href="SearchBookByName.jsp">Search
						Book by Name</a></li>
				<li><a href="SearchBookByAuthor.jsp" >Search
						Book by Author</a></li>
				<li><a href="SearchBookByNameAndAuthor.jsp">Search
						Book by Name and Author</a></li>
			    <li><a href="RequestBook.jsp">Request Book</a></li>
			    <li><a href="MyBooks.jsp">My Books</a></li>
			</ul>
		</nav>

		<main id="main-content">
			<main id="main-student-job">
				<h2>The importance of libraries for students</h2>
			<p>Libraries play vital role in supporting students educational
					journeys and overall personal development ,here some important
					benefits of library:</p>
				<ul class="student-duties">
					<li>**Libraries provide students with access to a wide range
						of books, journals, magazines, and digital resources that may not
						be available elsewhere.</li>
					<li>**Libraries offer materials that support students'
						coursework and research, helping them to achieve higher academic
						standards.</li>
					<li>**Regular visits to the library encourage a habit of
						reading, which can enhance vocabulary, comprehension, and critical
						thinking skills.</li>
					<li>**Libraries teach students how to conduct research,
						evaluate sources, and synthesize information, which are crucial
						skills for academic success and lifelong learning.</li>
					<li>**Libraries provide a quiet and conducive environment for
						study and concentration, which is essential for effective
						learning.</li>
				</ul>
			</main>
		</main>
	</div>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>