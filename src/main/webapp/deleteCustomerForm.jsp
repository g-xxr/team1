<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1> 비밀번호 확인 </h1>
	<form action="<%=request.getContextPath()%>/deleteCustomerAction.jsp">
		<table class = "table table-bordered table-hover">
		<tr>
			<th>비밀번호</th>
			<td><input type ="password" name ="customerPw" id="customerPw"></td>
			</tr>
		
		</table>
		<button type="submit" class="btn btn-outline-primary">확인</button>
	</form>

</body>
</html>