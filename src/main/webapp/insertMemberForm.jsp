<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 유정 -->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>회원가입 페이지</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
    
<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">📝회원가입 페이지📝</h1>
	            <p class="lead fw-normal text-white-50 mb-0">😃우리 샵의 가족이 되어주세요😃</p>
	        </div>
	    </div>
	</header>
	
	<br>
	<br>
	
	<div class="container text-center"><h1>회원 가입 선택</h1></div>
    
	<section>
	<div class="container px-4 px-lg-5 mt-5">
		<div class="row justify-content-center row-cols-1 row-cols-md-5 g-3">
		
			<!-- 고객 회원가입 -->
			<div class="col mb-3">
				<div class="card h-100">
	                <div class="card-body p-4 text-center">
	                <h3 class="fw-bolder">고객<br>회원가입</h3>
	                </div>
	                <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
	            	<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/insertCustomerForm.jsp">클릭!</a>
	      			</div>
            	</div>
			</div>
			
			<!-- 매니저 회원가입 -->
			<div class="col mb-3">
				<div class="card h-100">
	                <div class="card-body p-4 text-center">
	                <h3 class="fw-bolder">매니저<br>회원가입</h3>
	                </div>
	                <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
	            	<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/insertManagerForm.jsp">클릭!</a>
	      			</div>
            	</div>
			</div>
		</div>
	</div>
	</section>
	
	<br>
	<br>
	<br>
	
	<!-- 맨 아래 배너 -->
	<footer class="py-3 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭 </p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
