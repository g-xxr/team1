<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.CustomerDao" %>
<%@ page import = "dao.CartDao" %>
<%@ page import = "vo.*" %>
<!-- 유정 -->

<%
	// 로그인한 고객만 접근 가능하게 하기
	int customerNo = 0;

	if(session.getAttribute("customerNo") == null){  // 현재 세션에 customerNo을 찾을 수 없다 -> 로그인 못함 -> 로그인 폼으로 가세요
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		customerNo = (Integer)session.getAttribute("customerNo");
	}
		
	// 필요 Dao 불러오기
	CustomerDao ctd = new CustomerDao();
	ArrayList<HashMap<String,Object>> list = ctd.customerOne(customerNo);
	
	// CartDao 불러오기
	CartDao cd = new CartDao();
	ArrayList<HashMap<String,Object>> cartlist = cd.cartList(customerNo);
	cd.deleteCartAll(customerNo);
	
	int totalSum = 0;
	int cartQuantity = 0;
	
	// 장바구니에 담긴 상품들을 총 합한 가격 (장바구니에 있는 총합이랑은 다름)
	int totalPrice = 0;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>주문 · 결제</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>

	<!---- 로그인 시 보여지는 메뉴와 로그아웃 시 보여지는 메뉴 ---->
	<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-4">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">주문 완료!</h1>
	            <p class="lead fw-normal text-white-50 mb-0">💖주문이 완료되었습니다💖</p>
	        </div>
	    </div>
	</header>
	
	<!-- 주문완료 대문-->
	<section>
	<div class="container mt-3">
	<div>
		<img src="<%=request.getContextPath()%>/upload/complete.png" class= "mx-auto d-block img-thumbnail" style="width:50%">
	</div>
	<br>
	<!-- 홈/마이페이지 버튼 선택 -->
	<div style="text-align: center;">
	<a class="btn btn-success" href="<%=request.getContextPath()%>/customerOne.jsp">마이페이지</a>
	<a class="btn btn-success" href="<%=request.getContextPath()%>/privateHome.jsp">홈으로</a>
	</div>

	</div>
	</section>
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