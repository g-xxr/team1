<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String customerId = (String)(session.getAttribute("loginId")); 
	System.out.println(customerId + "<--customerId");
	
	if(session.getAttribute("loginId") == null){  // 본인 세션에 loginId를 만든적이 없다 -> 로그인 없다
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="">
        <meta name="author" content="">
        <title>리뷰 작성</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet">
    </head>
<body>
		<!-- 회원으로 접근할 때 보이는 메뉴바-->
		<jsp:include page="/inc/privateMenu.jsp"></jsp:include>
	
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-1">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">간단 리뷰 작성</h1>
	            <p class="lead fw-normal text-white-50 mb-0">리뷰를 작성하시면 20% 할인 쿠폰을 드려요🎫</p>
	        </div>
	    </div>
	</header>
	
	
	   <div class="container mb-3 mt-3 " > 
      <h2>간단 상품리뷰 작성</h2>
        <form  action="<%=request.getContextPath()%>/insertReviewAction.jsp">	
          <div>                             	
		     <label for="comment">상품명:</label>
			 <input type="text" style="width:400px" class="form-control" name="reviewTitle" readonly> 
			 <!-- value= 구매한 제품의 이름이 출력되도록 설정 필요 -->
		  	
		  	<label for="comment">리뷰내용:</label>
      		<textarea class="form-control" rows="5" name="reviewContent"></textarea>
          </div>
          <br>
          <div style="float:right">
          <button class="btn btn-outline-dark mt-auto" type="submit">작성완료</button>         
          </div>         
        </form>			  
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