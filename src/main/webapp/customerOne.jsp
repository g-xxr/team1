<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.CustomerDao" %>
<!-- 유섭(코드 작성) -->
<!-- 유정(부트스트랩 적용) -->

<%
		// 한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");

		int customerNo = 0;
		if(session.getAttribute("customerNo") == null){  // 로그인을 한 기록이 없으면 -> loginForm.jsp로 이동
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		} else{ 
			customerNo = (Integer)session.getAttribute("customerNo");
			System.out.println(customerNo + "<--customerNo"); // 디버깅을 통해 customerNo를 확인
		}
		
		// DAO 객체 생성
		CustomerDao customerDao = new CustomerDao();
		
		// customerOne 메소드를 호출하여 customerNo에 대한 정보를 불러옴
		ArrayList<HashMap<String, Object>> list = customerDao.customerOne(customerNo);
		System.out.println("\n"+ list.size() + "<-- 값 확인");
		
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>마이페이지</title>
		<!-- 파비콘 코드 -->
		<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
		<!-- 부트스트랩 아이콘 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
		<!-- 코어 테마 css -->
		<link href="css/styles.css" rel="stylesheet">
</head>
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">👩🏻‍💻마이페이지👨🏻‍💻</h1>
	            <p class="lead fw-normal text-white-50 mb-0">내 정보 수정, 주문내역을 확인할 수 있습니다</p>
	        </div>
	    </div>
	</header>
	
<div class="container">
<br>
	<div><h1>회원 상세정보&#128203;</h1></div>
	
<% 
	for(HashMap<String,Object> c : list) { // 받아온 회원정보 테이블에 출력
%>
	<form action="">
		<table class="table table-bordered table-hover">
			<tr>
				<th>아이디</th>
				<td><%=c.get("customerId")%></td>
			</tr>
			<tr>
				<th>이름</th>
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
		</table>
	</form>
			<% 
			}	
			%>
	<a href="<%=request.getContextPath()%>/updateCustomerOne.jsp?" class="btn btn-outline-success">회원정보 수정</a>
	&nbsp;
	<a href="<%=request.getContextPath()%>/updateCustomerPwForm.jsp?" class="btn btn-outline-success">비밀번호수정</a> <!-- 이전 비밀번호와 바꿀 비밀번호 입력 -->
	&nbsp;
	<a href="<%=request.getContextPath()%>/ordersList.jsp" class="btn btn-outline-info">주문내역</a>
	&nbsp;
	<a href="<%=request.getContextPath()%>/deleteCustomerForm.jsp" class="btn btn-outline-danger">회원탈퇴</a> <!-- 비밀번호 입력 -->
</div>

	<br>
	<br>
	<!-- 맨 아래 배너 -->
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭</p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>