<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>

	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/managerMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->

<%
		int managerNo = 0;
		if(session.getAttribute("managerNo") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else{
			managerNo = (Integer)session.getAttribute("managerNo");
			System.out.println("\n"+ managerNo + "<--managerNo");
		}
		
		ManagerDao managerDao = new ManagerDao();
		ArrayList<Manager> list = managerDao.managerOne(managerNo);
		
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
	<%
		for(Manager m : list)  {
			
	%>
	<h1>회원 상세정보 &#128203;</h1>
	<form action="">
		<table class="table table-striped table-bordered table-hover">
			<tr>
				<th>매니저 ID</th>
				<td><%=m.getManagerId()%></td>
			</tr>
			<tr>
				<th>매니저명</th>
				<td><%=m.getManagerName()%></td>
			</tr>
			<tr>
				<th>생성일자</th>
				<td><%=m.getCreatedate()%></td>
			</tr>
			<tr>
				<th>변경일자</th>
				<td><%=m.getUpdatedate()%></td>
			</tr>
		</table>
	</form>
	<%
		}
	%>
	<a href="<%=request.getContextPath()%>/updateManagerOne.jsp?" class="btn btn-outline-success">관리자정보 수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/updateManagerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteManagerForm.jsp" class="btn btn-outline-danger">관리자 탈퇴</a> <!-- 비밀번호 입력 -->
</div>
</body>
</html>