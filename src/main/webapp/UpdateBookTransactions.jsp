<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Book Transactions</title>
<style>
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
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

input[type="number"], select {
	width: 92%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

input[type="date"] {
	width: 92%;
	padding: 9px;
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

@media ( min-width : 600px) {
	.form-group.half-width {
		width: 48%;
	}
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp"></jsp:include>
	<div class="container-update">

		<h2>Update Book Transactions</h2>
		<form action="UpdateBookTransactionsResult.jsp" method="post">

			<div class="form-group half-width">
				<label for="tid">Transaction Id:</label> <input type="number"
					id="tid" name="tid" required>
			</div>

			<div class="form-group half-width">
				<label for="issuedDate">Issued On(yyyy/mm/dd):</label> <input
					type="date" id="issuedDate" name="issuedDate" required>
			</div>
			<div class="form-group half-width">
				<label for="remarks">Ends On:</label> <select name="remarks"
					id="remarks">
					<option value="ISSUED" selected>ISSUED</option>
				</select>
			</div>

			<button type="submit">Update Transactions</button>

			<button type="button" onclick="location.href='AdminDashboard.jsp'">Back
				to Dashboard</button>
		</form>
	</div>
</body>
</html>