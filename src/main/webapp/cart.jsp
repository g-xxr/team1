<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<!-- 유정 -->

<%
	// 로그인한 고객만 접근 가능하게 하기
	int customerNo = 0;

	if(session.getAttribute("customerNo") == null){  // 현재 세션에 customerNo을 찾을 수 없다 -> 로그인 못함 -> 로그인 폼으로 가세요
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}else{
		customerNo = (Integer)session.getAttribute("customerNo");
	}
	
	// 카트에 사진 불러오기
	String uploadPath = request.getServletContext().getRealPath("/upload");
	
	// CartDao 불러오기
	CartDao cd = new CartDao();
	ArrayList<HashMap<String,Object>>list = cd.cartList(customerNo);
	
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
        <title>장바구니</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
	
	<!---- 로그인 시 보여지는 메뉴와 로그아웃 시 보여지는 메뉴 ---->
	<%
			if(session.getAttribute("customerNo") != null) {
			// 고객이 로그인한 상태라면
	%>
			<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	<% 	
			} else {
			// 고객이 로그아웃한 상태라면
	%>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	<% 	
			}
	%>
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🧺장바구니🧺</h1>
	            <p class="lead fw-normal text-white-50 mb-0">지금 구매하시면 20% 할인을 적용해드려요🎫</p>
	        </div>
	    </div>
	</header>
	
	<!-- 장바구니 부분 -->	
	<div class="container mt-3">
	<!-- 상품 추가 버튼 -->
	<div style="text-align: right;">
		<a class="btn btn-outline-dark btn-lg" href="<%=request.getContextPath()%>/goodsList.jsp">새로운 상품 추가하기</a>
	</div>
	<br>
	<!-- 상품 목록 -->
	<table class="table table-bordered table-hover" style="text-align:center; vertical-align: middle;">
		<thead>
			<tr>
			<th></th>
			<th>상품 이름</th>
	        <th>상품 가격</th>
	        <th>수량</th>
	        <th>합계</th>
	        <th>장바구니에서 삭제</th>
	      	</tr>
		</thead>
	<%
		for(HashMap<String, Object> map : list){
			
			int goodsPrice = (Integer) map.get("goodsPrice");
      		int quantity = (Integer) map.get("quantity");
      		int goodsSum = goodsPrice * quantity;
      		
      		totalPrice += goodsSum;
	%>
		<tbody>
     		<tr>
        	<td><img src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" style="width: 60px; height: 60px;"></td>
        	<td><%=map.get("goodsTitle")%></td>
        	<td><mark><%=map.get("goodsPrice")%>원</mark></td>
        	
        	<td>
			<%=map.get("quantity")%>
	  		</td>
        	
        	<td><%=goodsSum%>원</td>
        	<td><a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteCartAction.jsp?cartNo=<%=map.get("cartNo")%>">🗑️삭제🗑️</a></td>
      		</tr>
    	</tbody>
	<%
       }
	%>
	<!-- 담긴 장바구니 총 금액 표시 -->
		<tr>
			<td colspan="6">
			<span style="font-size: 24px; font-weight: bold; text-align: right; display: block;">💰총 <%=totalPrice%> 원💰</span>
			</td>
		</tr>
	</table>
	<!-- 주문하기 버튼 -->
		<div style="text-align: right;">
			<a class="btn btn-outline-dark btn-lg" href="<%=request.getContextPath()%>/orders.jsp">주문하기</a>
		</div>
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