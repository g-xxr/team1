<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.CustomerDao" %>

	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->

<%
		if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} 

		String customerId = (String)(session.getAttribute("loginId"));	
		System.out.println(customerId+ "<--customerId");
	
		CustomerDao customerDao = new CustomerDao();
		ArrayList<HashMap<String, Object>> list = customerDao.customerList(customerId);
		
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
	
<% 
	for(HashMap<String,Object> map : list) {
%>
	<form action="">
		<table class="table table-bordered table-hover">
			<tr>
				<th>사용자 ID</th>
				<td><%=map.get("customerId")%></td>
			</tr>
			<tr>
				<th>고객명</th>
				<td><%=map.get("customerName")%></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=map.get("customerPhone")%></td>
			</tr>
			<tr>
				<th>생성일</th>
				<td><%=map.get("createdate")%></td>
			</tr>
			<tr>
				<th>변경일</th>
				<td><%=map.get("updatedate")%></td>
			</tr>
		</table>
	</form>
			<% 
			}	
			%>
	<a href="<%=request.getContextPath()%>/updateCustomerOne.jsp?" class="btn btn-outline-success">회원정보 수정</a>
	&nbsp;
	<a href="<%=request.getContextPath()%>/updateCustomerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteCustomerForm.jsp" class="btn btn-outline-success">회원탈퇴</a> <!-- 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>//customerLogoutAction.jsp" class="btn btn-outline-success">로그아웃</a>
</div>
</body>
</html>