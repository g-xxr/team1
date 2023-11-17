<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
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
		
	// 카트에 사진 불러오기
	String uploadPath = request.getServletContext().getRealPath("/upload");
	
	
	// OrdersDao 불러오기
	OrdersDao od = new OrdersDao();
	ArrayList<HashMap<String,Object>> ordersList = od.ordersList(customerNo);
		
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <title>주문내역</title>
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
	            <h1 class="display-4 fw-bolder">📦주문내역📦</h1>
	            <p class="lead fw-normal text-white-50 mb-0">🫢구매했던 상품의 리뷰를 등록해주시면 20% 할인 쿠폰을 드려요🫢</p>
	        </div>
	    </div>
	</header>
	
	<!-- 장바구니 부분 -->	
	<div class="container mt-3">
	
	<br>
	<!-- 상품 목록 -->
	<table class="table table-bordered table-hover" style="text-align:center; vertical-align: middle;">
		<thead>
			<tr>
			<th></th>
			<th>상품 이름</th>
	        <th>수량</th>
	        <th>합계</th>
	        <th>배송정보</th>
	        <th>리뷰 작성하기</th>
	        <th>주문 내역 삭제</th>
	      	</tr>
		</thead>
	<%
		for(HashMap<String, Object> map : ordersList){
			
	%>
		<tbody>
     		<tr>
        	<td><img src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" style="width: 60px; height: 60px;"></td>
        	<td><%=map.get("goodsTitle")%></td>
        	<td><%=map.get("quantity")%></td>
        	<td><mark><%=map.get("totalPrice")%>원</mark></td>
        	<td>배송완료</td>
        	<td><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/insertReviewForm.jsp?ordersNo=<%=map.get("ordersNo")%>">리뷰 작성</a></td>
      		<td><a class="btn btn-danger" href="<%=request.getContextPath()%>/deleteOrdersAction.jsp?ordersNo=<%=map.get("ordersNo")%>">삭제</a></td>
      		</tr>
    	</tbody>
	<%
       }
	%>
	
	</table>
	
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