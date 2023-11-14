<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*"%>

<%	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	// goodsDao 호출
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
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>매니저 전용 상품 수정</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
	<!-- 관리자 메뉴 부분 -->
	<jsp:include page="/inc/managerMenu.jsp"></jsp:include>
		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-4">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">📑상품수정 페이지📑</h1>
	        	<p class="lead fw-normal text-white mb-0">상품 수정 후 관리자 채널에 공유 바랍니다</p>
	        </div>
	    </div>
	</header>
	
	<!-- 상품 수정 폼 -->
	<section>
	<div class="container mt-3">	
	<h2>💡상품 수정💡</h2>
	<form method="post" enctype="multipart/form-data"
		  action="<%=request.getContextPath()%>/updateGoodsAction.jsp?goodsNo=<%=g.getGoodsNo()%>">
		<div class="align-middle" style="width: 43%">
		
		<div class="container mt-3">
        	<h5><mark>상품 번호</mark></h5>
        	<h3><%=g.getGoodsNo()%></h3>
      	</div>
      	
      	<div class="container mt-3">
        	<img src="<%=request.getContextPath()%>/upload/<%=filename%>">
      	</div>
		
		<div class="container mt-3">
        	<h5><mark>상품 이름</mark></h5>
        	<input type="text" class="form-control"name="goodsTitle" value="<%=g.getGoodsTitle()%>">
      	</div>
  		
		<div class="container mt-3">
        	<h5><mark>상품 가격</mark></h5>
        	<input type="number" class="form-control"name="goodsPrice" value="<%=g.getGoodsPrice()%>">
      	</div>
		
		<div class="container mt-3">
			<h5><mark>상품 품절 여부(N/Y)</mark></h5>
  			<input type="radio" class="form-check-input" name="soldout" value="N" <% if (g.getSoldout().equals("N")) { %>checked<% } %>>
  			<label class="form-check-label" for="radio1">N(재고 있음)</label>
  			<br>
  			<input type="radio" class="form-check-input" name="soldout" value="Y" <% if (g.getSoldout().equals("Y")) { %>checked<% } %>>
  			<label class="form-check-label" for="radio2">Y(품절)</label>
		</div>
      	
		<div class="container mt-3">
        	<h5><mark>상품 설명</mark></h5>
        	<input type="text" class="form-control" id="goodsMemo" name="goodsMemo" value="<%=g.getGoodsMemo()%>" >
      	</div>
  		
  		<div class="container mt-3">
  			<h5><mark>상품 사진 입력 (사진 필수 등록)</mark></h5>
    		<input type="file" name="goodsImg">
  		</div>
  		</div>
  		<!-- 제출버튼 -->
  		<div class="container mt-3">
  		<button type="submit" class="btn btn-primary btn-lg">상품 수정하기</button>
  		</div>
	</form>
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