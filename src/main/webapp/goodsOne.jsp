<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%@ page import ="vo.*" %>

<%
	String goodsNoParam = request.getParameter("goodsNo");
	int goodsNo = 0;  // Default value, or any other appropriate default value
	
	if (goodsNoParam != null) {
	    try {
	        goodsNo = Integer.parseInt(goodsNoParam);
	    } catch (NumberFormatException e) {
	        // Handle the exception, e.g., log an error
	    }
	}
	
	// goodsOne 호출
	GoodsDao gd = new GoodsDao();
	Goods g = gd.goodsOne(goodsNo);
	
	// goodsImg dao
	GoodsDao goodsDao = new GoodsDao();
	String filename = goodsDao.getOldFilename(goodsNo);

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="">
        <meta name="author" content="">
        <title>상품 상세 정보</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
	<%
		if(session.getAttribute("customerId") == null){
	%>		
		<!-- 비회원으로 접근할 때 보이는 메뉴바 -->
		<jsp:include page="/menu.jsp"></jsp:include>
	<%		
		} else {
	%>
		<!-- 회원으로 접근할 때 보이는 메뉴바-->
		<jsp:include page="/privateMenu.jsp"></jsp:include>
	<%
		}
	%>
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🔍상품 상세보기🔍</h1>
	            <p class="lead fw-normal text-white mb-0">지금 구매하시면 20% 할인 쿠폰을 드려요🎫</p>
	        </div>
	    </div>
	</header>
	
	<!-- 상품 상세 정보 페이지 -->
	<section>
		<div class="container px-4 px-lg-5 mt-5">
		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			 <div class="col mb-5">
				<div class="card h-100">
			    <!-- 상품 이미지 -->
			    <img class="card-img-top" src="<%=request.getContextPath()%>/upload/<%=filename%>">
			    <!-- 상품 상세정보 -->
			    <div class="card-body p-4">
			    <div class="text-center">
			    <!-- 상품 이름 -->
			    <h5 class="fw-bolder">상품이름<%=g.getGoodsTitle()%></h5>
			    <!-- 상품 가격 -->
			    <mark>💰<%=g.getGoodsPrice()%>원💰</mark>
			    </div>
			    </div>
			    <!-- 상품 관련 액션 -->
			    <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
				<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/cart.jsp?goodsNo=<%=goodsNo%>">장바구니 추가</a>
				</div>
		    	</div>
			</div>
		</div>
		</div>
	</section>
	
</body>
</html>