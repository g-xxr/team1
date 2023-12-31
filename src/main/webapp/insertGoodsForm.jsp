<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>

<%
	String managerId = (String)(session.getAttribute("loginId")); // managerId를 loginId로 형변환 필수
	
	if(session.getAttribute("loginId") == null){  	// 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//ManagerDao md = new ManagerDao();
	//ArrayList<Manager> managerList = md.managerlist();
	
%>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>매니저 전용 상품 추가</title>
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
	            <h1 class="display-4 fw-bolder">📑상품추가 페이지📑</h1>
	        	<p class="lead fw-normal text-white mb-0">상품 추가 후 관리자 채널에 공유 바랍니다</p>
	        </div>
	    </div>
	</header>
	<br>
	
	<!-- 상품 추가 폼 -->
	<section>
	<div class="container mt-3">	
	<h3>상품 추가</h3>
	<form  method="post" enctype="multipart/form-data"
		   action="<%=request.getContextPath()%>/insertGoodsAction.jsp">
		<table class="table table-hover table-bordered align-middle" style="width: 50%;">
		<tr>
        	<td><label for="goodsTitle" class="form-label"><mark>상품 이름</mark></label></td>
        	<td><input type="text" class="form-control" id="goodsTitle" placeholder="상품이름을 입력하세요" name="goodsTitle"></td>
      	</tr>
  		
		<tr>
        	<td><label for="goodsPrice" class="form-label"><mark>상품 가격</mark></label></td>
        	<td><input type="number" class="form-control" id="goodsPrice" placeholder="상품가격을 입력하세요" name="goodsPrice"></td>
      	</tr>
		
		<tr>
        	<td><label for="goodsMemo" class="form-label"><mark>상품 설명</mark></label></td>
        	<td><input type="text" class="form-control" id="goodsMemo" placeholder="상품설명을 입력하세요" name="goodsMemo"></td>
      	</tr>
  		
  		<tr>
  			<td><mark>상품 사진 입력<br>(사진 필수 등록)</mark></td>
    		<td><input type="file" name="goodsImg"></td>
  		</tr>
  		</table>
  		<!-- 제출버튼 -->
  		<button type="submit" class="btn btn-primary">상품 등록하기</button>
	</form>
	</div>
	</section>

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