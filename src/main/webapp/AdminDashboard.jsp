<%@page import="com.ncet.lib.entity.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
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
.container-dashboard nav ul li a{
color: #4CAF50;
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
			<h1>Admin Dashboard</h1>
			<%
			Admin admin = (Admin) session.getAttribute("admin");
			session.setAttribute("user", "admin");
			%>
			<p>
				<%
				
				out.println("Welcome <b>" + admin.getName() + "</b>");
				%>
				
			</p>
			<a class="logout" href="Home.jsp">Logout</a>
		</header>

		<nav >
			<ul>
				<li><a href="CreateStudent.jsp">Create
						Student Account</a></li>
				<li><a href="UpdateStudent.jsp" >Update
						Student Account</a></li>
				<li><a href="DeleteStudent.jsp" >Delete
						Student Account</a></li>
				<li><a href="ReadAllStudents.jsp">Read
						All Accounts</a></li>
				<li><a href="SearchStudent.jsp" >Search
						Student Account</a></li>
				<li><a href="CreateBook.jsp">Create
						Book</a></li>
				<li><a href="UpdateBookQuantity.jsp" >Update
						Book</a></li>
				<li><a href="DeleteBook.jsp">Delete
						Book</a></li>
				<li><a href="ReadAllBooks.jsp">Read
						All Books</a></li>
				<li><a href="SearchBookByName.jsp">Search
						Book by Name</a></li>
				<li><a href="SearchBookByAuthor.jsp" >Search
						Book by Author</a></li>
				<li><a href="SearchBookByNameAndAuthor.jsp">Search
						Book by Name and Author</a></li>
						<li><a href="IssueBook.jsp">Issue Book
						</a></li>
							<li><a href="ReturnBook.jsp">Return Book
						</a></li>
			</ul>
		</nav>
		<main id="main-content" class="main-content">
			<main id="main-admin-job">
				<h2>The Importance of Library Admins</h2>
				<p>Library admins are the backbone of any well-functioning
					library. They go beyond simply managing books and ensuring a quiet
					environment. Here are some key roles they play:</p>
				<ul class="admin-duties">
					<li>**Collection Management:** Maintaining a diverse and
						up-to-date collection that caters to the needs of the community.
						This includes selecting new materials, weeding out outdated
						resources, and overseeing the acquisition process.</li>
					<li>**Budgeting and Resource Allocation:** Ensuring the
						library operates within its budget while allocating resources
						effectively for materials, technology, and staff development.</li>
					<li>**Public Service and Outreach:** Creating engaging
						programs and events to promote library usage, fostering a
						welcoming atmosphere for patrons, and providing reference and
						research assistance.</li>
					<li>**Technology Integration:** Keeping the library at the
						forefront of technology by implementing new systems for
						automation, online resources, and digital literacy programs.</li>
					<li>**Staff Training and Supervision:** Leading and motivating
						library staff, promoting a collaborative work environment, and
						providing opportunities for professional development.</li>
				</ul>
			</main>
		</main>
	</div>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>