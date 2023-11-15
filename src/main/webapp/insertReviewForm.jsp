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
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>리뷰게시판</title>
		<!-- 파비콘 코드 -->
		<link rel="icon" type="image/x-icon" href="assets/favicon.ico">
		<!-- 부트스트랩 아이콘 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
		<!-- 코어 테마 css -->
		<link href="css/styles.css" rel="stylesheet">
	</head>
	<body>
		<!-- 회원으로 접근할 때 보이는 메뉴바-->
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	<!-- 헤드 배너 부분 -->
	<header class="bg-dark py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="text-center text-white">
	            <h1 class="display-4 fw-bolder">🎊가을맞이 빅세일🎊</h1>
	            <p class="lead fw-normal text-white-50 mb-0">오늘도 즐거운 하루 되세요</p>
	        </div>
	    </div>
	</header>
	   <div class="container mb-3 mt-3 " > 
      <h2>상품리뷰 작성</h2>
        <form  action="<%=request.getContextPath()%>/insertReviewAction.jsp">	
          <div>                             	
		     <label for="comment">상품명:</label>
			 <input type="text" style="width:400px" class="form-control" name="questionTitle" readonly> 
			 <!-- value= 구매한 제품의 이름이 출력되도록 설정 필요 -->
		  	
		  	<label for="comment">리뷰내용:</label>
      		<textarea class="form-control" rows="5" name="questionContent"></textarea>
          </div>
          <br>
          <div style="float:right">
          <button class="btn btn-outline-dark mt-auto" type="submit">작성완료</button>         
          </div>         
        </form>			  
	</div>      
	  
	 <!-- Footer-->
	 <br>   
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
	
	
	
	
</body>
</html>