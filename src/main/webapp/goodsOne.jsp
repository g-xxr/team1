<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%@ page import ="vo.*" %>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	// goodsOne 호출
	GoodsDao gd = new GoodsDao();
	Goods g = gd.goodsOne(goodsNo);
	
	// goodsImg 호출 (사진 파일 가져와야 하기 때문에)
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
	            <h1 class="display-4 fw-bolder">🔍상품 상세보기🔍</h1>
	            <p class="lead fw-normal text-white mb-0">지금 구매하시면 20% 할인 쿠폰을 드려요🎫</p>
	        </div>
	    </div>
	</header>
	
	<!-- 상품 상세 정보 페이지 -->
	<div class="container mt-3">
	<br>
    <h1>상품 상세정보</h1>
    <br>
    <div class="card">
        <!-- 카드 내부를 그리드 시스템으로 나누기 -->
        <div class="row g-0">
            <!-- 왼쪽에 이미지를 포함한 열 -->
            <div class="col-md-6">
                <img class="card-img-top" src="<%=request.getContextPath()%>/upload/<%=filename%>" height= "640">
            </div>
            <!-- 오른쪽에 상세 정보를 포함한 열 -->
            <div class="col-md-6">
                <div class="card-body">
                    <!-- 상품 이름 -->
                    <div>
			   		<h1 class="fw-bolder"><%=g.getGoodsTitle()%></h1>
			   		</div>
                    <br>
                    
			    	<!-- 상품 가격 -->
			    	<div>
			    	<h5><mark>💰<%=g.getGoodsPrice()%>원💰</mark></h5>
			    	</div>
			    	<br>
			    	
			    	<!-- 상품 상세정보 -->
			    	<div style="height: 380px;">
			    	<p><%=g.getGoodsMemo()%></p>
			    	<p>지금 구매하시면 전 상품 무료배송!</p>
			    	</div>
			    	<br>
			    </div>
			    	<!-- 상품 관련 액션 -->
    				<div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
        			<div class="row">
            		<!-- 버튼을 포함한 6개의 그리드 -->
            		<div class="col-md-6">
                	<a class="btn btn-outline-dark btn-lg" href="<%=request.getContextPath()%>/goodsList.jsp">🔙다른상품 보기🔙</a>
            		</div>
            		<div class="col-md-6">
                	<a class="btn btn-outline-dark btn-lg" href="<%=request.getContextPath()%>/insertCartAction.jsp?goodsNo=<%=goodsNo%>">🧺장바구니 추가🧺</a>
            		</div>
        			</div>
    				</div>
    	
			</div>
		</div>	
     </div>
     </div>  
     <div class="container mt-3">
      <!-- 문의하기 폼으로 이동하는 링크 -->
    <a class="btn btn-outline-dark mt-auto" style="float:right" href="<%=request.getContextPath()%>/insertQuestionForm.jsp?goodsNo=${goodsNo}">문의하기</a>
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