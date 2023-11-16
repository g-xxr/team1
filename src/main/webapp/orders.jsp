<%@page import="dao.OrdersDao"%>
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
		
	// CustomerDao 불러오기
	CustomerDao ctd = new CustomerDao();
	ArrayList<HashMap<String,Object>> list = ctd.customerOne(customerNo);
	
	// CartDao 불러오기
	CartDao cd = new CartDao();
	ArrayList<HashMap<String,Object>> cartlist = cd.cartList(customerNo);
		
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
	            <h1 class="display-4 fw-bolder">📦주문/결제📦</h1>
	            <p class="lead fw-normal text-white-50 mb-0">🎉지금 결제하시면 20% 할인적용🎉<br>💖우리 샵 모든 상품 무료배송중💖</p>
	        </div>
	    </div>
	</header>
	
	<!-- 회원 배송지 부분 -->
	<div class="container mt-3">
 	<h2>주문 정보</h2>
        <%    
        for(HashMap<String, Object> c : list) {
        %>
        <div class="card">
		<div class="card-header"><%=c.get("customerName")%>&nbsp;&nbsp;<span class="badge bg-info">기본 배송지</span></div>
    	<div class="card-body">
    	<div><%=c.get("customerName")%> · <%=c.get("customerPhone")%></div>
    	<div class="text-secondary"><%=c.get("customerAddress")%></div>
  		</div>
  		</div>
        <% 
        }   
        %>
		</div>
		
	<!-- 주문상품 목록 부분 -->
	<div class="container mt-3">
	  <h2>주문 상품</h2>
	  <div id="accordion">
	    <div class="card">
	    
	      <div class="card-header">
	        <a class="btn" data-bs-toggle="collapse" href="#collapseOne">상품 확인하기</a>
	      </div>
	<%
		for(HashMap<String, Object> map : cartlist){
			int goodsPrice = (Integer) map.get("goodsPrice");
      		int quantity = (Integer) map.get("quantity");
      		int goodsSum = goodsPrice * quantity;
      		
      		totalPrice += goodsSum;
	%>
	<div id="collapseOne" class="collapse " data-bs-parent="#accordion">
    <div class="card-body">
        
        <div class="card" style="display: flex; flex-direction: row;">
          <!-- 왼쪽에 사진 -->
          <img src="<%=request.getContextPath()%>/upload/<%=map.get("filename")%>" style="width: 8%;">
          <!-- 오른쪽에 상품 정보 -->
          <div class="card-body" style="flex: 1;">
          <div><%=map.get("goodsTitle")%></div>
          <div><%=map.get("quantity")%>개</div>
          <div><mark><%=goodsSum%>원</mark></div>
          </div>
        </div>
    </div>
    </div>
	<%
	}
	%>
		
	      </div> 
	    </div>
	  </div>
	  
	<!-- 결제확인 창 -->
	<div class="container mt-3">
  	<h2>결제금액</h2>
  	<div class="card">
	    <div class="card-body" style="display: flex; justify-content: space-between;">
	    <div>상품금액 <br> 배송비 <br> 할인금액 </div>
	    <div style="text-align: right;"><%=totalPrice%> 원 <br> 0원 <br> (-)0원</div>
	    </div>
	    
	 	<div class="card-footer" style="display: flex; justify-content: space-between;">
	  	<div>총 결제금액</div>
	  	<div style="font-size: larger; font-weight: bold;">💰<%=totalPrice%> 원💰</div>
		</div>
	</div>
	</div>
	
	<!-- 결제버튼 클릭하면 결제 완료 alert 창 뜸 자바스크립트 이용 -->
	<div class="container mt-3">
	<div class="d-grid">
  	<a href="<%=request.getContextPath()%>/ordersAction.jsp?customerNo=<%=customerNo%>" class="btn btn-outline-primary btn-lg" id="pay" >💜결제하기💜</a>
	</div>
	<script>
		$('#pay').click(function(){
		alert('결제 완료!');
		});
	</script>
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