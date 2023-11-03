<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.ArrayList" %>

<!-- 메뉴 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/privateHome.jsp">👻SHOP👽</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/productList.jsp">베스트</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice.jsp">공지사항</a></li>
                <li class="nav-item dropdown">
	            	<a class="nav-link dropdown-toggle" id="navbarDropdown" href="<%=request.getContextPath()%>/question.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">문의사항</a>
	            	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/questionForm.jsp">문의남기기</a></li>
	            	</ul>
        		</li>
                <li class="nav-item dropdown">
	            	<a class="nav-link dropdown-toggle" id="navbarDropdown" href="<%=request.getContextPath()%>/review.jsp" role="button" data-bs-toggle="dropdown" aria-expanded="false">리뷰</a>
	            	<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="<%=request.getContextPath()%>/insertReviewForm.jsp">리뷰남기기</a></li>
	            	</ul>
        		</li>
            </ul>
           
           <!-- 여기 공백 넣고싶은데 -->
           
            <form class="d-flex">
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i>
                    장바구니
                    <span class="badge bg-dark text-white ms-1 rounded-pill">여기에 장바구니 수량 링크 들어감</span>
                </button>
            </form>
             <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
            	<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerOne.jsp">마이페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customerLogoutAction.jsp">로그아웃</a></li>
            </ul>
        </div>
    </div>
</nav>

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
			c.setCustomerId(rs.getString("customerId"));
			c.setCustomerPw(rs.getString("customerPw"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
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
		<table class="table table-bordered table-hover">
			<tr>
				<th>사용자 ID</th>
				<td><%=c.getCustomerId()%></td>
			</tr>
			<tr>
				<th>생성일</th>
				<td><%=c.getCreatedate()%></td>
			</tr>
			<tr>
				<th>변경일</th>
				<td><%=c.getUpdatedate()%></td>
			</tr>
		</table>
<%
System.out.println("Customer ID: " + c.getCustomerId());
System.out.println("Created Date: " + c.getCreatedate());
System.out.println("Updated Date: " + c.getUpdatedate());
%>


	</form>
	<a href="<%=request.getContextPath()%>/updateCustomerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteCustomerForm.jsp" class="btn btn-outline-success">회원탈퇴</a> <!-- 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>//customerLogoutAction.jsp" class="btn btn-outline-success">로그아웃</a>
</div>
</body>
</html>