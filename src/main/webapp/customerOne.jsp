<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
		if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
		
		String customerId = (String)(session.getAttribute("loginId")); 
		System.out.println(customerId + "<--customerId");
		
		Class.forName("org.mariadb.jdbc.Driver");  
		System.out.println("드라이브 로딩성공");
		String url = "jdbc:mariadb://localhost:3306/mall";  
		String dbuser = "root";                             
		String dbpw = "java1234";
		Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
		
		String sql = "SELECT customer_id customerId, customer_pw customerPw, createdate, updatedate FROM customer WHERE customer_id =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		System.out.print(stmt + "<--stmt");
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Customer> list = new ArrayList<>();
		Customer c = new Customer();
		if(rs.next()){
			c.customerId = rs.getString("customerId");
			c.customerPw(rs.getString("customerPw"));
			c.createdate(rs.getString("createdate"));
			c.updatedate(rs.getString("updatedate"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1>회원 상세정보 &#128203;</h1>
	<form action="">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th>customerId</th>
				<td><%=c.customerId()%></td>
			</tr>
			<tr>
				<th>createdate</th>
				<td><%c.createdate()%></td>
			</tr>
			<tr>
				<th>updatedate</th>
				<td><%=c.getUpdatedate()%></td>
			</tr>
		</table>
	</form>
	<a href="<%=request.getContextPath()%>/updateCustomerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteCustomerForm.jsp" class="btn btn-outline-success">회원탈퇴</a> <!-- 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>//logoutAction.jsp" class="btn btn-outline-success">로그아웃</a>
</div>
</body>
</html>