<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
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
        <title>매니저 전용 상품 입력</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
	<!-- 관리자 메뉴 부분 -->
	<jsp:include page="/managerMenu.jsp"></jsp:include>
		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">📑상품입력 페이지📑</h1>
	        </div>
	    </div>
	</header>
	<br>
	<!-- 상품 입력 양식 폼 -->
	<div style="border:1px solid gray" class="container" >
	<br>
	
	<h3>상품 입력하기</h3>
	<form action="<%=request.getContextPath()%>/insertGoodsAction.jsp">
		
		<div class="mb-4 mt-4">
    		<label for="goodsTitle" class="form-label"><mark>상품 이름</mark></label>
    		<input type="text" class="form-control" id="goodsTitle" placeholder="상품이름을 입력하세요" name="goodsTitle">
  		</div>
  		
		<div class="mb-4 mt-4">
    		<label for="goodsPrice" class="form-label"><mark>상품 가격</mark></label>
    		<input type="number" class="form-control" id="goodsPrice" placeholder="상품가격을 입력하세요" name="goodsPrice">
  		</div>
		
		<div class="mb-4 mt-4">
    		<label for="goodsMemo" class="form-label"><mark>상품 설명</mark></label>
    		<input type="text" class="form-control" id="goodsMemo" placeholder="상품설명을 입력하세요" name="goodsMemo">
  		</div>
  		
  		<div class="mb-4 mt-4">
  			<mark>상품 사진 입력</mark>
  			<br>
    		<input type="file" name="goodsImg">
  		</div>
  		
  		<!-- 제출버튼 -->
  		<button type="submit" class="btn btn-primary">상품 등록하기</button>
	</form>
	</div>
</body>
</html>