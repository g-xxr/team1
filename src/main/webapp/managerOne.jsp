<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>


<%
		// 한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");

		int managerNo = 0;
		if(session.getAttribute("managerNo") == null){  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else{
			managerNo = (Integer)session.getAttribute("managerNo");
			System.out.println("\n"+ managerNo + "<--managerNo"); // 디버깅을 통해 managerNo를 확인
		}
		
		// DAO 객체 생성
		ManagerDao managerDao = new ManagerDao();
		
		// managerOne 메소드를 호출하여 managerOne에 대한 정보를 불러옴
		ArrayList<Manager> list = managerDao.managerOne(managerNo);
		
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>매니저 관리 페이지</title>
		<!-- 파비콘 코드 -->
		<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
		<!-- 부트스트랩 아이콘 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
		<!-- 코어 테마 css -->
		<link href="css/styles.css" rel="stylesheet">
	</head>

<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">마이페이지</h1>
	        </div>
	    </div>
	</header>
<body>
<br>
<div class="container">
	<%
		for(Manager m : list)  { // 받아온 관리자정보 테이블에 출력
			
	%>
	<h1>회원 상세정보 &#128203;</h1>
	<form action="">
		<table class="table table-bordered table-hover">
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


	<!-- 맨 아래 배너 -->
	<br>
	<br>
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭 </p></div>
	</footer>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>