<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.CustomerDao" %>

	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->

<%
		int customerNo = 0;
		if(session.getAttribute("customerNo") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else{
			customerNo = (Integer)session.getAttribute("customerNo");
			System.out.println(customerNo + "<--customerNo");
		}
	
		CustomerDao customerDao = new CustomerDao();
		ArrayList<HashMap<String, Object>> list = customerDao.customerOne(customerNo);
		System.out.println("\n"+ list.size() + "<-- 값 확인");
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
	for(HashMap<String,Object> c : list) {
%>
	<form action="">
		<table class="table table-bordered table-hover">
			<tr>
				<th>사용자 ID</th>
				<td><%=c.get("customerId")%></td>
			</tr>
			<tr>
				<th>고객명</th>
				<td><%=c.get("customerName")%></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=c.get("customerPhone")%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=c.get("customerAddress")%></td>
			</tr>
			<tr>
				<th>생성일</th>
				<td><%=c.get("createdate")%></td>
			</tr>
			<tr>
				<th>변경일</th>
				<td><%=c.get("updatedate")%></td>
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
	<a href="<%=request.getContextPath()%>/deleteCustomerForm.jsp" class="btn btn-outline-danger">회원탈퇴</a> <!-- 비밀번호 입력 -->
</div>
</body>
</html>