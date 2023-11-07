<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
       
<title>홈페이지 팀플</title>
	
<!-- 파비콘 코드 -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
	
<!-- 부트스트랩 아이콘 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
	
<!-- 코어 테마 css -->
<link href="css/styles.css" rel="stylesheet">
</head>

<body>
	<!-- 메뉴 시작 (절대주소 적으세요)-->
	<jsp:include page="/menu.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
		
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>

	<!-- 홈페이지 맨 앞 부분 상품 정렬 (productList 알고리즘 쓰기) -->	
	<section>
	<div class="container px-4 px-lg-5 mt-5">
		<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<div class="col mb-5">
				<div class="card h-100">
					<!-- 베스트 상품 -->
                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">🏅</div>
	                <!-- 상품 이미지 -->
	                <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
	                <!-- 상품 상세정보 -->
	                <div class="card-body p-4">
	                <div class="text-center">
	                <!-- 상품 이름 -->
	                <h5 class="fw-bolder">테스트 상품</h5>
	                <!-- 상품 가격 -->
	                💰59,000원💰
	                </div>
	                </div>
	                <!-- Product actions-->
	                <div class="card-footer p-3 pt-0 border-top-0 bg-transparent text-center">
	            	<a class="btn btn-outline-dark mt-auto" href="#">상세보기</a>
	            	<a class="btn btn-outline-dark mt-auto" href="#">장바구니</a>
	      			</div>
            	</div>
			</div>
		</div>
	</div>
	</section>


	<!-- 맨 아래 배너 -->
	<footer class="py-5 bg-dark">
	<div class="container"><p class="m-0 text-center text-white"> Copyright &copy; 유정 도헌 유섭 </p></div>
	</footer>
	   
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	   
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>